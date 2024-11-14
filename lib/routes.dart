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
//   '/tasks': (context) => TasksScreen(),
//   '/announcements': (context) => AnnouncementsScreen(),
};
