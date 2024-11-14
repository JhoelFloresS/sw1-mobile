// dashboard_screen.dart

import 'package:agenda_mobile/core/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Widget child;
  final String tittle;

  // Creamos un GlobalKey para el Scaffold

  Layout({super.key, required this.tittle, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asociamos el GlobalKey al Scaffold
      appBar: AppBar(
        title: Text(tittle),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Abrimos el Drawer usando el GlobalKey
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: CustomDrawer(), // Sidebar
      body: Center(
        child: child,
      ),
    );
  }
}
