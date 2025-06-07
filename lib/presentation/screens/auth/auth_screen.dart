import 'package:Barter/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 130),
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/birJolLogo.png',
                width: 46,
                height: 46,
              ),
            ),
            Text(
              '1Jol',
              style: TextStyle(
                color: Color(0xFF00D4AA),
                fontSize: 28,
                fontWeight: FontWeight.bold,
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
            CustomButton(
              text: 'Login',
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              backgroundColor: Color(0xFF00D4AA),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Sign up',
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              backgroundColor: Color(0xFF00D4AA),
            ),
          ],
        ),
      ),
    );
  }
}
