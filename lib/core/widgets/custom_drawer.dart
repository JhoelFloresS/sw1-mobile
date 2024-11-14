// custom_drawer.dart

import 'package:flutter/material.dart';
import 'package:agenda_mobile/routes.dart'; // Asegúrate de importar el archivo de rutas

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Usuario"),
            accountEmail: Text("usuario@ejemplo.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40),
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Comunicados'),
            onTap: () {
              // Navegar a la pantalla de comunicados
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: () {
              // Cerrar sesión
            },
          ),
        ],
      ),
    );
  }
}
