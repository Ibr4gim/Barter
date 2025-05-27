import 'package:flutter/material.dart';
import 'package:Barter/presentation/widgets/custom_card.dart';

class CartTabScreen extends StatelessWidget {
  const CartTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Column(
          children: [
            ProductCard(
              imagePath: 'assets/images/duck.png',
              title: 'Product 1',
              price: 29.99,
              onTap: () {},
              backgroundColor: Colors.lightGreenAccent,
              width: MediaQuery.of(context).size.width * 0.90,
            ),
            ProductCard(
              imagePath: 'assets/images/duck.png',
              title: 'Product 2',
              price: 39.99,
              onTap: () {},
              backgroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.90,
            ),
          ],
        ),
      ],
    );
  }
}
