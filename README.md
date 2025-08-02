# multilingual_text_to_speech

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



# Project Title
Multilingual Text-to-Speech App:
This Application transalte text within French, Spanish, Germany and English languaes.

## Documentation /Setup Instructions

Follow these steps to run this Flutter multilingual TTS application on your local machine:
Prerequisites
Ensure the following tools are installed:

Flutter SDK (Channel stable)

Android Studio or Visual Studio Code (with Flutter & Dart plugins)

Git (to clone the repo)

A physical device or emulator (Android-only if you're not targeting iOS)

## Run Flutter Dependencies, Add permission

To run this project

```bash
flutter pub get

```

```bash
<uses-permission android:name="android.permission.INTERNET"/>

```
```bash
flutter run

```
This app uses:For text to speech
```bash
flutter_tts
```
For state management
```bash
provider
```

For translating text between languages
```bash
translator
```
## Known Limitations or Assumptions

- Language Support
  The app only supports English, French, Spanish, and German for translation and text-to-speech.

If the input language is not among these, a warning is shown and TTS is not triggered.
- Voice Gender
  This Application only supports female voice
  After navigating from splash screen to Multilingual screen Snackbar message appears for user expereince that only female voice plays
- Realtime Playback Speed Change and Pitch
  Playback speed and Pitch cannot be changed mid-speech with most TTS engines.

User must pause and restart for speed changes to apply (this is a platform limitation).
- Language Detection Accuracy
  Very short or ambiguous inputs (e.g., "Hi", "OK") may result in incorrect or unsupported language detection.

The app notifies the user if detection fails due to short/unclear input.
- Internet Requirement
  Internet access is required for:
  Language detection &
  Text translation
- Platform Support
  Currently tested only on Android.


## Features
- Auto-detect input language
- Translate between English, French, Spanish, and German
- Text-to-speech in selected language
- Adjustable playback speed
- Simulated voice pitch
- State management using Provider
- Error handling and real-time feedback using Snackbars