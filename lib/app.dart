import 'package:Barter/presentation/screens/auth/forgot_password_screen.dart';
import 'package:Barter/presentation/screens/auth/login_screen.dart';
import 'package:Barter/presentation/screens/auth/new_password.dart';
import 'package:Barter/presentation/screens/auth/new_password_code.dart';
import 'package:Barter/presentation/screens/auth/sign_up_code.dart';
import 'package:Barter/presentation/screens/auth/sign_up_screen.dart';
import 'package:Barter/presentation/screens/onboarding_screen.dart';
import 'package:Barter/presentation/styles/theme/theme.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/home_screen.dart';

class BarterApp extends StatelessWidget {
  const BarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barter - Алмашуу',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => Login(),
        '/sign_up': (context) => SignUp(),
        '/forgot_password': (context) => ForgotPassword(),
        '/sign_up_code': (context) => SignUpCode(),
        '/new_password_code': (context) => NewPasswordCode(),
        'new_password': (context) => NewPassword(),
      },
      home: OnboardingSlide(),
      themeMode: ThemeMode.system,
      darkTheme: TAppTheme.darkTheme,
    );
  }
}
