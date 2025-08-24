
import 'package:fakebook/features/register/domain/register_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

void registerTogglePasswordVisibility(WidgetRef ref) {
  ref.read(registerPasswordVisibilityProvider.notifier).state =
  !ref.read(registerPasswordVisibilityProvider.notifier).state;
}

final registerLoadingProvider = StateProvider((ref) => false);

final registerProvider = FutureProvider.family<void,RegisterRequest>((ref , request) async {

  await RegisterRepository().register(
      name: request.name,
      email: request.email,
      password: request.password,
      phone: request.phone);
});

class RegisterRequest {

  final String name;
  final String email;
  final String password;
  final String phone;

  RegisterRequest(this.name, this.email, this.password, this.phone);
}