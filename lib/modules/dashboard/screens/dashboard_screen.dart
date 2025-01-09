import 'package:agenda_mobile/core/layouts/layout.dart';
import 'package:agenda_mobile/data/services/comunicado_service.dart';
import 'package:agenda_mobile/modules/dashboard/blocs/comunicados/comunicados_bloc.dart';
import 'package:agenda_mobile/modules/dashboard/blocs/notification/notifications_bloc.dart';
import 'package:agenda_mobile/modules/dashboard/wdigets/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    child: BlocBuilder<ComunicadoBloc, ComunicadoState>(
                      builder: (context, state) {
                        String currentDate =
                            DateTime.now().toString().split(' ')[0];
                        if (state is ComunicadoInitial) {
                          context
                              .read<ComunicadoBloc>()
                              .add(FetchComunicadosEvent(fecha: currentDate));
                        }
                        if (state is ComunicadoLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (state is ComunicadoError) {
                          return Center(child: Text('Error: ${state.error}'));
                        }

                        if (state is ComunicadoLoaded) {
                          final comunicados = state.comunicados;

                          if (comunicados.isEmpty) {
                            return Center(child: Text('No hay comunicados'));
                          }

                          return ListView.builder(
                            itemCount: comunicados.length,
                            itemBuilder: (context, index) {
                              final comunicado = comunicados[index];
                              return GestureDetector(
                                onTap: () {
                                  // Navegar a la vista del comunicado
                                    Navigator.pushNamed(
                                      context,
                                      '/comunicado_detail',
                                      arguments: comunicado, // Pasar el comunicado actual
                                    );
                                },
                                child: Card(
                                  elevation: 2,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Título
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue.shade100,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            comunicado.asunto,
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        // Contenido
                                        Text(
                                          comunicado.contenido,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        // Hora
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            comunicado.fechaEnvio
                                                .split(' ')[1].split(':').sublist(0, 2).join(':') +
                                                // Agregar AM o PM
                                                (int.parse(comunicado.fechaEnvio.split(' ')[1].split(':')[0]) > 12 ? ' PM' : ' AM'),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return const Center(
                            child: Text('No hay comunicados disponibles'));
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
