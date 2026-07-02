
import 'package:get_storage/get_storage.dart';

class AuthService {
  final box = GetStorage();

  String? get token =>
      box.read('token');

  bool get isLoggedIn =>
      token != null;

  void saveToken(
    String token,
  ) {
    box.write(
      'token',
      token,
    );
  }

  void clearToken() {
    box.remove('token');
  }
  
}