import 'package:fakebook/features/login/domain/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

void loginTogglePasswordVisibility(WidgetRef ref) {
  ref.read(loginPasswordVisibilityProvider.notifier).state =
      !ref.read(loginPasswordVisibilityProvider.notifier).state;
}

final loginProvider =
    FutureProvider.family<void, LoginRequest>((ref, request){
  return LoginRepository()
      .login(email: request.email, password: request.password);
});

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});
}

final loginLoadingProvider = StateProvider<bool>((ref) => false);
