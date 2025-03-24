


abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  //
  // final LoginModel loginResponse;
  // LoginSuccessState(this.loginResponse);
}
class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
class LoginChangePasswordVisibilityState extends LoginState {}