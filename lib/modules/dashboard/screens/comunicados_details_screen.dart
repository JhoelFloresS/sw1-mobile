import 'package:agenda_mobile/core/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:agenda_mobile/data/models/comunicados.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ComunicadoDetailScreen extends StatelessWidget {
  final Comunicado comunicado;

  const ComunicadoDetailScreen({Key? key, required this.comunicado})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COMUNICADO"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              comunicado.asunto,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Fecha
            Text(
              'Fecha de envío: ${comunicado.fechaEnvio}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),

            // Contenido completo
            Text(
              comunicado.contenido,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Archivos (si hay)
            if (comunicado.archivos.isNotEmpty) ...[
              Text(
                'Archivos adjuntos:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: comunicado.archivos.map((archivo) {
                  return ListTile(
                    leading: Icon(Icons.attach_file),
                    title: Text(archivo!.name),
                    onTap: () {
                      // Abrir archivo o manejar interacción
                      launchUrlString(apiBack + archivo.url);
                    },
                  );
                }).toList(),
              ),
            ],

            // Destinatarios
            // if (comunicado.estudiantes.isNotEmpty) ...[
            //   const SizedBox(height: 20),
            //   Text(
            //     'Destinatarios:',
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            //   ),
            //   Text(comunicado.estudiantes.join(', ')),
            // ],
          ],
        ),
      ),
    );
  }
}
