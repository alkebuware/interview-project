# Flutter Sensor Management Project

## Overview
This Flutter project demonstrates real-time sensor data management using BLoC pattern and reactive programming. The application simulates a sensor monitoring system with live data updates.

## Current Implementation

### Core Components
- **Sensor Model**: Contains name, description, and temperature value properties
- **Sensor Repository**: Manages sensor data with reactive streams
  - Uses `BehaviorSubject` for real-time data broadcasting
  - `initializeSensors()`: Creates 10 random sensors and updates values every 5 seconds
  - `updateSensor()`: Updates individual sensor data in the stream

## Development Tasks

### Required Features (Priority Order)
1. **BLoC Implementation**: Create a business logic component to initialize sensors and manage data streams
2. **Real-time UI**: Build a functional view that displays sensor list with live updates to values
3. **Search Functionality**: Implement filtering capabilities for the sensor list
4. **Edit Capabilities**: Add ability to modify sensor name and description (dialog or separate screen)

### Optional Enhancements
- **Sorting**: Implement ascending/descending sort by temperature value
- **UI/UX**: Apply styling

## Technical Stack
- Flutter
- BLoC Pattern
- RxDart (BehaviorSubject)

## Getting Started
1. Clone the repository
2. Run `flutter pub get`
3. Implement the required features in order of priority
4. Test real-time updates and user interactions
