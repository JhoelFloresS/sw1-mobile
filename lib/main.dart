import 'package:agenda_mobile/core/settings/settings_local_notifications.dart';
import 'package:agenda_mobile/data/services/auth_service.dart';
import 'package:agenda_mobile/data/services/comunicado_service.dart';
import 'package:agenda_mobile/modules/dashboard/blocs/comunicados/comunicados_bloc.dart';
import 'package:agenda_mobile/modules/dashboard/blocs/notification/notifications_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/auth/blocs/blocs.dart';
import 'app.dart';



void main() async {

  void setupFirebaseListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Message received: ${message.notification?.title}, ${message.notification?.body}');

    if (message.notification != null) {
      // Muestra la notificación usando flutter_local_notifications
      await SettingsLocalNotifications.showLocalNotification(
        id: message.hashCode,
        title: message.notification?.title ?? 'Nueva Notificación',
        body: message.notification?.body ?? '',
        data: message.data['payload'], // Puedes usar esto para manejar clics en la notificación
      );
    }
  });
}

  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await SettingsLocalNotifications.initializeLocalNotifications();
  await SettingsLocalNotifications.requestLocalNotificationPermission();
  await NotificationsBloc.initializeFCM();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $fcmToken');

  setupFirebaseListeners();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotificationsBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthService()),
        ),
        BlocProvider<ComunicadoBloc>(
          create: (context) =>
              ComunicadoBloc(comunicadoService: ComunicadoService(), authBloc: context.read<AuthBloc>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
