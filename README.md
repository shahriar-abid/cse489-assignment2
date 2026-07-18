# CSE489 Assignment 2

A Flutter application developed for the CSE489 Mobile Application Development course. This project demonstrates various Android-specific features including Broadcast Receivers, Image interaction, and Media playback.

## Features

### 1. Broadcast Receiver
- **Battery Receiver**: Monitors the system battery level using a native Android BroadcastReceiver (`ACTION_BATTERY_CHANGED`).
- **Custom Broadcast**: Demonstrates sending and receiving custom Intent broadcasts between Flutter and native Android code.

### 2. Image Scaling
- Interactive image viewing with pinch-to-zoom, pan, and double-tap gestures.
- Built using the `photo_view` package.

### 3. Video Player
- Local video playback with custom controls (Play, Pause, Stop).
- Progress tracking and seek functionality.
- Uses the `video_player` package.

### 4. Audio Player
- Local audio playback for MP3 assets.
- Includes playback controls and a progress slider.
- Uses the `just_audio` package.

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio / VS Code
- Android Device or Emulator

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/shahriar-abid/cse489-assignment2.git
   ```
2. Navigate to the project directory:
   ```bash
   cd cse489-assignment2
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Assets
The project uses local assets for Video and Audio modules. Ensure the following directory structure exists if adding new files:
- `assets/images/`
- `assets/audio/`
- `assets/video/`
