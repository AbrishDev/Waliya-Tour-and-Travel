// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
 Future<void> signup(String username, String fullName, String email, String password, String phone) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/auth/signup'), // Replace with your actual backend URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('User signed up: ${data['user']}');
    } else {
      print('Failed to sign up with status code: ${response.statusCode}');
      final errors = jsonDecode(response.body);
      print('Error: ${errors['message']}');
    }
  }

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data; // Return the user data if needed
    } else {
      final errors = jsonDecode(response.body);
      throw Exception(errors['errors']);
    }
  }
}
