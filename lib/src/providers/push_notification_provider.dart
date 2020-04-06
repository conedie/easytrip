import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificactionProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //pedimos permisos patra usar las notificaciones

  initNotificationPermissions() {
    _firebaseMessaging.requestNotificationPermissions();
    //obtenemos token
    _firebaseMessaging.getToken().then((token) {
      print('===================');
      print(token);

      // cJhJcSgMHXU:APA91bH11LKmYe6LtVgoYsvTCFkDXGaHx_SvOhMlLFqJaswicjGO6P4VZQO_xQNBzqv3nGwgTi1lSBkIwYYopLQTrem4jasKOGPf05h5x5QX4gTOiKl7wddEGLInvcQoen4CFtzjvoyX
    });

    _firebaseMessaging.configure(
        onMessage: (info) async {},
        onLaunch: (info) async {},
        onResume: (info) async {});
  }
}
