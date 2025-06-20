import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://route-movie-apis.vercel.app/auth/",
    headers: {"Content-Type": "application/json"},
  ));

  Future<Response> login(String email, String password) {
    return _dio.post('login', data: {
      'email': email,
      'password': password,
    });
  }

  Future<Response> register(String name, String email, String password, String phone,) {
    return _dio.post('register', data: {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword':password,
      'phone': phone,
      'avatarId':3
    });
  }

  Future<Response> resetPassword(String email) {
    return _dio.patch('reset-password', data: {
      'email': email,
    });
  }
}
