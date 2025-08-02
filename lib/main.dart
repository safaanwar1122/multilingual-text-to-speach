import 'package:flutter/material.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:multilingual_text_to_speech/screens/splash_screen.dart';
import 'package:multilingual_text_to_speech/screens/text_to_speach.dart';
import 'package:multilingual_text_to_speech/utils/provider_path.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await langdetect.initLangDetect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: RegisterAllProviders.allProvidersList,
      child: ScreenUtilInit(
        designSize: const Size(440, 956),
        child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          // home: TTSScreen(),
           //home: MultilingualTTS(),
          home:SplashScreen(),
        ),
      ),
    );
  }
}
