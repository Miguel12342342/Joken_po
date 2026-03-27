import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../domain/entities/move.dart';
import '../cubit/game_state.dart';

/// Animação de slot machine — widget com Timer próprio.
///
/// Por que StatefulWidget e não Cubit-driven?
/// Animação é concern de apresentação pura. Ter o Cubit emitir estado
/// a cada 100ms causava 10 rebuilds/segundo em TODA a árvore
/// (BattleArea, ResultGlow, _PlayerMoveDisplay, ScoreBoard via BlocConsumer).
/// Agora apenas este widget reconstrói localmente durante o ciclo.
///
/// Fluxo:
///   GameThinking → _startCycling (Timer local, 140ms)
///   GameResult   → _revealResult (cancela timer, mostra resultado)
///   GameInitial  → _reset
///
/// Timing:
///   Ciclo: 140ms de intervalo, 50ms de fade → intervalo >> animação, sem overlap.
///   Reveal: 480ms com elasticOut → bounce premium na revelação.
class SlotMachineDisplay extends StatefulWidget {
  final GameState state;
  final Map<Move, String> assetPaths;

  const SlotMachineDisplay({
    super.key,
    required this.state,
    required this.assetPaths,
  });

  @override
  State<SlotMachineDisplay> createState() => _SlotMachineDisplayState();
}

class _SlotMachineDisplayState extends State<SlotMachineDisplay> {
  static const _defaultAsset = 'images/padrao.png';
  static const _cycleInterval = Duration(milliseconds: 140);
  static const _fadeDuration  = Duration(milliseconds: 50);
  static const _revealDuration = Duration(milliseconds: 480);

  final _random = Random();
  Timer? _cycleTimer;

  // Estado local da animação — não propaga para nenhum ancestral
  String _currentAsset = _defaultAsset;
  bool _isRevealing = false;
  int _animKey = 0; // contador inteiro — sem DateTime.now() em build()

  @override
  void initState() {
    super.initState();
    // Inicia imediatamente se o widget for montado já em GameThinking
    if (widget.state is GameThinking) _startCycling();
  }

  @override
  void didUpdateWidget(SlotMachineDisplay old) {
    super.didUpdateWidget(old);

    final nowThinking = widget.state is GameThinking;
    final wasThinking = old.state is GameThinking;
    final nowResult   = widget.state is GameResult;
    final nowInitial  = widget.state is GameInitial;

    if (nowThinking && !wasThinking) {
      _startCycling();
    } else if (nowResult && !_isRevealing) {
      _revealResult();
    } else if (nowInitial) {
      _reset();
    }
  }

  void _startCycling() {
    _cycleTimer?.cancel();
    _isRevealing = false;
    _cycleTimer = Timer.periodic(_cycleInterval, (_) {
      if (!mounted) return;
      final next = widget.assetPaths[
        Move.values[_random.nextInt(Move.values.length)]
      ]!;
      setState(() {
        _currentAsset = next;
        _animKey++;  // key inteira — nunca gera transição fantasma
      });
    });
  }

  void _revealResult() {
    _cycleTimer?.cancel();
    _isRevealing = true;
    if (widget.state case GameResult(:final roundResult)) {
      setState(() {
        _currentAsset = widget.assetPaths[roundResult.cpuMove]!;
        _animKey++;
      });
    }
  }

  void _reset() {
    _cycleTimer?.cancel();
    _isRevealing = false;
    setState(() {
      _currentAsset = _defaultAsset;
      _animKey++;
    });
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final imageSize = (size.width * 0.30).clamp(100.0, 150.0);

    return ClipRect(
      child: AnimatedSwitcher(
        // Ciclo: 50ms (<<140ms intervalo) → sem sobreposição de animações.
        // Reveal: 480ms elasticOut → bounce na revelação.
        duration: _isRevealing ? _revealDuration : _fadeDuration,
        // NUNCA colocar curvas que overshoot aqui (elasticOut, bounceOut…).
        // AnimatedSwitcher aplica switchInCurve ao animation ANTES de passar
        // ao transitionBuilder — se a curva produz t > 1.0, qualquer
        // CurvedAnimation filho que use esse animation como parent
        // chama curve.transform(1.09) e explode com assertion.
        // Regra: switchInCurve/switchOutCurve só recebem curvas bounded [0,1].
        // Curvas que overshoot devem ser aplicadas manualmente no transitionBuilder
        // APENAS nas propriedades que as suportam (scale sim, opacity não).
        switchInCurve:  Curves.linear,
        switchOutCurve: Curves.linear,
        transitionBuilder: (child, animation) {
          if (_isRevealing) {
            // Scale: elasticOut aplicado direto ao animation linear → pode
            // produzir scale > 1.0 (bounce) — ScaleTransition aceita.
            // Opacity: easeOut aplicado ao mesmo animation linear →
            // resultado sempre em [0, 1] — FadeTransition aceita.
            return ScaleTransition(
              scale: Tween<double>(begin: 0.6, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.elasticOut),
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
                child: child,
              ),
            );
          }
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
            child: child,
          );
        },
        // Key baseada em contador inteiro: muda a cada tick, nunca duplica,
        // e não depende de DateTime.now() dentro do build().
        child: Image.asset(
          _currentAsset,
          key: ValueKey(_animKey),
          height: imageSize,
          width: imageSize,
          fit: BoxFit.contain,
          // cacheWidth: evita decodificar a imagem repetidamente durante o ciclo
          cacheWidth: imageSize.toInt() * 2,
        ),
      ),
    );
  }
}
