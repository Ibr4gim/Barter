import 'package:BirJol/domain/models/ride_model.dart';
import 'package:flutter/material.dart';

class SearchControls extends StatelessWidget {
  final TextEditingController fromController;
  final TextEditingController toController;
  final RideType selectedRideType;
  final Function(RideType) onRideTypeChanged;
  final VoidCallback? onSearchPressed;
  final bool isSearching;

  const SearchControls({
    super.key,
    required this.fromController,
    required this.toController,
    required this.selectedRideType,
    required this.onRideTypeChanged,
    this.onSearchPressed,
    this.isSearching = false,
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
                const SizedBox(height: 16),
                _buildRideTypeSelector(),
                if (onSearchPressed != null) ...[
                  const SizedBox(height: 16),
                  _buildSearchButton(),
                ],
              ],
            ),
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

  Widget _buildRideTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildRideTypeChip(
            label: 'Эконом',
            type: RideType.economy,
            icon: Icons.attach_money,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRideTypeChip(
            label: 'Комфорт',
            type: RideType.comfort,
            icon: Icons.airline_seat_recline_normal,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRideTypeChip(
            label: 'Премиум',
            type: RideType.premium,
            icon: Icons.diamond,
          ),
        ),
      ],
    );
  }

  Widget _buildRideTypeChip({
    required String label,
    required RideType type,
    required IconData icon,
  }) {
    final isSelected = selectedRideType == type;
    return GestureDetector(
      onTap: () => onRideTypeChanged(type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00D4AA) : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF00D4AA) : Colors.grey[600]!,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.grey[400],
              size: 16,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey[400],
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isSearching ? null : onSearchPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D4AA),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isSearching
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : const Text(
                'Найти поездки',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
