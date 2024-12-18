import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/postvideoplayer.dart';
import 'package:hercycle/controller/home.controller.dart';
import 'package:hercycle/controller/splash.controller.dart';
import 'package:hercycle/firebase_options.dart';
import 'package:hercycle/services/notification.services.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationServices notificationServices = NotificationServices();
  print("message");
  print(message.notification!.title.toString());
  notificationServices.initlocalnotifications(message);
  notificationServices.shownotification(message);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Splashcontroller splashcontroller = Get.put(Splashcontroller());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hercycle',
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
