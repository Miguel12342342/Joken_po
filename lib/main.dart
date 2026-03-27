import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'presentation/game/pages/game_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Força status bar transparente para imersão visual
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await configureDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JokenPô',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const GamePage(),
    );
  }
}
