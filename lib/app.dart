import 'package:flutter/material.dart';
import 'package:my_project/presentation/styles/theme/theme.dart';
import 'presentation/screens/home_screen.dart';

class BarterApp extends StatelessWidget {
  const BarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barter - Алмашуу',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
    );
  }
}
