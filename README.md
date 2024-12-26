Here’s a detailed and formatted README.md file with the requested features, steps, and structure, including a table summarizing the application components:

---

# Real-Time Maps

A Flutter-based real-time location tracking application using Firebase Realtime Database and Google Maps. This app enables real-time navigation and location sharing between two users (User A and User B).

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Setup and Installation](#setup-and-installation)
   - [Install Flutter and Dependencies](#install-flutter-and-dependencies)
   - [Set Up Firebase](#set-up-firebase)
   - [Configure Google Maps API](#configure-google-maps-api)
5. [Permissions](#permissions)
6. [Application UI](#application-ui)
7. [How the Application Works](#how-the-application-works)
8. [Summary Table](#summary-table)

---

## Getting Started

This project is designed for Flutter developers to understand and implement a real-time location tracking system with:

- A login page.
- Two separate maps for User A and User B.
- Real-time navigation and Firebase integration.

For beginners, refer to the following resources:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

---

## Features

1. **Sign-In/Sign-Out**:
   - Simple login/logout functionality using local state management.

2. **Map Views**:
   - **Map 1**: Displays User A’s current location.
   - **Map 2**: Tracks User B’s real-time location.

3. **Real-Time Navigation**:
   - Tracks and displays User B's movement in real-time using Firebase Realtime Database.

---

## Technologies Used

- **Flutter** for app development.
- **Google Maps API** for map functionality.
- **Firebase Realtime Database** for storing and retrieving real-time data.
- **Google Cloud Platform (GCP)** for API key management.

---

## Setup and Installation

### 1. Install Flutter and Dependencies

- Install Flutter: [Install Flutter](https://docs.flutter.dev/get-started/install).
- Clone the project:

```bash
https://github.com/DHAMUACHARi/Maptracking.git
cd real_time_maps
```

- Install dependencies:

```bash
flutter pub get
```

---

### 2. Set Up Firebase

#### Step 1: Create Firebase Project

- Go to the [Firebase Console](https://console.firebase.google.com/).
- Click on **Create Project** and follow the instructions.

#### Step 2: Add Firebase to Flutter App

- **For Android**:
   - Add your app's package name (e.g., `com.example.real_time_maps`).
   - Download `google-services.json` and place it in the `android/app` folder.

- **Set Up Firebase CLI**:
  ```bash
  npm install -g firebase-tools
  firebase login
  firebase init
  ```

- Enable Realtime Database:
   - Navigate to **Database > Realtime Database** in Firebase Console.
   - Click **Create Database** and set rules for testing:

```json
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}
```

---

### 3. Configure Google Maps API

- Obtain an API Key:
   - Go to [Google Cloud Console](https://console.cloud.google.com/).
   - Enable the **Maps SDK for Android** and **Maps SDK for Web**.
   - Generate an API key.

- Add API key to Android:
  ```xml
  <meta-data
      android:name="com.google.android.geo.API_KEY"
      android:value="AIzaSyBq_Av_DY7ZaSVGGaVlecwr-27blHv6YJw" />
  ```

---

## Permissions

Add the following permissions in `AndroidManifest.xml` for location access:

```
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />

```

## Database File
```json
{
  "users": {
    "userA_id": {
      "location": {
        "latitude": 12.2963584,
        "longitude": 76.6352863
      }
    },
    "userB_id": {
      "location": {
        "latitude": 12.2963359,
        "longitude": 76.6353778
      }
    }
  }
}
```
---

## Application UI

1. **Sign-In Page**: Allows users to log in using local credentials.
2. **Dashboard**:
   - Displays two maps:
      - **Map 1**: User A's current location.
      - **Map 2**: User B's real-time location.
   - Provides an option to sign out.
3. **Sign-Out Page**: Logs out the user and navigates back to the sign-in page.

---

## How the Application Works

1. **Sign-In Process**:
   - User enters valid credentials to access the dashboard.

2. **Dashboard Functionality**:
   - **Map 1**: Fetches and displays User A’s current location.
   - **Map 2**: Fetches User B’s real-time location from Firebase Realtime Database.

3. **Real-Time Tracking**:
   - **App 2** (for User B) updates the Firebase database with User B's current location.
   - **App 1** (for User A) listens to Firebase for location changes and updates the map.

4. **User B’s Location Permissions**:
   - User B allows location access at all times to enable tracking.

---

