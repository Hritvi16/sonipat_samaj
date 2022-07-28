import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sonipat_samaj/Dashboard.dart';
import 'package:sonipat_samaj/InitialScreen.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/Response.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(Platform.isAndroid)
    await Firebase.initializeApp();
  print("handling a background message${message.messageId}");
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importance_channel", "High Importance notification",
    importance: Importance.high);

//Remove this
// "This channel is used for important notification.",

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MyColors.generateMaterialColor(MyColors.colorPrimary),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fcmId = "";
  @override
  void initState() {
    if(Platform.isAndroid) {
      var initializationSettingsAndroid =
      AndroidInitializationSettings("app_icon");
      var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

      flutterLocalNotificationsPlugin.initialize(initializationSettings);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(channel.id, channel.name,
                      //,Remove this channel.description,
                      icon: "app_icon")));
        }
      });
      getToken();
    }
    directTo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("token");
    print(token);
    print("token");
    insertUserFCM(token!);
  }

  Future<void> insertUserFCM(String token) async {
    Map<String, dynamic> data = new Map();
    data['fcm'] = token;

    print(data);

    Response response = await APIService().insertUserFCM(data);

    print("response.message");
    print(response.message);
  }

  void directTo() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const Dashboard()),
              (Route<dynamic> route) => false);
    });

  }
}
