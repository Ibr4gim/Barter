import 'package:Barter/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.bottomRight,
        //     end: Alignment.topLeft,
        //     colors: [
        //       Color.fromARGB(255, 5, 1, 9),
        //       Color.fromARGB(255, 42, 10, 60),
        //       Color.fromARGB(255, 75, 12, 96),
        //     ],
        //     stops: [0.0, 0.15, 0.37],
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 130),
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
                color: Color(0xFFCA4E80),
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
              style: TextStyle(fontSize: 18, color: Colors.black, height: 1.5),
            ),
            SizedBox(height: 20, width: 70),
            CustomButton(
              text: 'Login',
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              backgroundColor: Color(0xFFCA4E80),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Sign up',
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              backgroundColor: Color(0xFFCA4E80),
            ),
          ],
        ),
      ),
    );
  }
}
