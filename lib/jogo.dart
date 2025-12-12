import 'dart:async'; 
import 'dart:math';
import 'package:flutter/material.dart';

enum Opcao { pedra, papel, tesoura }
enum Resultado { vitoria, derrota, empate }

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> with SingleTickerProviderStateMixin {
  
  // Cores personalizadas para o TEMA ESCURO
  final Color _corFundoPrincipal = Colors.grey.shade900; // Fundo escuro
  final Color _corPrimariaEscura = Colors.blueGrey.shade800; // AppBar escura
  final Color _corDestaque = Colors.yellowAccent; // Cor vibrante para títulos
  
  final Map<Opcao, String> _assetPaths = {
    Opcao.pedra: "images/pedra.png",
    Opcao.papel: "images/papel.png",
    Opcao.tesoura: "images/tesoura.png",
  };
  
  // Variáveis de Animação de Clique (Pulsar)
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  Opcao? _lastSelectedOption; 

  // Variáveis de Estado
  var _imagemApp = const AssetImage("images/padrao.png");
  var _mensagem = "Escolha uma opção abaixo para começar:";
  Color _corMensagem = Colors.white; // Cor padrão agora é branca no fundo escuro
  int _pontosUsuario = 0;
  int _pontosApp = 0;
  bool _isLoading = false; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- Lógica do Jogo ---

  void _setResultadoVisual(Resultado resultado) {
    setState(() {
      if (resultado == Resultado.vitoria) {
        _mensagem = "🎉 Parabéns!! Você GANHOU! 🎉";
        _corMensagem = Colors.lightGreenAccent; // Verde vibrante
        _pontosUsuario++;
      } else if (resultado == Resultado.derrota) {
        _mensagem = "VOCÊ PERDEU HAHAHA XD";
        _corMensagem = Colors.redAccent; // Vermelho vibrante
        _pontosApp++;
      } else {
        _mensagem = "EMPATAMOS ;P TENTE NOVAMENTE";
        _corMensagem = Colors.yellowAccent; // Amarelo vibrante
      }
    });
  }

  void _calcularResultadoFinal(Opcao escolhaUsuario) {
    var numero = Random().nextInt(Opcao.values.length);
    var escolhaApp = Opcao.values[numero];
    Resultado resultado;

    setState(() {
      _isLoading = false;
      _imagemApp = AssetImage(_assetPaths[escolhaApp]!);
    });

    if ((escolhaUsuario == Opcao.pedra && escolhaApp == Opcao.tesoura) ||
        (escolhaUsuario == Opcao.tesoura && escolhaApp == Opcao.papel) ||
        (escolhaUsuario == Opcao.papel && escolhaApp == Opcao.pedra)) {
      resultado = Resultado.vitoria;
    } else if (escolhaUsuario == escolhaApp) {
      resultado = Resultado.empate;
    } else {
      resultado = Resultado.derrota;
    }

    _setResultadoVisual(resultado);
  }

  void _iniciarAnimacaoESorteio(Opcao escolhaUsuario) {
    _controller.forward().then((_) => _controller.reverse());
    _lastSelectedOption = escolhaUsuario;
    
    setState(() {
      _isLoading = true;
      _mensagem = "App está escolhendo...";
      _corMensagem = _corDestaque; // Mensagem de loading com cor de destaque
    });

    int contagem = 0;
    Timer? timer;

    timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      if (contagem < 10) { 
        setState(() {
          var sorteioTemp = Random().nextInt(Opcao.values.length);
          _imagemApp = AssetImage(_assetPaths[Opcao.values[sorteioTemp]]!);
        });
        contagem++;
      } else {
        timer?.cancel();
        _calcularResultadoFinal(escolhaUsuario);
      }
    });
  }

  // --- Widgets e Estrutura ---

  Widget _buildOptionButton(Opcao escolha) {
    bool isSelected = _lastSelectedOption == escolha;
    
    Widget imageWidget = Image.asset(_assetPaths[escolha]!, height: 80);

    if (isSelected) {
        imageWidget = ScaleTransition(
          scale: _scaleAnimation,
          child: imageWidget,
        );
    }
    
    return InkWell(
      onTap: _isLoading ? null : () => _iniciarAnimacaoESorteio(escolha),
      child: imageWidget,
    );
  }

  void _resetarPlacar() {
    setState(() {
      _pontosUsuario = 0;
      _pontosApp = 0;
      _mensagem = "Escolha uma opção abaixo para começar:";
      _corMensagem = Colors.white;
      _imagemApp = const AssetImage("images/padrao.png");
      _lastSelectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TEMA ESCURO: Fundo escuro para maior contraste
      backgroundColor: _corFundoPrincipal, 
      
      appBar: AppBar(
        title: const Text(
          "JokenPo NIGHT MODE",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: _corPrimariaEscura, 
        foregroundColor: Colors.white, 
        elevation: 4, 
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Resetar Placar',
            onPressed: _resetarPlacar,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Placar em destaque com cor vibrante
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _corPrimariaEscura, // Fundo do placar mais escuro
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _corDestaque, width: 1.5), // Borda vibrante
                boxShadow: [
                  BoxShadow(
                    color: _corDestaque.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Placar: Você $_pontosUsuario x $_pontosApp App",
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: _corDestaque, // Texto do placar em cor vibrante
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Título App Choice
            Text(
              "Escolha do App",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                color: Colors.white70 // Texto claro
              ),
            ),

            const SizedBox(height: 15),
            
            // Imagem do App com Animação
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Image(
                key: ValueKey<AssetImage>(_imagemApp),
                image: _imagemApp,
                height: 120,
                // Aplicando um filtro para que as imagens se destaquem no fundo escuro (opcional)
                // color: Colors.white70, 
                // colorBlendMode: BlendMode.modulate,
              ),
            ),

            const SizedBox(height: 30),

            // Mensagem de Resultado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _mensagem,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26, 
                  fontWeight: FontWeight.w900,
                  color: _corMensagem, // Cores vibrantes (verde/vermelho/amarelo)
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: _corMensagem.withOpacity(0.7),
                      offset: const Offset(0.0, 0.0), // Sombra suave
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Título User Choice
            Text(
              "Sua Escolha:",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                color: Colors.white70
              ),
            ),

            const SizedBox(height: 20),
            
            // Opções do Jogador
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionButton(Opcao.pedra),
                  _buildOptionButton(Opcao.papel),
                  _buildOptionButton(Opcao.tesoura),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}