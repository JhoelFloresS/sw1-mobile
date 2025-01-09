import 'package:agenda_mobile/data/models/comunicados.dart';
import 'package:agenda_mobile/modules/dashboard/screens/comunicados_details_screen.dart';
import 'package:agenda_mobile/modules/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
// Importar las pantallas o módulos necesarios
import 'modules/auth/screens/login_screen.dart';
// import 'modules/dashboard/screens/dashboard_screen.dart';
// import 'modules/tasks/screens/tasks_screen.dart';
// import 'modules/announcements/screens/announcements_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
    '/': (context) => DashboardScreen(),
    '/login': (context) => LoginScreen(),
    '/comunicado_detail': (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Comunicado;
      return ComunicadoDetailScreen(comunicado: args);
    },
//   '/tasks': (context) => TasksScreen(),
//   '/announcements': (context) => AnnouncementsScreen(),
};
