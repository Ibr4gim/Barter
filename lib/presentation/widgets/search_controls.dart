import 'package:flutter/material.dart';
import 'ride_type_selector.dart';

class SearchControls extends StatelessWidget {
  final TextEditingController fromController;
  final TextEditingController toController;
  final String selectedRideType;
  final Function(String) onRideTypeChanged;

  const SearchControls({
    super.key,
    required this.fromController,
    required this.toController,
    required this.selectedRideType,
    required this.onRideTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildTextField(
                  controller: fromController,
                  hintText: 'Откуда',
                  icon: Icons.radio_button_checked,
                  iconColor: const Color(0xFF00D4AA),
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: toController,
                  hintText: 'Куда',
                  icon: Icons.location_on,
                  iconColor: Colors.red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RideTypeSelector(
            selectedRideType: selectedRideType,
            onRideTypeChanged: onRideTypeChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
          prefixIcon: Icon(icon, color: iconColor, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}