import 'dart:io';

import 'package:agenda_mobile/data/models/pushMessages.dart';
import 'package:agenda_mobile/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notifications_state.dart';
part 'notifications_event.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();


}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final Future<bool?> Function()? requestLocalNotificationPermissions;
  final void Function(
      {required int id,
      String? title,
      String? body,
      String? data,
      String? icon,
      String? action})? showLocalNotification;

  int pushNumberId = 0;
  NotificationsBloc(
      {this.requestLocalNotificationPermissions, this.showLocalNotification})
      : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessageReceived);

    // Verificar estado de las notificaciones
    _initialStatusCheck();

    // Listener para notificaciones en Foreground
    _onForegroundMessage();
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _onPushMessageReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) {
    emit(state
        .copyWith(notifications: [event.pushMessage, ...state.notifications]));
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
    _getFCMToken();
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print("TOKEN DE RECUPERACION$token");
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final notification = PushMessage(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl);

    if (showLocalNotification != null) {
      showLocalNotification!(
          id: ++pushNumberId,
          body: notification.body,
          data: notification.messageId,
          title: notification.title,
          icon: notification.imageUrl,
          action: notification.data?['buttonText'] ?? 'Ver');
    }

    add(NotificationReceived(notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (requestLocalNotificationPermissions != null) {
      await requestLocalNotificationPermissions!();
    }

    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  PushMessage? getMessageById(String pushMessageId) {
    final exist = state.notifications
        .any((element) => element.messageId == pushMessageId);
    if (!exist) return null;

    return state.notifications
        .firstWhere((element) => element.messageId == pushMessageId);
  }
}
