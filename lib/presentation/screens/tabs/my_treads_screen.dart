import 'package:flutter/material.dart';
import 'package:Barter/presentation/widgets/custom_card.dart';

class MyTradesScreen extends StatelessWidget {
  const MyTradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ProductCard(
            imagePath: 'assets/images/duck.png',
            title: 'Мой товар 1',
            price: 29.99,
            onTap: () {},
            backgroundColor: Colors.blue,
            width: MediaQuery.of(context).size.width * 0.90,
          ),
          ProductCard(
            imagePath: 'assets/images/duck.png',
            title: 'Мой товар 2',
            price: 39.99,
            onTap: () {},
            backgroundColor: Colors.red,
            width: MediaQuery.of(context).size.width * 0.90,
          ),
        ],
      ),
    );
  }
}
