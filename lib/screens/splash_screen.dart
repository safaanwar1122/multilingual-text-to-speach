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
        Theme.of(context).scaffoldBackgroundColor == AppColors.blue
            ? Brightness.dark
            : Brightness.light,
        statusBarColor: AppColors.blue,
        systemNavigationBarColor: AppColors.blue,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() =>
        TTSScreen(),
        );
      });
    });

    return Scaffold(
      backgroundColor: AppColors.blue,
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
                  color: AppColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
                verticalSpacer(80),
                customText(
                  text: "Test App",
                  color: AppColors.yellow,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
                 verticalSpacer(30),
                customText(
                  text: "Developed by: Safa Anwar",
                  color: AppColors.white,
                  fontSize: 24,
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
