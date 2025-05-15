import 'package:flutter/material.dart';

class AnimatedAddToCartButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AnimatedAddToCartButton({super.key, required this.onPressed});

  @override
  State<AnimatedAddToCartButton> createState() =>
      _AnimatedAddToCartButtonState();
}

class _AnimatedAddToCartButtonState extends State<AnimatedAddToCartButton> {
  bool _isAdded = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          _isAdded = true;
        });
        widget.onPressed();
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            setState(() {
              _isAdded = false;
            });
          }
        });
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          _isAdded ? Icons.check : Icons.add_shopping_cart,
          key: ValueKey<bool>(_isAdded),
          size: 20.0,
        ),
      ),
      label: Text(_isAdded ? 'Added!' : 'Add to Cart'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
