import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Use your local IP address (make sure Django runs with: python manage.py runserver 0.0.0.0:8000)
const String baseUrl = 'http://192.168.19.107:8000';

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref));

class AuthService {
  final Ref _ref;
  AuthService(this._ref);

  static const String _loginUrl = '$baseUrl/api/auth/login/';
  static const String _signupUrl = '$baseUrl/api/auth/signup/';

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final authToken = responseData['access']; // JWT token
        if (authToken != null) {
          await _saveAuthToken(authToken);
          return true;
        } else {
          return false;
        }
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['detail'] ?? 'Invalid credentials.';
        throw Exception(errorMessage);
      }
    } catch (error) {
      print('Login error: $error');
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_signupUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': email,
          'password': password,
          'email': email,
          'first_name': name,
          'phone': phone ?? '', // optional
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessages = errorData.values
            .map((e) => e is List ? e.join(' ') : e.toString())
            .join(' ');
        throw Exception(errorMessages);
      }
    } catch (error) {
      print('Registration error: $error');
      return false;
    }
  }

  Future<void> _saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
