class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final double rating;
  final int totalRides;
  final String? carModel;
  final String? carColor;
  final String? licensePlate;
  final bool isDriver;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? lastActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.rating = 0.0,
    this.totalRides = 0,
    this.carModel,
    this.carColor,
    this.licensePlate,
    this.isDriver = false,
    this.isVerified = false,
    required this.createdAt,
    this.lastActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalRides: json['totalRides'] ?? 0,
      carModel: json['carModel'],
      carColor: json['carColor'],
      licensePlate: json['licensePlate'],
      isDriver: json['isDriver'] ?? false,
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      lastActive: json['lastActive'] != null 
          ? DateTime.parse(json['lastActive']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'rating': rating,
      'totalRides': totalRides,
      'carModel': carModel,
      'carColor': carColor,
      'licensePlate': licensePlate,
      'isDriver': isDriver,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    double? rating,
    int? totalRides,
    String? carModel,
    String? carColor,
    String? licensePlate,
    bool? isDriver,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? lastActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      rating: rating ?? this.rating,
      totalRides: totalRides ?? this.totalRides,
      carModel: carModel ?? this.carModel,
      carColor: carColor ?? this.carColor,
      licensePlate: licensePlate ?? this.licensePlate,
      isDriver: isDriver ?? this.isDriver,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }
} 