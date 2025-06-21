# BirJol - Kyrgyz Ride-Sharing App

BirJol is a modern ride-sharing application designed specifically for Kyrgyzstan, inspired by BlaBlaCar. The app connects drivers and passengers for shared rides, making travel more affordable, social, and environmentally friendly.

## 🚀 Features

### Core Features
- **Ride Search & Booking**: Find and book available rides with real-time filtering
- **Interactive Map**: View ride locations and routes on an interactive map
- **Driver Profiles**: View driver ratings, car details, and ride history
- **User Authentication**: Secure login and registration system
- **Real-time Updates**: Live ride status and availability updates

### Enhanced Features
- **Push Notifications**: Get notified about ride updates and new bookings
- **In-App Chat**: Communicate with drivers and passengers
- **Rating System**: Rate and review drivers and passengers
- **Multiple Ride Types**: Choose between Economy, Comfort, and Premium options
- **Location Services**: Automatic location detection and address suggestions

### UI/UX Features
- **Modern Design**: Material 3 design with dark theme support
- **Responsive Layout**: Optimized for various screen sizes
- **Smooth Animations**: Engaging user interactions and transitions
- **Accessibility**: Support for screen readers and accessibility features

## 🛠️ Technology Stack

- **Framework**: Flutter 3.7.2+
- **State Management**: Provider pattern
- **Maps**: Flutter Map with OpenStreetMap
- **UI Components**: Material Design 3
- **Backend**: Firebase (Firestore, Authentication, Messaging)
- **Local Storage**: Shared Preferences
- **HTTP Client**: Dio for API calls

## 📱 Screenshots

*Screenshots will be added here*

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.7.2 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/birjol.git
   cd birjol
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase (Optional)**
   
   For full functionality, set up Firebase:
   
   a. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   b. Add Android and iOS apps to your Firebase project
   c. Download and add the configuration files:
      - `google-services.json` for Android (place in `android/app/`)
      - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
   d. Enable Firestore, Authentication, and Cloud Messaging services

4. **Run the app**
   ```bash
   flutter run
   ```

### Project Structure

```
lib/
├── application/
│   └── providers/
│       └── app_state_provider.dart
├── data/
│   └── services/
│       └── ride_service.dart
├── domain/
│   └── models/
│       ├── user_model.dart
│       └── ride_model.dart
├── presentation/
│   ├── screens/
│   │   ├── auth/
│   │   ├── tabs/
│   │   └── home_screen.dart
│   ├── widgets/
│   └── styles/
└── main.dart
```

## 🎨 Customization

### Colors and Themes

The app uses a customizable color scheme. Main colors are defined in the theme files:

- **Primary Color**: `#00D4AA` (Teal)
- **Background**: `#0A0A0A` (Dark)
- **Surface**: `#1E1E1E` (Dark Gray)
- **Accent**: `#00A693` (Dark Teal)

### Fonts

The app uses Montserrat font family with multiple weights:
- Regular, Light, Bold, Black, Italic

### Localization

The app is currently in Russian/Kyrgyz. To add more languages:

1. Create localization files in `lib/l10n/`
2. Add language codes to `pubspec.yaml`
3. Update text widgets to use `AppLocalizations`

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
# Firebase Configuration
FIREBASE_API_KEY=your_api_key
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_MESSAGING_SENDER_ID=your_sender_id

# Maps Configuration
MAPS_API_KEY=your_maps_api_key

# App Configuration
APP_NAME=BirJol
APP_VERSION=1.0.0
```

### Feature Flags

Enable/disable features by modifying `lib/config/feature_flags.dart`:

```dart
class FeatureFlags {
  static const bool enablePushNotifications = true;
  static const bool enableChat = true;
  static const bool enableRatingSystem = true;
  static const bool enableMaps = true;
}
```

## 📦 Dependencies

### Core Dependencies
- `flutter`: Flutter framework
- `provider`: State management
- `shared_preferences`: Local storage
- `flutter_map`: Interactive maps
- `latlong2`: Geographic coordinates

### UI Dependencies
- `flutter_svg`: SVG support
- `shimmer`: Loading animations
- `flutter_rating_bar`: Rating widgets
- `cached_network_image`: Image caching

### Firebase Dependencies
- `firebase_core`: Firebase initialization
- `firebase_auth`: Authentication
- `cloud_firestore`: Database
- `firebase_messaging`: Push notifications

### Utility Dependencies
- `http`: HTTP requests
- `geolocator`: Location services
- `geocoding`: Address geocoding
- `intl`: Internationalization
- `url_launcher`: URL handling

## 🧪 Testing

Run tests with:

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Coverage report
flutter test --coverage
```

## 📱 Building for Production

### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

### iOS

```bash
# Build for iOS
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by BlaBlaCar
- Built with Flutter
- Maps powered by OpenStreetMap
- Icons from Material Design

## 📞 Support

For support and questions:
- Email: support@birjol.kg
- Telegram: @birjol_support
- Website: https://birjol.kg

## 🔄 Changelog

### Version 1.0.0
- Initial release
- Core ride-sharing functionality
- User authentication
- Interactive maps
- Modern UI design

---

**BirJol** - Making travel in Kyrgyzstan more connected and sustainable! 🚗💚