import 'package:flutter/material.dart';

class NewPasswordCode extends StatefulWidget {
  const NewPasswordCode({super.key});

  @override
  State<NewPasswordCode> createState() => _NewPasswordCodeState();
}

class _NewPasswordCodeState extends State<NewPasswordCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          
        ),
      ),
    );
  }
}
