import 'dart:convert';

import 'package:edocflow/Controller/Document/document_in_controller.dart';
import 'package:edocflow/Controller/Document/document_out_controller.dart';
import 'package:edocflow/Controller/Home/home_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _backgroundMessaging(RemoteMessage message) async {
  await Firebase.initializeApp();
  handleShowNotification(message);
}

/// Khởi tạo thông báo local
Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await _localNotificationsPlugin.initialize(initializationSettings);
}

Future<void> _showNotification({
  required String title,
  required String body,
}) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'high_importance_channel', // ID kênh
    'Thông báo quan trọng', // Tên kênh
    channelDescription: 'Kênh dành cho các thông báo quan trọng',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await _localNotificationsPlugin.show(
    0, // ID thông báo
    title,
    body,
    platformChannelSpecifics,
  );
}

void handleShowNotification(RemoteMessage message) {
  String title = message.notification?.title ?? "Thông báo";
  String body = message.notification?.body ?? "Không có nội dung!";
  Map<String, dynamic> data = message.data;

  _showNotification(title: title, body: body);
  if (data['data'] != null) {
    var mdata = jsonDecode(data['data'] ?? "");
    if (mdata['type'] == "document") {
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().refreshData();
      }
      if (mdata['more'] != "out") {
        if (Get.isRegistered<DocumentOutController>()) {
          Get.find<DocumentOutController>().refreshData();
        }
      }
      if (mdata['more'] != "in") {
        if (Get.isRegistered<DocumentInController>()) {
          Get.find<DocumentInController>().refreshData();
        }
      }
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _initializeNotifications();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessaging);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    handleShowNotification(message);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('vi', 'VN'),
        ],
        title: 'EDocFlow',
        theme: ThemeData(
          primaryColorLight: AppColor.primary,
          primaryColor: AppColor.primary,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColor.primary,
            selectionColor: AppColor.primary,
            selectionHandleColor: AppColor.primary,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            titleSpacing: 20,
            elevation: 0,
            foregroundColor: AppColor.text1,
            backgroundColor: AppColor.main,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppPage.initialRoute,
        getPages: AppPage.routes,
      ),
    );
  }
}
