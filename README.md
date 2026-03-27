# Jonken Po — Arquitetura Sênior Flutter

[![Linguagem](https://img.shields.io/badge/Language-Dart_3-blue.svg)](https://dart.dev/)
[![Framework](https://img.shields.io/badge/Framework-Flutter-02569B.svg)](https://flutter.dev/)
[![Arquitetura](https://img.shields.io/badge/Arch-Clean_Architecture-orange.svg)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![Estado](https://img.shields.io/badge/State-BLoC%2FCubit-purple.svg)](https://bloclibrary.dev/)
[![Licença](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**Jogo de Pedra, Papel e Tesoura (Janken Po) construído com Flutter como estudo de caso de arquitetura sênior.**

O projeto evolui de um único `StatefulWidget` monolítico para uma aplicação com **Clean Architecture**, **BLoC/Cubit**, **tratamento de erros tipado**, **persistência local** e **internacionalização** — priorizando testabilidade e contratos explícitos em cada camada.

---

## Demonstração

![Tela principal do Jonken Po](images/joken_po.png)

---

## Decisões Arquiteturais

### 1. Clean Architecture em 3 camadas

```
Domain  ←  Data  ←  Presentation
```

A camada **Domain** é Dart puro — zero imports do Flutter. Isso garante que a lógica de negócio possa ser testada sem precisar de `flutter_test`, emulador ou contexto de widget.

### 2. Contrato de Interface: `Move.resolveAgainst()` com switch exaustivo

```dart
// lib/domain/entities/move.dart
GameOutcome resolveAgainst(Move opponent) => switch ((this, opponent)) {
  (Move.rock, Move.scissors)     => GameOutcome.win,
  (Move.scissors, Move.paper)    => GameOutcome.win,
  (Move.paper, Move.rock)        => GameOutcome.win,
  (Move.rock, Move.paper)        => GameOutcome.loss,
  (Move.scissors, Move.rock)     => GameOutcome.loss,
  (Move.paper, Move.scissors)    => GameOutcome.loss,
  (Move.rock, Move.rock)         => GameOutcome.draw,
  (Move.paper, Move.paper)       => GameOutcome.draw,
  (Move.scissors, Move.scissors) => GameOutcome.draw,
};
```

O compilador Dart 3 **verifica a exaustividade** deste switch em tempo de compilação. Se um novo valor for adicionado ao enum sem atualizar o switch, o build falha — eliminando bugs de "caso esquecido" antes do runtime.

### 3. Error Handling com `sealed class` + `Result<T>`

Em vez de `try/catch` espalhados pela UI, toda falha é representada como um tipo no domínio:

```
domain/
├── failures/
│   └── failure.dart     # sealed class Failure { PersistenceFailure | CpuMoveFailure | UnexpectedFailure }
└── core/
    └── result.dart      # sealed class Result<T> { Ok<T> | Err<T> }
```

O `PlayRoundUseCase` nunca lança exceção — retorna `AsyncResult<RoundResult>`. O `GameCubit` consome com switch exaustivo:

```dart
switch (result) {
  case Ok(:final data):  emit(GameState.result(...));
  case Err(:final failure): emit(GameState.error(failure: failure));
  // Omitir qualquer case = erro de compilação
}
```

O estado `GameState.error` preserva o placar atual — o jogador não perde progresso por um erro de I/O.

### 4. Estados do Cubit (Freezed sealed)

```
GameInitial  →  GameThinking  →  GameResult
                             ↘  GameError
Qualquer estado  →  (reset)  →  GameInitial
```

Cada estado é um tipo distinto gerado pelo Freezed. A UI usa `switch` exaustivo — nenhum estado é ignorado silenciosamente.

---

## Performance Profiling com Flutter DevTools

Esta seção documenta as sessões de profiling realizadas durante o desenvolvimento das animações.

### Ferramenta utilizada: Flutter DevTools 2.x

```bash
# Habilitar DevTools durante desenvolvimento
flutter run --profile
# Em seguida, abrir a URL exibida no terminal no Chrome DevTools
```

### Widget Rebuilds — Repaint Rainbow

O **Repaint Rainbow** (`debugRepaintRainbowEnabled = true`) foi usado para identificar quais widgets eram reconstruídos desnecessariamente durante a animação do slot machine.

**Problema identificado:** O `ScoreBoard` (placar) repainting a cada tick do `Timer.periodic` de 100ms — 10 rebuilds por rodada sem necessidade, pois o placar não muda durante `GameThinking`.

**Solução aplicada:** Extrair `ScoreBoard` como widget separado e usar `BlocSelector` em vez de `BlocBuilder` completo:

```dart
// Antes — reconstrói ScoreBoard a cada estado GameThinking
BlocBuilder<GameCubit, GameState>(
  builder: (context, state) => Column(
    children: [
      ScoreBoard(playerScore: state.playerScore, ...), // rebuild desnecessário
      AppChoiceDisplay(state: state),
    ],
  ),
)

// Depois — ScoreBoard só reconstrói quando o placar realmente muda
BlocSelector<GameCubit, GameState, (int, int)>(
  selector: (state) => (state.playerScore, state.cpuScore),
  builder: (context, scores) => ScoreBoard(
    playerScore: scores.$1,
    cpuScore: scores.$2,
  ),
)
```

**Resultado:** ScoreBoard passa de ~10 rebuilds/rodada para 0-1 rebuilds/rodada.

### CustomPainter — Memory & Render Thread

O `ResultGlowPainter` (efeito de glow ao revelar resultado) foi monitorado na aba **Performance** do DevTools com foco no **Raster Thread**.

**Métrica observada:** Frame budget de 16ms (60fps).

| Cenário | Raster Thread (ms) | Observação |
|---|---|---|
| Sem glow (initial) | ~1.2ms | Baseline |
| Glow animado (resultado) | ~4.8ms | Dentro do budget |
| Glow SEM `shouldRepaint` otimizado | ~8.1ms | Overpainting |

**Otimização aplicada no `shouldRepaint`:**

```dart
@override
bool shouldRepaint(ResultGlowPainter old) =>
    old.intensity != intensity || old.glowColor != glowColor;
// Retornar `true` sempre = repaint em cada frame mesmo sem mudança visual
// Retornar a comparação real = repaint apenas quando necessário
```

### Memory Profiler — Hive Box

A aba **Memory** confirmou que o `Box<GameRoundModel>` do Hive não apresenta crescimento de heap entre rodadas — o adapter serializa/deserializa sem reter referências desnecessárias.

**Como reproduzir a análise:**
1. `flutter run --profile`
2. DevTools → Memory → Record
3. Jogar 20 rodadas consecutivas
4. Snapshot → verificar ausência de `GameRoundModel` retidos fora da box

---

## Estrutura do Projeto

```
lib/
├── core/
│   ├── di/            # GetIt + Injectable — registro automático
│   ├── theme/         # AppTheme centralizado
│   ├── router/        # go_router com deep linking
│   └── l10n/          # Arquivos .arb (pt, en) + flutter gen-l10n
│
├── domain/            # Dart puro — zero dependência do Flutter
│   ├── core/
│   │   └── result.dart          # sealed Result<T>: Ok | Err
│   ├── entities/
│   │   ├── move.dart            # enum Move + resolveAgainst() exaustivo
│   │   ├── round_result.dart    # Freezed value object
│   │   └── game_session.dart
│   ├── failures/
│   │   └── failure.dart         # sealed Failure hierarquia
│   ├── repositories/
│   │   └── game_history_repository.dart  # abstract interface
│   └── usecases/
│       ├── play_round_usecase.dart       # retorna AsyncResult<RoundResult>
│       └── get_history_usecase.dart
│
├── data/
│   ├── models/
│   │   └── game_round_model.dart   # @HiveType adapter
│   ├── datasources/
│   │   └── game_history_local_datasource.dart
│   └── repositories/
│       └── game_history_repository_impl.dart  # @LazySingleton
│
└── presentation/
    ├── game/
    │   ├── cubit/
    │   │   ├── game_cubit.dart     # @injectable
    │   │   └── game_state.dart     # @freezed sealed: initial|thinking|result|error
    │   ├── pages/
    │   │   └── game_page.dart
    │   └── widgets/
    │       ├── move_button.dart
    │       ├── app_choice_display.dart   # slot machine animation
    │       ├── score_board.dart          # BlocSelector otimizado
    │       ├── result_display.dart
    │       └── result_glow_painter.dart  # CustomPainter com shouldRepaint
    └── history/
        ├── cubit/
        └── pages/
            └── history_page.dart
```

---

## Tecnologias

| Camada | Pacote | Uso |
|---|---|---|
| State | `flutter_bloc` | Cubit + BlocSelector |
| Code Gen | `freezed` | Sealed states, value objects |
| DI | `get_it` + `injectable` | Registro e resolução automática |
| Persistência | `hive_flutter` | Box local com adapter gerado |
| Navegação | `go_router` | Deep linking, rotas nomeadas |
| i18n | `flutter_localizations` + `intl` | ARB → gen-l10n |
| Testes | `bloc_test` + `mocktail` | Unit + BLoC + Widget tests |

---

## Testes

```bash
# Todos os testes
flutter test

# Com cobertura
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Estratégia

| Tipo | Localização | O que testa |
|---|---|---|
| Unit | `test/domain/` | `Move.resolveAgainst` — todos os 9 pares |
| Unit | `test/domain/` | `PlayRoundUseCase` — Ok e Err paths |
| BLoC | `test/presentation/` | Emissão de estados: thinking → result, thinking → error |
| Widget | `test/presentation/` | MoveButton habilitado/desabilitado, GameError exibe mensagem |

---

## Instalação

```bash
# Clone
git clone https://github.com/Miguel12342342/Joken_po
cd jonken_po

# Dependências
flutter pub get

# Geração de código (Freezed + Hive + Injectable + l10n)
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# Executar
flutter run
```

---

## Contato

Miguel — [miguelpagy@gmail.com](mailto:miguelpagy@gmail.com)

Projeto: [github.com/Miguel12342342/Joken_po](https://github.com/Miguel12342342/Joken_po)
