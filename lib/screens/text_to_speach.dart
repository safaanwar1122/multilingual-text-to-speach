import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:multilingual_text_to_speech/controllers/multilingual_provider.dart';
import 'package:multilingual_text_to_speech/widgets/custom_button.dart';
import 'package:multilingual_text_to_speech/widgets/spacer.dart';
import 'package:multilingual_text_to_speech/widgets/text_from_field.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../widgets/custom_text.dart';
/*

class TextToSpeachScreen extends StatefulWidget {
  @override
  _TextToSpeachScreenState createState() => _TextToSpeachScreenState();
}

class _TextToSpeachScreenState extends State<TextToSpeachScreen> {

  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MultilingualProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.grey,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: customText(
              text: AppConstants.multilingualTTS,
              color: AppColors.black,
              fontStyle: FontStyle.normal,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key:_formKey,
            child: Column(
              children: [
                verticalSpacer(50),
                Consumer<MultilingualProvider>(
                  builder: (context, provider, child) {
                    return DropdownButtonFormField<String>(
                      value: provider.selectedLanguageCode,
                      decoration: InputDecoration(
                        labelText: 'Select Language',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                      ),
                      items: provider.languages.map((lang) {
                        return DropdownMenuItem<String>(
                          value: lang['code'],
                          child: Text(lang['name']!),
                        );
                      }).toList(),
                      onChanged: (String ? newCode) {
                        if (newCode != null) {
                          provider.setLanguageCode(newCode);
                        }
                      },
                    );
                  },
                ),
                verticalSpacer(50),
                customTextFormField(
                  controller: provider.textController,
                  label: 'Enter a sentence',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                verticalSpacer(20),
               Consumer<MultilingualProvider>(builder:(context, provider, child){
                 return  customButton(
                     label: provider.isPlaying?'Pause':'Play',
                     icon: provider.isPlaying?Icons.pause:Icons.play_arrow,
                     buttonColor: AppColors.grey,
                     textColor: AppColors.black,
                     onPressed:(){
                       if(_formKey.currentState!.validate()){
                        if(provider.isPlaying){
                          provider.pauseSpeech();
                        }
                        else {
                          provider.speakText(context);
                        }
                       }
                     }
                 );
               }
               ),
                verticalSpacer(20),

                verticalSpacer(20),
                customText(
                  text: "Speech Rate:${provider.speechRate.toStringAsFixed(1)}",
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
                Consumer<MultilingualProvider>(
                  builder: (context, provider, child) {
                    return Slider(
                      value: provider.speechRate,
                      min: 0.1,
                      max: 2.0,
                      divisions: 19,
                      label: provider.speechRate.toStringAsFixed(1),
                      onChanged: (newValue) {
                        provider.setSpeechRate(newValue);
                      },
                    );
                  },
                ),
                verticalSpacer(20),
                customText(
                  text: "Pitch:${provider.pitch.toStringAsFixed(1)}",
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
                Consumer<MultilingualProvider>(
                  builder: (context, provider, child) {
                    return  Slider(
                      value: provider.pitch,
                      min: 0.5,
                      max: 2.0,
                      divisions: 15,
                      label: provider.pitch.toStringAsFixed(1),
                      onChanged: (newValue) {
                        provider.setPitch(newValue);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

class TTSScreen extends StatefulWidget {
  const TTSScreen({super.key});

  @override
  State<TTSScreen> createState() => _TTSScreenState();
}

class _TTSScreenState extends State<TTSScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final ttsProvider = Provider.of<TTSProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.grey,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: customText(
              text: AppConstants.multilingualTTS,
              color: AppColors.black,
              fontStyle: FontStyle.normal,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                verticalSpacer(50),
                customTextFormField(
                  controller: ttsProvider.textController,
                  label: 'Enter a sentence',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                verticalSpacer(20),
               DropdownButtonFormField<String>(
                  value: ttsProvider.selectedLanguage,
                  items: [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'fr', child: Text('French')),
                    DropdownMenuItem(value: 'es', child: Text('Spanish')),
                    DropdownMenuItem(value: 'de', child: Text('German')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      ttsProvider.updateSelectedLanguage(value);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Translate & Speak in',
                  ),
                ),
                verticalSpacer(20),
                /*customButton(
                  label: "Process Text",
                  buttonColor: AppColors.grey,
                  textColor: AppColors.black,
                  onPressed: () => ttsProvider.processAndSpeak(
                    ttsProvider.textController.text,
                  ),
                ),*/
                // if(ttsProvider.hasSpoken)
                customButton(
                  label: ttsProvider.isPlaying ? "Pause" : "Play",
                  buttonColor: AppColors.grey,
                  textColor: AppColors.black,
                  icon: ttsProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                  // onPressed: () => ttsProvider.togglePlayPause(),
                  onPressed: () => ttsProvider.handlePlayPauseUnified(),
                ),
                verticalSpacer(20),
                if (ttsProvider.detectedLanguage.isNotEmpty)
                  customText(
                    text:
                    ("Detected Input Language: ${ttsProvider.detectedLanguage}"),
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),

                if (ttsProvider.translatedText.isNotEmpty)
                  customText(
                    text: ("Translated Text: ${ttsProvider.translatedText}"),
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                verticalSpacer(20),
                customText(
                  text:
                  "Speech Rate :${ttsProvider.speechRate.toStringAsFixed(2)}",
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
                verticalSpacer(10),
                Slider(
                  max: 1.0,
                  min: 0.1,
                  divisions: 9,
                  value: ttsProvider.speechRate,
                  label: ttsProvider.speechRate.toStringAsFixed(2),
                  onChanged: (value) {
                    ttsProvider.updateSpeechRate(value);
                  },
                ),
                verticalSpacer(20),
                customText(
                  text: "Pitch :${ttsProvider.pitch.toStringAsFixed(2)}",
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
                verticalSpacer(10),
                Slider(
                  min: 0.5,
                  max: 2.0,
                  divisions: 15,
                  value: ttsProvider.pitch,
                  label: ttsProvider.pitch.toStringAsFixed(2),
                  onChanged: (value) {
                    ttsProvider.updatePitch(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
