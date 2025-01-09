// lib/data/models/comunicado.dart
class Comunicado {
  final int id;
  final String asunto;
  final String contenido;
  final String fechaEnvio;
  final String destinatariosTipo;
  final List<Estudiante?> estudiantes;
  final String? curso;
  final String? paralelo;
  final List<Archivo?> archivos;

  Comunicado({
    required this.id,
    required this.asunto,
    required this.contenido,
    required this.fechaEnvio,
    required this.destinatariosTipo,
    required this.estudiantes,
    required this.curso,
    required this.paralelo,
    required this.archivos,
  });

  factory Comunicado.fromJson(Map<String, dynamic> json) {
    return Comunicado(
      id: json['id'],
      asunto: json['asunto'],
      contenido: json['contenido'],
      fechaEnvio: json['fecha_envio'],
      destinatariosTipo: json['destinatarios_tipo'],
      estudiantes: (json['estudiantes'] as List)
          .map((e) => Estudiante.fromJson(e))
          .toList(),
      curso: json['curso'],
      paralelo: json['paralelo'],
      archivos: (json['archivos'] as List)
          .map((e) => Archivo.fromJson(e))
          .toList(),
    );
  }
}

class Estudiante {
  final int id;
  final String name;

  Estudiante({required this.id, required this.name});

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Archivo {
  final int id;
  final String name;
  final String url;

  Archivo({required this.id, required this.name, required this.url});

  factory Archivo.fromJson(Map<String, dynamic> json) {
    return Archivo(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}
