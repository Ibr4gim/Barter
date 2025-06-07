import 'package:Barter/presentation/widgets/search_bottom.dart';
import 'package:Barter/presentation/widgets/search_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  late AnimationController _pulseController;

  bool _isSearching = false;
  String _selectedRideType = 'comfort';

  final List<Map<String, dynamic>> _nearbyRides = [
    {
      'driverName': 'Nurel B.',
      'rating': 4.8,
      'carModel': 'Toyota Camry',
      'price': 250,
      'arrivalTime': '2 мин',
      'seats': 3,
      'distance': '0.3 км',
    },
    {
      'driverName': 'Ibrash I.',
      'rating': 4.9,
      'carModel': 'Honda Civic',
      'price': 220,
      'arrivalTime': '5 мин',
      'seats': 2,
      'distance': '0.7 км',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          _buildMap(),
          SearchControls(
            fromController: _fromController,
            toController: _toController,
            selectedRideType: _selectedRideType,
            onRideTypeChanged: (rideType) {
              setState(() {
                _selectedRideType = rideType;
              });
            },
          ),
          SearchBottomSheet(
            isSearching: _isSearching,
            onSearchPressed: _searchForRides,
            nearbyRides: _nearbyRides,
            onBookRide: _bookRide,
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(42.8746, 74.5698),
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate:
              "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",
          subdomains: const ['a', 'b', 'c', 'd'],
        ),

        // MarkerLayer 
      ],
    );
  }

  void _searchForRides() {
    setState(() {
      _isSearching = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSearching = false;
      });
    });
  }

  void _bookRide(Map<String, dynamic> ride) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF2A2A2A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Бронирование поездки',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Забронировать поездку с ${ride['driverName']} за ${ride['price']} ₽?',
              style: TextStyle(color: Colors.grey[300]),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Отмена',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showBookingConfirmation(ride);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D4AA),
                  foregroundColor: Colors.black,
                ),
                child: const Text('Подтвердить'),
              ),
            ],
          ),
    );
  }

  void _showBookingConfirmation(Map<String, dynamic> ride) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Поездка с ${ride['driverName']} забронирована!'),
        backgroundColor: const Color(0xFF00D4AA),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
