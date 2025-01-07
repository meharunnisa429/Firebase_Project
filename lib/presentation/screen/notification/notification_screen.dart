import 'package:firebase_project/package/firebase/firebase_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // checking whether permission denied
                await Permission.notification.request();

                if(await Permission.notification.isDenied) {
                  // requesting notificaton permission on run time
                  await Permission.notification.request();
                }
                await FirebaseNotificationService().showNotification();
              },
              child: const Text("Show Notification"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (await Permission.notification.isDenied) {
                  // requesting notification permission on run time
                  await Permission.notification.request();
                }

                
                await FirebaseNotificationService().simulateDownload();
              },
              child: Text("Show Progress Notification"),
            ),

             ElevatedButton(
              onPressed: () async {
                if (await Permission.notification.isDenied) {
                  // requesting notification permission on run time
                  await Permission.notification.request();
                }
                  await FirebaseNotificationService().showImageNotification(
                    title: "Sample title",
                    body: "Sample body",
                    image:
                        "https://img-mm.manoramaonline.com/content/dam/mm/mo/news/just-in/images/2024/11/16/bhothathankettu-kseb-1.jpg?w=1120&h=583");
               
              },
              child: Text("Show Image Notification"),
            ),
          ],
        ),
      ),
    );
  }
}
