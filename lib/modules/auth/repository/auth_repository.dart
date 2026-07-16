import 'package:image_picker/image_picker.dart';

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

  Future logout(String token) {
    return datasource.logout(token: token);
  }

  Future profile(String token) {
    return datasource.profile(token);
  }

  Future forgotPassword(
    Map<String, dynamic> data
  ){
    return datasource.forgotPassword(data: data);
  }

  Future changePassword({
    required String token,
    required Map<String, dynamic> data,
  }) {
    return datasource.changePassword(token: token, data: data);
  }

  Future updateProfile({
    required String token,
    required String name,
    required String email,
  }) {
    return datasource.updateProfile(
      token: token,
      name: name,
      email: email,
    );
  }

  // Future uploadAvatar({
  //   required String token,
  //   required String imagePath,
  // }) {
  //   return datasource.uploadAvatar(
  //     token: token,
  //     imagePath: imagePath,
  //   );
  // }

  Future uploadAvatar({
    required String token,
    required XFile file,
  }) {
    return datasource.uploadAvatar(
      token: token,
      file: file,
    );
  }
}