# E-Commerce App

## 📱 Project Overview
This is an e-commerce mobile application built with Flutter, with a product listing screen, product details screen, user authentication, and device information integration.

## ✨ Features

- User Authentication (Login/Registration)
- Product Listing
- Product Details
- Favorites Management
- Profile Management
- Device Information Display

## 🚀 Setup Instructions
1. Clone the Repository
   ```sh
   git clone https://github.com/yourusername/flutter-ecommerce-app.git
   cd flutter-ecommerce-app
   ```
2. Firebase Configuration

   1. Create a Firebase project at Firebase Console
   2. Add an iOS and Android app to your Firebase project
   3. Download and place configuration files:

      - `android/app/google-services.json`
      - `ios/Runner/GoogleService-Info.plist`

3. Install Dependencies
   ```sh
   flutter pub get
   ```
4. Run the App
   ```sh
   # For iOS
   flutter run -d ios

   # For Android
   flutter run -d android
   ```
## 🔧 Troubleshooting

- Ensure Flutter SDK is updated
- Check Firebase configurations
- Verify all dependencies are installed

## 📦 Dependencies

- Flutter Riverpod
- Firebase Authentication
- Dio for API calls
- Go Router for navigation



---------------------------------------------


# Design Choices and Technical Challenges

## 🤔 Design Philosophy
My goal was to create a clean, efficient, and user-friendly e-commerce mobile application that demonstrates modern Flutter development practices.

## 🏗 Architectural Decisions

### 1. Navigation: Go Router
#### Advantages:

- Declarative routing
- Type-safe route definitions
- Easy navigation between screens
- Supports deep linking

### 2. Authentication: Firebase
#### Reasons for Choice:

- Easy setup
- Secure authentication
- Built-in user management
- Cross-platform support

### 🧩 Swift Integration Challenges
#### Device Information Retrieval
#### Technical Approach:

- Used Flutter's MethodChannel for native communication
- Created a Swift plugin to fetch device details
- Implemented a clean, cross-platform interface

#### Challenges Overcome:

1. Bridging Flutter and Native Code

- Managed method channel communication
- Handled data serialization

2. Platform-Specific Information

- Created a unified interface for device info
- Ensured consistent data format across iOS and Android


#### Swift Method Channel

```swift
public func getDeviceInformation() -> [String: Any] {
   let device = UIDevice.current
   return [
   "model": device.model,
   "systemName": device.systemName,
   "systemVersion": device.systemVersion
   ]
}
```

3. Performance Optimization

- Used CachedNetworkImage for efficient image loading
- Minimized unnecessary rebuilds with Riverpod

