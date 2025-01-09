// custom_drawer.dart

import 'package:agenda_mobile/modules/auth/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:agenda_mobile/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Asegúrate de importar el archivo de rutas

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    var user = context.read<AuthBloc>().state as Authenticated;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
            UserAccountsDrawerHeader(
            accountName: Text(user.session.user.name),
            accountEmail: Text(user.session.user.email),
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
              _cerrarSesion(context);
            },
          ),
        ],
      ),
    );
  }

  void _cerrarSesion(BuildContext context) {
    // Disparar el LogoutEvent al AuthBloc
    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());

    // Navegar a la pantalla de inicio de sesión
    Navigator.pushReplacementNamed(
        context, "/login"); // Asegúrate de tener la ruta '/login' configurada
  }
}
