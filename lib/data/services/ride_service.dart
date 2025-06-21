import 'dart:math';
import 'package:BirJol/domain/models/ride_model.dart';
import 'package:BirJol/domain/models/user_model.dart';

class RideService {
  // Mock data for demonstration - in real app, this would be API calls
  static final List<RideModel> _mockRides = [
    RideModel(
      id: '1',
      driver: UserModel(
        id: 'driver1',
        name: 'Nurel B.',
        email: 'nurel@example.com',
        rating: 4.8,
        totalRides: 156,
        carModel: 'Toyota Camry',
        carColor: 'Белый',
        licensePlate: '01A123BC',
        isDriver: true,
        isVerified: true,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
      ),
      passengers: [],
      from: Location(
        latitude: 42.8746,
        longitude: 74.5698,
        address: 'Бишкек, ул. Советская, 123',
      ),
      to: Location(
        latitude: 42.8846,
        longitude: 74.5798,
        address: 'Бишкек, ул. Чуй, 456',
      ),
      departureTime: DateTime.now().add(const Duration(hours: 2)),
      price: 250,
      availableSeats: 3,
      totalSeats: 4,
      rideType: RideType.comfort,
      status: RideStatus.searching,
      createdAt: DateTime.now(),
    ),
    RideModel(
      id: '2',
      driver: UserModel(
        id: 'driver2',
        name: 'Ibrash I.',
        email: 'ibrash@example.com',
        rating: 4.9,
        totalRides: 89,
        carModel: 'Honda Civic',
        carColor: 'Серебристый',
        licensePlate: '01B456DE',
        isDriver: true,
        isVerified: true,
        createdAt: DateTime.now().subtract(const Duration(days: 200)),
      ),
      passengers: [],
      from: Location(
        latitude: 42.8646,
        longitude: 74.5598,
        address: 'Бишкек, ул. Ибраимова, 789',
      ),
      to: Location(
        latitude: 42.8946,
        longitude: 74.5898,
        address: 'Бишкек, ул. Манаса, 321',
      ),
      departureTime: DateTime.now().add(const Duration(hours: 1)),
      price: 220,
      availableSeats: 2,
      totalSeats: 4,
      rideType: RideType.economy,
      status: RideStatus.searching,
      createdAt: DateTime.now(),
    ),
    RideModel(
      id: '3',
      driver: UserModel(
        id: 'driver3',
        name: 'Aibek K.',
        email: 'aibek@example.com',
        rating: 4.7,
        totalRides: 234,
        carModel: 'BMW X5',
        carColor: 'Черный',
        licensePlate: '01C789FG',
        isDriver: true,
        isVerified: true,
        createdAt: DateTime.now().subtract(const Duration(days: 500)),
      ),
      passengers: [],
      from: Location(
        latitude: 42.8546,
        longitude: 74.5498,
        address: 'Бишкек, ул. Абдрахманова, 654',
      ),
      to: Location(
        latitude: 42.9046,
        longitude: 74.5998,
        address: 'Бишкек, ул. Токтогула, 987',
      ),
      departureTime: DateTime.now().add(const Duration(hours: 3)),
      price: 350,
      availableSeats: 1,
      totalSeats: 4,
      rideType: RideType.premium,
      status: RideStatus.searching,
      createdAt: DateTime.now(),
    ),
  ];

  // Get all available rides
  static Future<List<RideModel>> getAvailableRides() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockRides.where((ride) => ride.isAvailable).toList();
  }

  // Search rides with filters
  static Future<List<RideModel>> searchRides({
    String? fromAddress,
    String? toAddress,
    DateTime? departureDate,
    RideType? rideType,
    double? maxPrice,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    return _mockRides.where((ride) {
      if (fromAddress != null && 
          !ride.from.address.toLowerCase().contains(fromAddress.toLowerCase())) {
        return false;
      }
      if (toAddress != null && 
          !ride.to.address.toLowerCase().contains(toAddress.toLowerCase())) {
        return false;
      }
      if (departureDate != null) {
        final rideDate = DateTime(
          ride.departureTime.year,
          ride.departureTime.month,
          ride.departureTime.day,
        );
        final searchDate = DateTime(
          departureDate.year,
          departureDate.month,
          departureDate.day,
        );
        if (rideDate != searchDate) return false;
      }
      if (rideType != null && ride.rideType != rideType) {
        return false;
      }
      if (maxPrice != null && ride.price > maxPrice) {
        return false;
      }
      return ride.isAvailable;
    }).toList();
  }

  // Book a ride
  static Future<bool> bookRide(String rideId, UserModel passenger) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    final rideIndex = _mockRides.indexWhere((ride) => ride.id == rideId);
    if (rideIndex == -1) return false;
    
    final ride = _mockRides[rideIndex];
    if (!ride.isAvailable) return false;
    
    // Update the ride with new passenger and status
    final updatedRide = ride.copyWith(
      passengers: [...ride.passengers, passenger],
      availableSeats: ride.availableSeats - 1,
      status: ride.availableSeats - 1 == 0 ? RideStatus.booked : RideStatus.searching,
      updatedAt: DateTime.now(),
    );
    
    _mockRides[rideIndex] = updatedRide;
    return true;
  }

  // Create a new ride
  static Future<RideModel?> createRide({
    required UserModel driver,
    required Location from,
    required Location to,
    required DateTime departureTime,
    required double price,
    required int totalSeats,
    required RideType rideType,
    String? notes,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    
    final newRide = RideModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      driver: driver,
      passengers: [],
      from: from,
      to: to,
      departureTime: departureTime,
      price: price,
      availableSeats: totalSeats,
      totalSeats: totalSeats,
      rideType: rideType,
      status: RideStatus.searching,
      notes: notes,
      createdAt: DateTime.now(),
    );
    
    _mockRides.add(newRide);
    return newRide;
  }

  // Get ride by ID
  static Future<RideModel?> getRideById(String rideId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockRides.firstWhere((ride) => ride.id == rideId);
    } catch (e) {
      return null;
    }
  }

  // Cancel a ride
  static Future<bool> cancelRide(String rideId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final rideIndex = _mockRides.indexWhere((ride) => ride.id == rideId);
    if (rideIndex == -1) return false;
    
    final ride = _mockRides[rideIndex];
    
    // Check if user is the driver or a passenger
    if (ride.driver.id == userId) {
      // Driver cancelling the entire ride
      _mockRides[rideIndex] = ride.copyWith(
        status: RideStatus.cancelled,
        updatedAt: DateTime.now(),
      );
    } else {
      // Passenger cancelling their booking
      final updatedPassengers = ride.passengers
          .where((passenger) => passenger.id != userId)
          .toList();
      
      _mockRides[rideIndex] = ride.copyWith(
        passengers: updatedPassengers,
        availableSeats: ride.availableSeats + 1,
        status: RideStatus.searching,
        updatedAt: DateTime.now(),
      );
    }
    
    return true;
  }

  // Get nearby rides based on location
  static Future<List<RideModel>> getNearbyRides({
    required double latitude,
    required double longitude,
    double radiusKm = 5.0,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return _mockRides.where((ride) {
      final distance = _calculateDistance(
        latitude, longitude,
        ride.from.latitude, ride.from.longitude,
      );
      return distance <= radiusKm && ride.isAvailable;
    }).toList();
  }

  // Calculate distance between two points using Haversine formula
  static double _calculateDistance(
    double lat1, double lon1,
    double lat2, double lon2,
  ) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);
    
    final lat1Rad = _degreesToRadians(lat1);
    final lat2Rad = _degreesToRadians(lat2);
    
    final a = sin(dLat / 2) * sin(dLat / 2) +
        sin(lat1Rad) * sin(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
} 