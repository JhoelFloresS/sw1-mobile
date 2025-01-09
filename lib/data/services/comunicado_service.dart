// lib/data/services/comunicado_service.dart

import 'dart:convert';
import 'dart:math';
import 'package:agenda_mobile/core/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:agenda_mobile/data/models/comunicados.dart';

class ComunicadoService {
  final String baseUrl;

  ComunicadoService({this.baseUrl = apiBack});

  Future<List<Comunicado>> fetchComunicados(String fecha, String token) async {
    print(token);
    final request = http.Request(
      'GET',
      Uri.parse('$baseUrl/api/comunicados?fecha=$fecha'),
    );

    request.body = jsonEncode({});
    request.headers.addAll({
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token',
      'Cookie': 'session_id=$token',
      // 'Cookie': 'session_id=$token',
    });
    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = json.decode(body)['result'];
      if (data['status'] == 'success') {
        return (data['data'] as List)
            .map((comunicado) => Comunicado.fromJson(comunicado))
            .toList();
      } else {
        throw Exception('Failed to load comunicados');
      }
    } else {
      throw Exception('Failed to load comunicados');
    }
  }
}
