import 'user_model.dart';

enum RideStatus {
  searching,
  booked,
  inProgress,
  completed,
  cancelled,
}

enum RideType {
  comfort,
  economy,
  premium,
}

class Location {
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}

class RideModel {
  final String id;
  final UserModel driver;
  final List<UserModel> passengers;
  final Location from;
  final Location to;
  final DateTime departureTime;
  final DateTime? arrivalTime;
  final double price;
  final int availableSeats;
  final int totalSeats;
  final RideType rideType;
  final RideStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  RideModel({
    required this.id,
    required this.driver,
    required this.passengers,
    required this.from,
    required this.to,
    required this.departureTime,
    this.arrivalTime,
    required this.price,
    required this.availableSeats,
    required this.totalSeats,
    required this.rideType,
    required this.status,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'] ?? '',
      driver: UserModel.fromJson(json['driver'] ?? {}),
      passengers: (json['passengers'] as List<dynamic>?)
          ?.map((passenger) => UserModel.fromJson(passenger))
          .toList() ?? [],
      from: Location.fromJson(json['from'] ?? {}),
      to: Location.fromJson(json['to'] ?? {}),
      departureTime: DateTime.parse(json['departureTime']),
      arrivalTime: json['arrivalTime'] != null 
          ? DateTime.parse(json['arrivalTime']) 
          : null,
      price: (json['price'] ?? 0.0).toDouble(),
      availableSeats: json['availableSeats'] ?? 0,
      totalSeats: json['totalSeats'] ?? 0,
      rideType: RideType.values.firstWhere(
        (type) => type.toString() == 'RideType.${json['rideType']}',
        orElse: () => RideType.comfort,
      ),
      status: RideStatus.values.firstWhere(
        (status) => status.toString() == 'RideStatus.${json['status']}',
        orElse: () => RideStatus.searching,
      ),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver': driver.toJson(),
      'passengers': passengers.map((passenger) => passenger.toJson()).toList(),
      'from': from.toJson(),
      'to': to.toJson(),
      'departureTime': departureTime.toIso8601String(),
      'arrivalTime': arrivalTime?.toIso8601String(),
      'price': price,
      'availableSeats': availableSeats,
      'totalSeats': totalSeats,
      'rideType': rideType.toString().split('.').last,
      'status': status.toString().split('.').last,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  RideModel copyWith({
    String? id,
    UserModel? driver,
    List<UserModel>? passengers,
    Location? from,
    Location? to,
    DateTime? departureTime,
    DateTime? arrivalTime,
    double? price,
    int? availableSeats,
    int? totalSeats,
    RideType? rideType,
    RideStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RideModel(
      id: id ?? this.id,
      driver: driver ?? this.driver,
      passengers: passengers ?? this.passengers,
      from: from ?? this.from,
      to: to ?? this.to,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      price: price ?? this.price,
      availableSeats: availableSeats ?? this.availableSeats,
      totalSeats: totalSeats ?? this.totalSeats,
      rideType: rideType ?? this.rideType,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isFull => availableSeats <= 0;
  bool get isAvailable => status == RideStatus.searching && !isFull;
  String get rideTypeDisplay {
    switch (rideType) {
      case RideType.comfort:
        return 'Комфорт';
      case RideType.economy:
        return 'Эконом';
      case RideType.premium:
        return 'Премиум';
    }
  }
} 