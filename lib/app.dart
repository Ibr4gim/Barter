import 'package:flutter/material.dart';
import 'package:my_project/presentation/screens/auth/auth_screen.dart';
import 'package:my_project/presentation/screens/auth/forgot_password_screen.dart';
import 'package:my_project/presentation/screens/auth/login_screen.dart';
import 'package:my_project/presentation/screens/auth/new_password_code.dart';
import 'package:my_project/presentation/screens/auth/sign_up_code.dart';
import 'package:my_project/presentation/screens/auth/sign_up_screen.dart';
import 'package:my_project/presentation/styles/theme/theme.dart';
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
      },
      home: AuthScreen(),
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
    );
  }
}
