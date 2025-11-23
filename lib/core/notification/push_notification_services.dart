import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../network/token_storage.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print(
    '''Start `handleBackgroundMessage of vm:entry-point` |FirebaseMessagingService| 
            Notification title: ${message.notification?.title}
            Notification body: ${message.notification?.body}
            Message data: ${message.data}
      ''',
  );
}

class FirebaseMessagingService {
  RemoteMessage? localMessage;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // final CacheService cacheService;

  FirebaseMessagingService();

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for Important notifications',
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> requestPermissionNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> initNotificationsSettings() async {
    print('Start `initNotificationsSettings` |FirebaseMessagingService|');
    await requestPermissionNotifications();
    NotificationSettings settings = await _firebaseMessaging.getNotificationSettings();
    print('Authorization status: ${settings.authorizationStatus}');

    await getToken();
    await initForegroundNotifications();
    await initBackgroundNotifications();
    print('End `initNotificationsSettings` |FirebaseMessagingService|');
  }

  Future<bool> isNotificationPermissionGranted() async {
    NotificationSettings settings = await _firebaseMessaging
        .getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<String?> getToken() async {
    String? token;
    try {
      token = await FirebaseMessaging.instance.getToken();
      TokenStorage.saveDeviceToken(token!);
      var test = await TokenStorage.getDeviceToken();
      print('fcm_token');
      print(test);
      // cacheService.setData(key: AppKeys.deviceToken, value: token);
      print(
        'End `getToken` |FirebaseMessagingService| deviceToken is: `$token`',
      );
      return token;
    } catch (e) {
      print('End `getToken` |FirebaseMessagingService| Exception: `$e`');
    }
    return null;
  }

  Future<void> deleteToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
      TokenStorage.clearDeviceToken();
      // cacheService.setData(key: AppKeys.deviceToken, value: null);
    } catch (e) {
      print('End `deleteToken` |FirebaseMessagingService| Exception: `$e`');
    }
  }

  Future<void> subscribeToTopic(String name) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(name);
      print(FirebaseMessaging.instance.subscribeToTopic(name));
      print("FirebaseMessaging.instance.subscribeToTopic(name);");
      print(name);
    } catch (e) {
      print(
        'End `subscribeToTopic` |FirebaseMessagingService| Exception: `$e`',
      );
    }
  }

  Future<void> subscribeToMultipleTopics(
      int userId,
      List<String> topics,
      ) async {
    try {
      print("lplplp");
      for (final topic in topics) {
        await FirebaseMessaging.instance.subscribeToTopic(topic);
        print("✅ Subscribed to topic: $topic");
      }

      await FirebaseMessaging.instance.subscribeToTopic('vendor_$userId');
      print("✅ Subscribed to user topic: vendor_$userId");
    } catch (e) {
      print('❌ Error subscribing to topics: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String name) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(name);
    } catch (e) {
      print(
        'End `unsubscribeFromTopic` |FirebaseMessagingService| Exception: `$e`',
      );
    }
  }

  Future<void> unsubscribeFromMultipleTopics(
      int userId,
      List<String> topics,
      ) async {
    try {
      for (final topic in topics) {
        await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
        print("🚫 Unsubscribed from topic: $topic");
      }

      await FirebaseMessaging.instance.unsubscribeFromTopic('user_$userId');
      print("🚫 Unsubscribed from user topic: vendor_$userId");
    } catch (e) {
      print('❌ Error unsubscribing: $e');
    }
  }

  Future<void> initForegroundNotifications() async {
    print('Start `initForegroundNotifications` |FirebaseMessagingService|');
    // LocalNotifications Settings
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
    >()
        ?.requestNotificationsPermission();

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
    >()
        ?.createNotificationChannel(_androidChannel);

    /// this callback will call when receive foreground notification
    FirebaseMessaging.onMessage.listen(onReceiveForegroundMessage);

    /// this callback will call when click on received foreground notification
    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onClickForegroundMessage,
    );
    print('End `initForegroundNotifications` |FirebaseMessagingService|');
  }

  Future<void> initBackgroundNotifications() async {
    print('Start `initBackgroundNotifications` |FirebaseMessagingService|');

    /// this callback will call when start app
    _firebaseMessaging.getInitialMessage().then(
      onGetInitialMessagesWhenStartApp,
    );

    /// this callback will call when click on received background notification
    FirebaseMessaging.onMessageOpenedApp.listen(onClickBackgroundMessage);

    /// this callback will call when receive background notification
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    print('End `initBackgroundNotifications` |FirebaseMessagingService|');
  }

  Future<void> onReceiveForegroundMessage(RemoteMessage message) async {
    print('''Start `onReceiveForegroundMessage` |FirebaseMessagingService| 
            Notification title: ${message.notification?.title}
            Notification body: ${message.notification?.body}
            Message data: ${message.data}
      ''');
    localMessage = message;
    if (localMessage?.notification == null) return;

    if (message.data['type'] == 'accept_user') {
      // getIt<RouterService>().router.go(
      //   AppRoutes.mainScreen,
      // );
    }

    if (message.data['type'] == 'reject_user') {
      // getIt<RouterService>().router.go(
      //   AppRoutes.verifyIdentityScreen,
      // );
    }

    _flutterLocalNotificationsPlugin.show(
      localMessage.hashCode,
      localMessage?.notification?.title,
      localMessage?.notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
    print('End `onReceiveForegroundMessage` |FirebaseMessagingService|');
  }

  Future<void> onClickForegroundMessage(
      NotificationResponse? notificationResponse,
      ) async {
    print('''Start `onClickForegroundMessage` |FirebaseMessagingService| 
            Notification title: ${localMessage?.notification?.title}
            Notification body: ${localMessage?.notification?.body}
            Message data: ${localMessage?.data}
      ''');
    if (localMessage != null) {
      await clearLocalNotifications(localMessage!);
    }
    if (localMessage != null) {
      redirect(localMessage!);
    }
    print('End `onClickForegroundMessage` |FirebaseMessagingService|');
  }

  Future<void> onClickBackgroundMessage(RemoteMessage message) async {
    print('''Start `onClickBackgroundMessage` |FirebaseMessagingService| 
            Notification title: ${message.notification?.title}
            Notification body: ${message.notification?.body}
            Message data: ${message.data}
      ''');

    await clearLocalNotifications(message);
    redirect(message);
    print('End `onClickBackgroundMessage` |FirebaseMessagingService|`');
  }

  Future<void> onGetInitialMessagesWhenStartApp(RemoteMessage? message) async {
    print(
      '''Start `onGetInitialMessagesWhenStartApp` |FirebaseMessagingService| 
            Notification title: ${message?.notification?.title}
            Notification body: ${message?.notification?.body}
            Message data: ${message?.data}
      ''',
    );
    if (message == null) {
      print(
        'End `onGetInitialMessagesWhenStartApp` |FirebaseMessagingService|` message: `$message`',
      );
      return;
    }
    await clearLocalNotifications(message);
    print(
      'End `onGetInitialMessagesWhenStartApp` |FirebaseMessagingService|` message: `$message`',
    );
  }

  void redirect(RemoteMessage message) {
    if (message.data.containsKey('type')) {
      if (message.data['type'] == 'message') {
        // getIt<RouterService>().router.push(
        //   AppRoutes.mainScreen,
        //   extra: 1,
        // );
        return;
      }

      if (message.data['type'] == 'accept_user') {
        // getIt<RouterService>().router.go(
        //   AppRoutes.mainScreen,
        // );
        return;
      }
      if (message.data['type'] == 'reject_user') {
        // getIt<RouterService>().router.go(
        //       AppRoutes.verifyIdentityScreen,
        //     );
        return;
      }
    }
    if (message.data.containsKey('requestHashId')) {
      // getIt<RouterService>().router.push(
      //       AppRoutes.notificationPendingTransactionDetailsScreen,
      //       extra: message.data['requestHashId'],
      //     );
      return;
    }
    // getIt<RouterService>().router.push(
    //   AppRoutes.mainScreen,
    // );
  }

  Future<void> clearLocalNotifications(RemoteMessage message) async {
    print('Start `clearLocalNotifications` |FirebaseMessagingService|');
    await _flutterLocalNotificationsPlugin.cancel(message.hashCode);
    print('End `clearLocalNotifications` |FirebaseMessagingService|');
  }
}
