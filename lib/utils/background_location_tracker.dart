import 'dart:isolate';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:tracker_app/utils/handle_location_permission.dart';
import 'package:tracker_app/utils/save_location.dart';

import '../firebase_options.dart';
import '../models/user_location.dart';
import 'get_location.dart';

void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _sendPort = sendPort;
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    handleLocationPermission().then(
      (permission) {
        if (permission) {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final userLocation = UserLocation(
              userId: user.uid,
              timeStamp: DateTime.now().toUtc(),
              userName: user.displayName ?? "",
              userEmail: user.email ?? "",
              latitude: "",
              longitude: "longitude",
            );
            getLocation(userLocation).then((updatedUserLocation) {
              FlutterForegroundTask.updateService(
                notificationTitle: 'Tracking Location',
                notificationText: updatedUserLocation.toString(),
              );
              saveLocation(updatedUserLocation);
            });
          }
        }
      },
    );
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    await FlutterForegroundTask.clearAllData();
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp("/home");
    _sendPort?.send('onNotificationPressed');
  }
}
