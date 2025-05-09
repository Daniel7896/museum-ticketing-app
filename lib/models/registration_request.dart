// lib/models/registration_request.dart
class RegistrationRequest {
  final String email;
  final String password;
  final String name;
  final String? phone;

  RegistrationRequest({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    if (phone != null) 'phone': phone,
  };
}