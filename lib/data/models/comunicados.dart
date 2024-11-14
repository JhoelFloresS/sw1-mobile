// data/models/comunicado.dart

class Comunicado {
  final int id;
  final String asunto;
  final String contenido;
  final DateTime fechaEnvio;
  final String creadoPor;
  final List<Archivo> archivos;

  Comunicado({
    required this.id,
    required this.asunto,
    required this.contenido,
    required this.fechaEnvio,
    required this.creadoPor,
    required this.archivos,
  });

  factory Comunicado.fromJson(Map<String, dynamic> json) {
    return Comunicado(
      id: json['id'],
      asunto: json['asunto'] as String,
      contenido: json['contenido'] as String,
      fechaEnvio: DateTime.parse(json['fecha_envio']),
      creadoPor: json['creado_por'] as String,
      archivos: (json['archivos'] as List<dynamic>)
          .map((fileData) => Archivo.fromJson(fileData))
          .toList(),
    );
  }
}

// data/models/archivo.dart

class Archivo {
  final String nombre;
  final String url;

  Archivo({
    required this.nombre,
    required this.url,
  });

  factory Archivo.fromJson(Map<String, dynamic> json) {
    return Archivo(
      nombre: json['nombre'] as String,
      url: json['url'] as String,
    );
  }
}

