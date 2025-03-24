

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState(this.error);
}
class RegisterChangePasswordVisibilityState extends RegisterState {}

class CreateUserErrorState extends RegisterState {}
class CreateUserSuccessState extends RegisterState {}