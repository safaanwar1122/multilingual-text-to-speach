import 'package:flutter/material.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:multilingual_text_to_speech/utils/app_colors.dart';

import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:translator/translator.dart';

class TTSProvider with ChangeNotifier {
  TextEditingController textController = TextEditingController();

  final FlutterTts _flutterTts = FlutterTts();
  final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
  final translator = GoogleTranslator();

  final List<String> supportedLanguages = ['en', 'fr', 'es', 'de'];
  String _detectedLanguage = '';
  String _translatedText = '';
  String selectedLanguage = 'en';
  String _lastProcessesText = '';
  String get detectedLanguage => _detectedLanguage;
  String get translatedText => _translatedText;
  double _speechRate = 0.5;
  double get speechRate => _speechRate;

  double _pitch = 1.0;
  double get pitch => _pitch;
  bool _isPlaying = false;
  bool _hasSpoken = false;
  bool get isPlaying => _isPlaying;

  bool get hasSpoken => _hasSpoken;

  void updatePitch(double value) {
    _pitch = value;
    notifyListeners();
  }

  void updateSpeechRate(double rate) {
    _speechRate = rate;
    notifyListeners();
  }

  /*void updateSelectedLanguage(String value) {
    selectedLanguage = value;
    notifyListeners();
  }
*/

  void updateSelectedLanguage(String languageCode) async {
    selectedLanguage = languageCode;
    final currentText = textController.text.trim();
    if (currentText.isNotEmpty && _detectedLanguage.isNotEmpty) {
      await processAndSpeak(currentText);
    }
    notifyListeners();
  }

  TTSProvider() {
    textController.addListener(() {
      final currentText = textController.text.trim();
      if (_hasSpoken && currentText != _lastProcessesText) {
        _hasSpoken = false;
        _translatedText = '';
        notifyListeners();
      }
    });
    _flutterTts.setCompletionHandler(() {
      _isPlaying = false;
      notifyListeners();
    });
    _flutterTts.setCancelHandler(() {
      _isPlaying = false;
      notifyListeners();
    });
    _flutterTts.setErrorHandler((message) {
      _isPlaying = false;
      notifyListeners();
    });
  }

  Future<void> processAndSpeak(String inputText) async {
    if (inputText.trim().isEmpty) {
      Get.snackbar(
        'Error',
        "Please enter some text",
        backgroundColor: AppColors.red.withOpacity(0.8),
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return;
    }

    try {
      _detectedLanguage = await languageIdentifier.identifyLanguage(inputText);
      notifyListeners();

      if (!supportedLanguages.contains(_detectedLanguage)) {
        Get.snackbar(
          "Unsupported",
          "Input language '$_detectedLanguage' is not supported. Input text is very short or ambiguous",
          backgroundColor: AppColors.red.withOpacity(0.8),
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
        return;
      }

      final translation = await translator.translate(
        inputText,
        from: _detectedLanguage,
        to: selectedLanguage,
      );
      _translatedText = translation.text;
      _hasSpoken = true;
      _isPlaying = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  /* Future<void> togglePlayPause()async{
    if(!_hasSpoken || _translatedText.isEmpty){
      return;
    }
    if(_isPlaying){
      await _flutterTts.pause();
      _isPlaying=false;
    }
    else {
      await _flutterTts.setLanguage(selectedLanguage);
      await _flutterTts.setSpeechRate(_speechRate);
      await _flutterTts.speak(_translatedText);
      await _flutterTts.setPitch(_pitch);
      _isPlaying=true;
    }
    notifyListeners();
  }
  void stop()async{
    await _flutterTts.stop();
    _isPlaying=false;
    notifyListeners();
  }*/
  Future<void> handlePlayPauseUnified() async {
    final inputText = textController.text.trim();
    _lastProcessesText = inputText.trim();
    // If already playing → pause
    if (_isPlaying) {
      await _flutterTts.pause();
      _isPlaying = false;
      notifyListeners();
      return;
    }
    // If not spoken yet → process text and start speech
    if (!_hasSpoken || _translatedText.isEmpty) {
      if (inputText.isEmpty) {
        Get.snackbar(
          'Error',
          "Please enter some text",
          backgroundColor: AppColors.red.withOpacity(0.8),
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return;
      }
      try {
        _detectedLanguage = await languageIdentifier.identifyLanguage(
          inputText,
        );
        notifyListeners();
        if (!supportedLanguages.contains(_detectedLanguage)) {
          Get.snackbar(
            "Unsupported",
            "Input language '$_detectedLanguage' is not supported.",
            backgroundColor: AppColors.red.withOpacity(0.8),
            colorText: AppColors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
          return;
        }
        final translation = await translator.translate(
          inputText,
          from: _detectedLanguage,
          to: selectedLanguage,
        );
        _translatedText = translation.text;
        _hasSpoken = true;
      } catch (e) {
        Get.snackbar("Error", "Something went wrong: $e");
        return;
      }
    }
    // Setup and speak
    await _flutterTts.setLanguage(selectedLanguage);
    await _flutterTts.setSpeechRate(_speechRate);
    await _flutterTts.setPitch(_pitch);
    await _flutterTts.speak(_translatedText);
    _isPlaying = true;
    notifyListeners();
  }
}

/*

class MultilingualProvider with ChangeNotifier {
  TextEditingController textController = TextEditingController();
  final FlutterTts _flutterTTS = FlutterTts();
  String _selectedLanguageCode = 'en-US';
 double _speechRate=1.0;
 double _pitch=1.0;
 bool _isPlaying=false;
 bool get isPlaying=>_isPlaying;

 double get pitch=>_pitch;
 void setPitch(double value){
   _pitch=value;
   notifyListeners();
 }
 double get speechRate=>_speechRate;
 void setSpeechRate(double rate){
   _speechRate=rate;
   notifyListeners();
 }

  String get selectedLanguageCode => _selectedLanguageCode;
  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en-US'},
    {'name': 'French', 'code': 'fr-FR'},
    {'name': 'Spanish', 'code': 'es-ES'},
    {'name': 'German', 'code': 'de-DE'},
  ];
  void setLanguageCode(String code) {
    _selectedLanguageCode = code;
    notifyListeners();
  }

  Future<void> speakText(BuildContext context) async {
    String text = textController.text.trim();
    if (text.isEmpty) return;
    final detected = langdetect.detect(text);
    final selectedLang = _selectedLanguageCode.split('-').first;
    final supported = languages
        .map((l) => l['code']!.split('-').first)
        .toList();
    if (!supported.contains(detected)) {
      Get.snackbar(
        'Error',
        'Language not supported',
        backgroundColor: AppColors.red.withOpacity(0.8),
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return;
    }

    if (detected != selectedLang) {
      Get.snackbar(
        'Error',
        'Please select relevant language',
        backgroundColor: AppColors.red.withOpacity(0.8),
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return;
    }
    await _flutterTTS.setLanguage(_selectedLanguageCode);
    await _flutterTTS.setPitch(_pitch);
    await _flutterTTS.setSpeechRate(_speechRate);

_isPlaying=true;
notifyListeners();

    await _flutterTTS.speak(text);
    _flutterTTS.setCompletionHandler((){
      _isPlaying=false;
      notifyListeners();
    });
    _flutterTTS.setErrorHandler((message){
      _isPlaying=false;
      notifyListeners();
    });
  }
  Future<void>pauseSpeech()async{
    await _flutterTTS.pause();
    _isPlaying=false;
    notifyListeners();
  }
}
*/
