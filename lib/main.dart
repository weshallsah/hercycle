import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/emailvirfy.dart';
import 'package:hercycle/component/nav.dart';
import 'package:hercycle/controller/splash.controller.dart';
import 'package:hercycle/firebase_options.dart';
import 'package:hercycle/screen/Auth.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Splashcontroller splashcontroller = Get.put(Splashcontroller());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        sliderTheme: SliderTheme.of(context).copyWith(
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 1.0),
          trackHeight: 4,
        ),
      ),
      home: const ScreenUtilInit(
        designSize: Size(393, 852),
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
