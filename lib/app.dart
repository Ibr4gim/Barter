import 'package:flutter/material.dart';
import 'package:my_project/presentation/screens/auth/auth_screen.dart';
import 'package:my_project/presentation/screens/auth/forgot_password_screen.dart';
import 'package:my_project/presentation/screens/auth/login_screen.dart';
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
      },
      home: AuthScreen(),
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:my_project/presentation/screens/onboarding_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:my_project/presentation/styles/theme/theme.dart';
// import 'presentation/screens/auth_screen.dart';

// class BarterApp extends StatelessWidget {
//   const BarterApp({super.key});

//   Future<bool> _checkIfOnboardingCompleted() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('onboarding_completed') ?? false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Barter - Алмашуу',
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: TAppTheme.lightTheme,
//       darkTheme: TAppTheme.darkTheme,
//       home: FutureBuilder<bool>(
//         future: _checkIfOnboardingCompleted(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }
//           final onboardingCompleted = snapshot.data ?? false;
//           return onboardingCompleted
//               ? const AuthScreen()
//               : const OnboardingSlide();
//         },
//       ),
//     );
//   }
// }
