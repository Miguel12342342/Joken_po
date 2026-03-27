import 'package:flutter/material.dart';

/// Paleta central do app — neumorphic escuro com acento neon.
///
/// Neumorphism precisa de 3 camadas de cor por superfície:
///   [surface]      → cor base do elemento
///   [shadowDark]   → sombra que simula profundidade (bottom-right)
///   [shadowLight]  → sombra que simula iluminação (top-left)
/// A diferença entre [background] e [surface] deve ser mínima (~10%)
/// para o efeito de relevo funcionar.
abstract final class AppColors {
  // Base
  static const background  = Color(0xFF1A1A2E);
  static const surface     = Color(0xFF1F1F38);
  static const surfaceHigh = Color(0xFF252545);

  // Neumorphic shadows
  static const shadowDark  = Color(0xFF0F0F1E);
  static const shadowLight = Color(0xFF2E2E52);

  // Accents
  static const accent = Color(0xFFF5C542);  // gold

  // Game outcomes
  static const win  = Color(0xFF4ADE80);  // emerald-400
  static const loss = Color(0xFFF87171);  // red-400
  static const draw = Color(0xFFFBBF24);  // amber-400

  // Text
  static const textPrimary   = Color(0xFFE2E8F0);
  static const textSecondary = Color(0xFF94A3B8);
}

abstract final class AppTheme {
  static ThemeData get dark => ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: 1.5,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.surfaceHigh,
        ),
        colorScheme: const ColorScheme.dark(
          surface: AppColors.surface,
          primary: AppColors.accent,
        ),
      );
}

/// Helpers para BoxDecoration neumorphic — evita repetição nos widgets.
abstract final class Neumorphic {
  /// Superfície elevada: parece flutuar sobre o fundo.
  static BoxDecoration elevated({
    double radius = 20,
    Color? accentGlow,
  }) =>
      BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            offset: const Offset(8, 8),
            blurRadius: 20,
          ),
          BoxShadow(
            color: AppColors.shadowLight,
            offset: const Offset(-8, -8),
            blurRadius: 20,
          ),
          if (accentGlow != null)
            BoxShadow(
              color: accentGlow.withValues(alpha: 0.35),
              blurRadius: 24,
              spreadRadius: 2,
            ),
        ],
      );

  /// Superfície pressionada: efeito inset — parece afundar no fundo.
  static BoxDecoration pressed({double radius = 20}) => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF161626), // mais escuro no topo
            Color(0xFF252545), // mais claro embaixo
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark.withValues(alpha: 0.9),
            offset: const Offset(3, 3),
            blurRadius: 8,
            spreadRadius: -2,
          ),
          BoxShadow(
            color: AppColors.shadowLight.withValues(alpha: 0.6),
            offset: const Offset(-3, -3),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      );
}
