// import 'package:BirJol/presentation/widgets/search_bottom.dart';
import 'package:BirJol/presentation/widgets/search_controls.dart';
import 'package:BirJol/presentation/widgets/ride_card.dart';
import 'package:BirJol/domain/models/ride_model.dart';
import 'package:BirJol/data/services/ride_service.dart';
import 'package:BirJol/application/providers/app_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shimmer/shimmer.dart';

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
  bool _showMap = true;
  RideType _selectedRideType = RideType.comfort;
  List<RideModel> _searchResults = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    // Load initial rides
    _loadAvailableRides();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _loadAvailableRides() async {
    try {
      final rides = await RideService.getAvailableRides();
      setState(() {
        _searchResults = rides;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = 'Ошибка загрузки поездок';
      });
    }
  }

  Future<void> _searchForRides() async {
    if (_fromController.text.isEmpty && _toController.text.isEmpty) {
      await _loadAvailableRides();
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
    });

    try {
      final rides = await RideService.searchRides(
        fromAddress: _fromController.text.isNotEmpty ? _fromController.text : null,
        toAddress: _toController.text.isNotEmpty ? _toController.text : null,
        rideType: _selectedRideType,
      );
      
      setState(() {
        _searchResults = rides;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Ошибка поиска поездок';
        _isSearching = false;
      });
    }
  }

  void _onRideTypeChanged(RideType rideType) {
    setState(() {
      _selectedRideType = rideType;
    });
    _searchForRides();
  }

  void _toggleView() {
    setState(() {
      _showMap = !_showMap;
    });
  }

  void _bookRide(RideModel ride) async {
    final appState = Provider.of<AppStateProvider>(context, listen: false);
    final currentUser = appState.currentUser;
    
    if (currentUser == null) {
      _showLoginDialog();
      return;
    }

    final confirmed = await _showBookingConfirmation(ride);
    if (!confirmed) return;

    setState(() {
      _isSearching = true;
    });

    try {
      final success = await RideService.bookRide(ride.id, currentUser);
      if (success) {
        // Update the ride in search results
        final updatedRide = ride.copyWith(
          availableSeats: ride.availableSeats - 1,
          passengers: [...ride.passengers, currentUser],
          status: ride.availableSeats - 1 == 0 ? RideStatus.booked : RideStatus.searching,
        );
        
        setState(() {
          final index = _searchResults.indexWhere((r) => r.id == ride.id);
          if (index != -1) {
            _searchResults[index] = updatedRide;
          }
          _isSearching = false;
        });

        _showSuccessMessage('Поездка забронирована!');
        
        // Add to booked rides in app state
        appState.addBookedRide(updatedRide);
      } else {
        _showErrorMessage('Не удалось забронировать поездку');
      }
    } catch (e) {
      _showErrorMessage('Ошибка при бронировании');
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Требуется авторизация',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Для бронирования поездки необходимо войти в аккаунт',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D4AA),
              foregroundColor: Colors.black,
            ),
            child: const Text('Войти'),
          ),
        ],
      ),
    );
  }

  Future<bool> _showBookingConfirmation(RideModel ride) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Бронирование поездки',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Водитель: ${ride.driver.name}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Маршрут: ${ride.from.address} → ${ride.to.address}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Цена: ${ride.price} ₽',
              style: const TextStyle(color: Color(0xFF00D4AA), fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Время отправления: ${_formatDateTime(ride.departureTime)}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D4AA),
              foregroundColor: Colors.black,
            ),
            child: const Text('Подтвердить'),
          ),
        ],
      ),
    ) ?? false;
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF00D4AA),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')} в ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          if (_showMap) _buildMap(),
          if (!_showMap) _buildListView(),
          SearchControls(
            fromController: _fromController,
            toController: _toController,
            selectedRideType: _selectedRideType,
            onRideTypeChanged: _onRideTypeChanged,
            onSearchPressed: _searchForRides,
            isSearching: _isSearching,
          ),
          _buildBottomSheet(),
          _buildToggleButton(),
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
          urlTemplate: "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",
          subdomains: const ['a', 'b', 'c', 'd'],
        ),
        MarkerLayer(
          markers: _searchResults.map((ride) => Marker(
            point: LatLng(ride.from.latitude, ride.from.longitude),
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () => _showRideDetails(ride),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF00D4AA),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildListView() {
    if (_isSearching) {
      return _buildLoadingList();
    }

    if (_error != null) {
      return _buildErrorView();
    }

    if (_searchResults.isEmpty) {
      return _buildEmptyView();
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 200, bottom: 200),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final ride = _searchResults[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: RideCard(
            ride: ride,
            onBookPressed: () => _bookRide(ride),
            onTap: () => _showRideDetails(ride),
          ),
        );
      },
    );
  }

  Widget _buildLoadingList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 200, bottom: 200),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[700]!,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            _error!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadAvailableRides,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D4AA),
              foregroundColor: Colors.black,
            ),
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            color: Colors.grey,
            size: 64,
          ),
          const SizedBox(height: 16),
          const Text(
            'Поездки не найдены',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            'Попробуйте изменить параметры поиска',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Найдено поездок: ${_searchResults.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_isSearching)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4AA)),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    return Positioned(
      top: 120,
      right: 16,
      child: FloatingActionButton(
        onPressed: _toggleView,
        backgroundColor: const Color(0xFF1E1E1E),
        child: Icon(
          _showMap ? Icons.list : Icons.map,
          color: const Color(0xFF00D4AA),
        ),
      ),
    );
  }

  void _showRideDetails(RideModel ride) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDriverInfo(ride),
                    const SizedBox(height: 24),
                    _buildRideInfo(ride),
                    const SizedBox(height: 24),
                    _buildActionButtons(ride),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverInfo(RideModel ride) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color(0xFF00D4AA),
          child: Text(
            ride.driver.name.split(' ').first[0],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ride.driver.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xFF00D4AA),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${ride.driver.rating} (${ride.driver.totalRides} поездок)',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              if (ride.driver.carModel != null) ...[
                const SizedBox(height: 4),
                Text(
                  '${ride.driver.carModel} • ${ride.driver.carColor}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRideInfo(RideModel ride) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Детали поездки',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoRow(Icons.location_on, 'Откуда', ride.from.address),
        const SizedBox(height: 12),
        _buildInfoRow(Icons.location_on_outlined, 'Куда', ride.to.address),
        const SizedBox(height: 12),
        _buildInfoRow(Icons.access_time, 'Время', _formatDateTime(ride.departureTime)),
        const SizedBox(height: 12),
        _buildInfoRow(Icons.airline_seat_recline_normal, 'Места', '${ride.availableSeats} из ${ride.totalSeats}'),
        const SizedBox(height: 12),
        _buildInfoRow(Icons.category, 'Тип', ride.rideTypeDisplay),
        const SizedBox(height: 12),
        _buildInfoRow(Icons.payments, 'Цена', '${ride.price} ₽'),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00D4AA), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(RideModel ride) {
    return Column(
      children: [
        if (ride.isAvailable)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _bookRide(ride);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D4AA),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Забронировать',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement chat functionality
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF00D4AA),
              side: const BorderSide(color: Color(0xFF00D4AA)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Написать водителю',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
