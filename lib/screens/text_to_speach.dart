import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multilingual_text_to_speech/controllers/multilingual_provider.dart';
import 'package:multilingual_text_to_speech/widgets/custom_button.dart';
import 'package:multilingual_text_to_speech/widgets/spacer.dart';
import 'package:multilingual_text_to_speech/widgets/text_from_field.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../widgets/custom_text.dart';



class TTSScreen extends StatefulWidget {
  const TTSScreen({super.key});

  @override
  State<TTSScreen> createState() => _TTSScreenState();
}

class _TTSScreenState extends State<TTSScreen> {

bool _hasShownVoiceWarning=false;

 @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(!_hasShownVoiceWarning){
      _hasShownVoiceWarning=true;
      WidgetsBinding.instance.addPostFrameCallback((_){
        Get.snackbar(
          'Voice Info',
          'This application only supports the female voice version.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.pink,
          colorText: AppColors.white,
          duration: Duration(seconds: 8),
          isDismissible: true,
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          borderRadius: 10.r,
          icon: const Icon(Icons.info_outline, color: AppColors.white),
          mainButton: TextButton(onPressed: (){
            Get.closeCurrentSnackbar();
          }, child:const Icon(Icons.close, color: Colors.white),),
        );
      });
    }
  }
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
          backgroundColor: AppColors.blue,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: customText(
              text: AppConstants.multilingualTTS,
              color: AppColors.white,
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpacer(50),
                customTextFormField(
                  controller: ttsProvider.textController,
                  label: 'Enter a sentence',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter some text';
                    }
                    if(value.trim().length<10){
                      return 'Please enter at least 20 characters';
                    }
                    return null;
                  },
                ),
                verticalSpacer(20),

                DropdownButtonFormField<String>(
            value: ttsProvider.availableOutputLanguages.contains(ttsProvider.selectedLanguage)
                ? ttsProvider.selectedLanguage
                : null,
            items: ttsProvider.availableOutputLanguages.map((lang) {
              final languageMap = {
                'en': {'label': 'English', 'flag': '🇺🇸'},
                'fr': {'label': 'French', 'flag': '🇫🇷'},
                'es': {'label': 'Spanish', 'flag': '🇪🇸'},
                'de': {'label': 'German', 'flag': '🇩🇪'},
              };
              final display = languageMap[lang]!;

              return DropdownMenuItem(
                value: lang,
                child: Row(
                  children: [
                    Text(display['flag']!, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 8),
                    Text(display['label']!),
                  ],
                ),
              );
            }).toList(),
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

                customButton(
                  label: ttsProvider.isPlaying ? "Pause" : "Play",
                  buttonColor: AppColors.blue,
                  textColor: AppColors.white,
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
                    fontStyle: FontStyle.normal,
                  ),
                if (ttsProvider.translatedText.isNotEmpty)
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 10,
                        maxHeight: double.infinity,
                        minWidth: double.infinity,
                      ),
                      child: Container(
                        padding:  EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),

                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.blue),
                        ),
                        child: customText(
                          text: "Translated Text: ${ttsProvider.translatedText}",
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                verticalSpacer(20),
                customText(
                  text:
                  "Speech Rate :${ttsProvider.speechRate.toStringAsFixed(2)}",
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
               // verticalSpacer(10),
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
                  fontStyle: FontStyle.normal,
                ),
              //  verticalSpacer(10),
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
