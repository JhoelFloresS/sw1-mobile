// dashboard_screen.dart

import 'package:agenda_mobile/core/layouts/layout.dart';
import 'package:agenda_mobile/data/models/comunicados.dart';
import 'package:agenda_mobile/data/services/comunicado_service.dart';
import 'package:agenda_mobile/modules/dashboard/wdigets/calendar.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Layout(
      tittle: 'Comunicados',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Column(
                children: [
                  PlannerCalendar(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: FutureBuilder<List<Comunicado>>(
                      future: ComunicadoService(baseUrl: "http://192.168.100.158:8069").fetchComunicados(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No hay comunicados'));
                        }

                        final comunicados = snapshot.data!;

                        return ListView.builder(
                          itemCount: comunicados.length,
                          itemBuilder: (context, index) {
                            final comunicado = comunicados[index];
                            return GestureDetector(
                              onTap: () {
                                // Navegar a la vista del comunicado
                              },
                              child: Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    comunicado.asunto,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    comunicado.contenido,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Text(
                                    '${comunicado.fechaEnvio.hour}:${comunicado.fechaEnvio.minute} AM',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
