/// Entidade pura do domínio — zero dependência do Flutter.
///
/// [Move] é um enum Dart 3. Em Dart 3+, switches sobre enums são
/// **exaustivos por padrão**: o compilador emite um erro se qualquer
/// caso estiver faltando. Isso elimina toda uma classe de bugs
/// (o "caso esquecido") sem precisar de um `default` permissivo.
///
/// Prova: tente remover um `case` do switch em [resolveAgainst] —
/// o analisador acusará "The switch expression is not exhaustive" antes
/// mesmo de rodar o app.
enum Move {
  rock,
  paper,
  scissors;

  /// Determina o resultado desta jogada contra [opponent].
  ///
  /// Método puro: sem side effects, sem I/O, sem dependência de estado.
  /// Testável com uma única linha: `expect(rock.resolveAgainst(scissors), win)`.
  ///
  /// O switch expression aqui é exaustivo: o compilador sabe que [Move]
  /// tem exatamente 3 valores e verifica todos os 9 pares possíveis.
  GameOutcome resolveAgainst(Move opponent) => switch ((this, opponent)) {
    // Empates — mesmo gesto
    (Move.rock, Move.rock)         => GameOutcome.draw,
    (Move.paper, Move.paper)       => GameOutcome.draw,
    (Move.scissors, Move.scissors) => GameOutcome.draw,

    // Vitórias do jogador
    (Move.rock, Move.scissors)     => GameOutcome.win,  // Pedra quebra Tesoura
    (Move.scissors, Move.paper)    => GameOutcome.win,  // Tesoura corta Papel
    (Move.paper, Move.rock)        => GameOutcome.win,  // Papel embrulha Pedra

    // Derrotas do jogador (todos os casos restantes)
    (Move.scissors, Move.rock)     => GameOutcome.loss,
    (Move.paper, Move.scissors)    => GameOutcome.loss,
    (Move.rock, Move.paper)        => GameOutcome.loss,
  };
  // ↑ Se um nono par for adicionado no futuro (ex: jogo de 5 elementos),
  //   o compilador forçará a atualização deste switch. Sem risco silencioso.
}

/// Resultado possível de uma rodada do ponto de vista do jogador.
///
/// Também é um enum — portanto, qualquer switch sobre [GameOutcome]
/// na camada de apresentação é igualmente exaustivo.
enum GameOutcome { win, loss, draw }
