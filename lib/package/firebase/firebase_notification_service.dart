import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  FirebaseNotificationService._();

  static final _instance = FirebaseNotificationService._();

  factory FirebaseNotificationService() => _instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future initializeNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tapped logic here
        log("Tapped");
      },
    );
  }

  Future<void> showNotification(
      {String? notificationTitle, String? notificationBody}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      notificationTitle ?? 'Test Notification',
      notificationBody ?? 'This is the body of the notification',
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

  Future<void> simulateDownload() async {
    int progress = 0;
    int maxProgress = 100;

    while (progress <= maxProgress) {
      await showProgressNotification(progress, maxProgress);
      await Future.delayed(const Duration(seconds: 1));
      progress += 1;
    }

    // Cancel the notification when done
    await flutterLocalNotificationsPlugin.cancel(1);
  }

  // To show the progress notification
  Future<void> showProgressNotification(int progress, int maxProgress) async {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "progrees_channel_id",
      "progress_channel",
      channelDescription: "progress_channel_description",
      importance: Importance.low,
      priority: Priority.low,
      showProgress: true,
      progress: progress,
      maxProgress: maxProgress,
    );

    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      1,
      "Downloading...",
      "Progress: ${(progress / maxProgress * 100).round()}%",
      notificationDetails,
      payload: 'item x',
    );
  }

  Future showImageNotification({
    required String title,
    required String body,
    required String? image,
  }) async {
    // image url to display
    const imageUrl =
        "https://img-mm.manoramaonline.com/content/dam/mm/mo/news/just-in/images/2024/11/16/bhothathankettu-kseb-1.jpg?w=1120&h=583";

    final response = await http.get(Uri.parse(imageUrl));
    final directory = Directory.systemTemp;
    final filePath = '${directory.path}/remote_image.jpg';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(filePath),
      largeIcon: FilePathAndroidBitmap(filePath),
      contentTitle: title,
      summaryText: body,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'image_channel_id',
      'image channel',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      styleInformation: bigPictureStyleInformation,
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      2, // notification id.
      title,
      body,
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }
}
