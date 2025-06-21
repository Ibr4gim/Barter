/// Feature flags for the BirJol app
/// 
/// This file allows you to easily enable/disable features
/// without modifying the core code. Simply change the boolean
/// values to control which features are active.
class FeatureFlags {
  // Core Features
  static const bool enableRideSearch = true;
  static const bool enableRideBooking = true;
  static const bool enableUserAuthentication = true;
  static const bool enableMaps = true;
  
  // Enhanced Features
  static const bool enablePushNotifications = true;
  static const bool enableInAppChat = true;
  static const bool enableRatingSystem = true;
  static const bool enableLocationServices = true;
  static const bool enableRealTimeUpdates = true;
  
  // UI Features
  static const bool enableDarkTheme = true;
  static const bool enableAnimations = true;
  static const bool enableShimmerEffects = true;
  
  // Development Features
  static const bool enableDebugMode = true;
  static const bool enableMockData = true;
  static const bool enablePerformanceMonitoring = true;
  
  // Payment Features (Future)
  static const bool enableInAppPayments = false;
  static const bool enableWallet = false;
  static const bool enablePromoCodes = false;
  
  // Social Features (Future)
  static const bool enableSocialSharing = false;
  static const bool enableFriendInvites = false;
  static const bool enableRideHistory = true;
  
  // Safety Features (Future)
  static const bool enableEmergencyContacts = false;
  static const bool enableRideTracking = false;
  static const bool enableSOSButton = false;
}

/// App configuration constants
class AppConfig {
  // App Information
  static const String appName = 'BirJol';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Kyrgyz Ride-Sharing App';
  
  // API Configuration
  static const String baseUrl = 'https://api.birjol.kg';
  static const int apiTimeout = 30000; // milliseconds
  
  // Map Configuration
  static const double defaultMapZoom = 13.0;
  static const double defaultLatitude = 42.8746; // Bishkek
  static const double defaultLongitude = 74.5698; // Bishkek
  static const double searchRadiusKm = 5.0;
  
  // UI Configuration
  static const double defaultBorderRadius = 12.0;
  static const double defaultPadding = 16.0;
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Ride Configuration
  static const int maxSeatsPerRide = 8;
  static const double minPrice = 50.0;
  static const double maxPrice = 5000.0;
  static const int maxSearchResults = 50;
  
  // Cache Configuration
  static const int cacheExpirationHours = 24;
  static const int maxCacheSize = 100; // MB
  
  // Notification Configuration
  static const int notificationTimeout = 5000; // milliseconds
  static const int maxNotifications = 100;
}

/// Theme configuration
class ThemeConfig {
  // Colors
  static const int primaryColor = 0xFF00D4AA;
  static const int accentColor = 0xFF00A693;
  static const int backgroundColor = 0xFF0A0A0A;
  static const int surfaceColor = 0xFF1E1E1E;
  static const int errorColor = 0xFFE57373;
  static const int successColor = 0xFF81C784;
  static const int warningColor = 0xFFFFB74D;
  
  // Text Colors
  static const int primaryTextColor = 0xFFFFFFFF;
  static const int secondaryTextColor = 0xFFB0B0B0;
  static const int disabledTextColor = 0xFF666666;
  
  // Border Colors
  static const int borderColor = 0xFF3A3A3A;
  static const int dividerColor = 0xFF2A2A2A;
  
  // Shadow Colors
  static const int shadowColor = 0x80000000;
  static const double shadowBlurRadius = 10.0;
  static const double shadowOffset = 5.0;
}

/// Localization configuration
class LocalizationConfig {
  static const String defaultLanguage = 'ru';
  static const List<String> supportedLanguages = ['ru', 'ky', 'en'];
  
  static const Map<String, String> languageNames = {
    'ru': 'Русский',
    'ky': 'Кыргызча',
    'en': 'English',
  };
  
  static const Map<String, String> countryNames = {
    'ru': 'Россия',
    'ky': 'Кыргызстан',
    'en': 'United States',
  };
}

/// Validation rules
class ValidationRules {
  // User validation
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const String phoneRegex = r'^\+996\d{9}$';
  static const String emailRegex = r'^[^@]+@[^@]+\.[^@]+$';
  
  // Ride validation
  static const int minPrice = 50;
  static const int maxPrice = 5000;
  static const int minSeats = 1;
  static const int maxSeats = 8;
  static const int minAdvanceBookingHours = 1;
  static const int maxAdvanceBookingDays = 30;
  
  // Address validation
  static const int minAddressLength = 5;
  static const int maxAddressLength = 200;
  
  // Message validation
  static const int maxMessageLength = 500;
  static const int maxNoteLength = 1000;
} 