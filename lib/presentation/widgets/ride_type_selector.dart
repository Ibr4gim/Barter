import 'package:flutter/material.dart';

class RideTypeSelector extends StatelessWidget {
  final String selectedRideType;
  final Function(String) onRideTypeChanged;

  const RideTypeSelector({
    super.key,
    required this.selectedRideType,
    required this.onRideTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final rideTypes = [
      {'id': 'economy', 'name': 'Эконом', 'icon': Icons.directions_car},
      {'id': 'comfort', 'name': 'Комфорт', 'icon': Icons.local_taxi},
      {'id': 'business', 'name': 'Бизнес', 'icon': Icons.car_rental},
    ];

    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rideTypes.length,
        itemBuilder: (context, index) {
          final rideType = rideTypes[index];
          final isSelected = selectedRideType == rideType['id'];

          return GestureDetector(
            onTap: () => onRideTypeChanged(rideType['id'] as String),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? const Color(0xFF00D4AA)
                    : const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(30),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF00D4AA).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    rideType['icon'] as IconData,
                    color: isSelected ? Colors.black : Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    rideType['name'] as String,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}