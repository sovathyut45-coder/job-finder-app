import '../datasource/auth_datasource.dart';

class AuthRepository {

  final AuthDatasource datasource;

  AuthRepository(this.datasource);

  Future register({
    required String name,
    required String email,
    required String password,
  }) {
    return datasource.register(
      name: name,
      email: email,
      password: password,
    );
  }

  Future login({
    required String email,
    required String password,
  }) {
    return datasource.login(
      email: email,
      password: password,
    );
  }

  Future profile(String token) {
    return datasource.profile(token);
  }
}