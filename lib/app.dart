import 'package:BirJol/presentation/screens/auth/forgot_password_screen.dart';
import 'package:BirJol/presentation/screens/auth/login_screen.dart';
import 'package:BirJol/presentation/screens/auth/new_password.dart';
import 'package:BirJol/presentation/screens/auth/new_password_code.dart';
import 'package:BirJol/presentation/screens/auth/sign_up_code.dart';
import 'package:BirJol/presentation/screens/auth/sign_up_screen.dart';
import 'package:BirJol/presentation/screens/onboarding_screen.dart';
import 'package:BirJol/presentation/screens/tabs/search_screen.dart';
import 'package:BirJol/presentation/styles/theme/theme.dart';
import 'package:BirJol/application/providers/app_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/home_screen.dart';

class BirJolApp extends StatelessWidget {
  const BirJolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppStateProvider(),
      child: MaterialApp(
        title: 'BirJol',
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/home': (context) => HomeScreen(),
          '/login': (context) => Login(),
          '/sign_up': (context) => SignUp(),
          '/forgot_password': (context) => ForgotPassword(),
          '/sign_up_code': (context) => SignUpCode(),
          '/new_password_code': (context) => NewPasswordCode(),
          '/new_password': (context) => NewPassword(),
          '/search_screen': (context) => SearchScreen(),
        },
        home: OnboardingSlide(),
        themeMode: ThemeMode.system,
        darkTheme: TAppTheme.darkTheme,
      ),
    );
  }
}
