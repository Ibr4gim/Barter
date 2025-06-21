import 'package:flutter/material.dart';
import 'package:BirJol/domain/models/user_model.dart';
import 'package:BirJol/domain/models/ride_model.dart';

class AppStateProvider extends ChangeNotifier {
  UserModel? _currentUser;
  List<RideModel> _availableRides = [];
  List<RideModel> _myRides = [];
  List<RideModel> _bookedRides = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  UserModel? get currentUser => _currentUser;
  List<RideModel> get availableRides => _availableRides;
  List<RideModel> get myRides => _myRides;
  List<RideModel> get bookedRides => _bookedRides;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;

  // User Management
  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  void updateUserProfile(UserModel updatedUser) {
    _currentUser = updatedUser;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _availableRides.clear();
    _myRides.clear();
    _bookedRides.clear();
    notifyListeners();
  }

  // Ride Management
  void setAvailableRides(List<RideModel> rides) {
    _availableRides = rides;
    notifyListeners();
  }

  void addAvailableRide(RideModel ride) {
    _availableRides.add(ride);
    notifyListeners();
  }

  void removeAvailableRide(String rideId) {
    _availableRides.removeWhere((ride) => ride.id == rideId);
    notifyListeners();
  }

  void setMyRides(List<RideModel> rides) {
    _myRides = rides;
    notifyListeners();
  }

  void addMyRide(RideModel ride) {
    _myRides.add(ride);
    notifyListeners();
  }

  void updateMyRide(RideModel updatedRide) {
    final index = _myRides.indexWhere((ride) => ride.id == updatedRide.id);
    if (index != -1) {
      _myRides[index] = updatedRide;
      notifyListeners();
    }
  }

  void setBookedRides(List<RideModel> rides) {
    _bookedRides = rides;
    notifyListeners();
  }

  void addBookedRide(RideModel ride) {
    _bookedRides.add(ride);
    notifyListeners();
  }

  void removeBookedRide(String rideId) {
    _bookedRides.removeWhere((ride) => ride.id == rideId);
    notifyListeners();
  }

  // Loading and Error Management
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Utility Methods
  List<RideModel> getRidesByStatus(RideStatus status) {
    return _myRides.where((ride) => ride.status == status).toList();
  }

  List<RideModel> getUpcomingRides() {
    final now = DateTime.now();
    return _bookedRides
        .where((ride) => ride.departureTime.isAfter(now))
        .toList()
      ..sort((a, b) => a.departureTime.compareTo(b.departureTime));
  }

  List<RideModel> getPastRides() {
    final now = DateTime.now();
    return _bookedRides
        .where((ride) => ride.departureTime.isBefore(now))
        .toList()
      ..sort((a, b) => b.departureTime.compareTo(a.departureTime));
  }

  // Search and Filter Methods
  List<RideModel> searchRides({
    String? fromAddress,
    String? toAddress,
    DateTime? departureDate,
    RideType? rideType,
    double? maxPrice,
  }) {
    return _availableRides.where((ride) {
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
      return true;
    }).toList();
  }
} 