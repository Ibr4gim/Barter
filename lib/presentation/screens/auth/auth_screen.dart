import 'package:flutter/material.dart';
import 'package:my_project/presentation/widgets/custom_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromARGB(255, 5, 1, 9),
              Color.fromARGB(255, 42, 10, 60),
              Color.fromARGB(255, 75, 12, 96),
            ],
            stops: [0.0, 0.15, 0.37],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/duck.png',
                width: 46,
                height: 46,
              ),
            ),
            Text(
              'Barter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w700,
                fontFamily: 'NeueMachine',
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Barter is a platform for exchanging items you no longer need. List your stuff, like an old mouse, and discover what others offer in return. Simple, sustainable, and community-driven. ',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18, color: Colors.white, height: 1.5),
            ),
            SizedBox(height: 20, width: 70),
            CustomButtons(
              text: 'Войти в аккаунт',
              textColor: const Color.fromARGB(255, 5, 0, 0),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            SizedBox(height: 20),
            CustomButtons(
              text: 'Регистрация',
              textColor: Colors.lightGreenAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
