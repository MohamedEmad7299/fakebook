

import '../../../core/di/service_locator.dart';
import '../../../core/services/auth_service.dart';

class LoginRepository{

  final AuthService authService = serviceLocator<AuthService>();

  Future<void> login({required String email, required String password}) async {

    await authService.login(email: email, password: password);
  }
}
