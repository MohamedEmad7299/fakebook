
import '../../../core/services/auth_service.dart';
import '../../../core/di/service_locator.dart';

class RegisterRepository{

  final AuthService _authService = serviceLocator<AuthService>();

  Future <void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {

    return await _authService.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
  }
}
