import 'package:flutter/material.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Product 1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                const Text('Price: \$19.99'),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    print('Added Product 1 to cart');
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Product 2',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                const Text('Price: \$29.99'),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    print('Added Product 2 to cart');
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
