import 'package:fakebook/ui/sign_up/cubit/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void register(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        print(value.user?.email);
        emit(RegisterSuccessState());
      },
    ).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  void createUser(
      {required String name, required String email, required String phone}) {


  }

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(RegisterChangePasswordVisibilityState());
  }
}
