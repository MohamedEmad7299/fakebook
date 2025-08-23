import 'package:fakebook/features/login/domain/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

void togglePasswordVisibility(WidgetRef ref) {
  ref.read(passwordVisibilityProvider.notifier).state =
      !ref.read(passwordVisibilityProvider.notifier).state;
}

final loginProvider =
    FutureProvider.family<void, LoginRequest>((ref, request) async {
  return LoginRepository()
      .login(email: request.email, password: request.password);
});

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});
}

final loadingProvider = StateProvider<bool>((ref) => false);
