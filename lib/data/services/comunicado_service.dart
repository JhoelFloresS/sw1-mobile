import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comunicados.dart';

class ComunicadoService {
  final String baseUrl;
  final String sessionId = '42fb70afba04bbb162bd852547bd7a321f17ce5f';

  ComunicadoService({required this.baseUrl});

  Future<List<Comunicado>> fetchComunicados() async {
    final response = await http.get(Uri.parse('$baseUrl/api/comunicados'),
    headers: {
        'Cookie': 'session_id=$sessionId', // Enviar session_id como cookie
      },);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Comunicado.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load announcements');
    }
  }
}
