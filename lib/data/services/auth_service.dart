import 'dart:convert';
import 'package:agenda_mobile/core/constants/api.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl =  apiBack;

  AuthService();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['result'] != null && responseBody['result']['status'] == 'success') {
          return {
            // 'token': responseBody['result']['token'],
            'token' : response.headers['set-cookie']!.split(';')[0].split('=')[1],
            'user': responseBody['result']['user'],
          };
        } else {
          throw Exception('Autenticación fallida: ${responseBody['result']['status']}');
        }
      } else {
        throw Exception('Error en el servidor: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
