import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/auth_service.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginState> {

  final AuthService authService = serviceLocator<AuthService>();

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) =>
      BlocProvider.of<LoginCubit>(context);

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      await authService.signIn(email: email, password: password);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginChangePasswordVisibilityState());
  }
}
