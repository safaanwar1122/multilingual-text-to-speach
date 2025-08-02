import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multilingual_text_to_speech/screens/text_to_speach.dart';
import 'package:multilingual_text_to_speech/utils/app_constants.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/spacer.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarIconBrightness:
        Theme.of(context).scaffoldBackgroundColor == AppColors.grey
            ? Brightness.dark
            : Brightness.light,
        statusBarColor: AppColors.grey,
        systemNavigationBarColor: AppColors.grey,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() =>
        TTSScreen(),
       //  TextToSpeachScreen()

        );
      });
    });

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpacer(250),

                customText(
                  text: AppConstants.multilingualTTS,
                  color: AppColors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
                verticalSpacer(70),
                customText(
                  text: "Test App",
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
                // verticalSpacer(40),
                customText(
                  text: "Developed by: Safa Anwar",
                  color: AppColors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
