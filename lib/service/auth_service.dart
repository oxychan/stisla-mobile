// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  String token;

  AuthService({
    required this.token,
  });

  factory AuthService.createObjectResult(Map<String, dynamic> objectResult) {
    return AuthService(token: objectResult['token']);
  }

  static Future<AuthService> requestLogin(String email, String password) async {
    var apiUrl = Uri.http('192.168.100.96:8000', '/api/auth/login');

    var response = await http.post(apiUrl, body: {
      "email": email,
      "password": password,
      "device_name": "laptop",
    });

    print(response.statusCode);
    var jsonObject = json.decode(response.body);

    return AuthService.createObjectResult(jsonObject);
  }
}
