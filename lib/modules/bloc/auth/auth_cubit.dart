import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/modules/models/user_model.dart';
import 'package:movies/modules/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.login(email, password);
      final user = UserModel.fromJson(response.data);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure("Login failed: ${e.toString()}"));
    }
  }

  Future<void> register(String name, String email, String password, String phone) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.register(name, email, password, phone);
      final user = UserModel.fromJson(response.data);
      emit(AuthSuccess(user));
    } catch (e) {
      if (e is DioError) {
        final data = e.response?.data;
        emit(AuthFailure("Register failed: ${data ?? e.message}"));
      } else {
        emit(AuthFailure("Register failed: ${e.toString()}"));
      }
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await authRepository.resetPassword(email);
      emit(AuthSuccess(UserModel(name: "", email: email, token: "")));
    } catch (e) {
      emit(AuthFailure("Reset failed: ${e.toString()}"));
    }
  }
}
