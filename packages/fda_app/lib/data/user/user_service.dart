import 'package:dio/dio.dart';
import 'package:fda_app/config/https/http_service.dart';
import 'package:fda_app/data/user/user.dart';

class UserService {
  UserService._privateConstructor();

  static final UserService _instance = UserService._privateConstructor();

  factory UserService() {
    return _instance;
  }
  User? user;
  Future<void> login(String email, String password) async {
    try {
      final Response response = await HttpService().request(
          url: "authentication/login",
          method: Method.POST,
          params: {'email': email, 'password': password});
      user = User.fromJson(response.data["user"]);
      print(user);
    } catch (e) {
      print(e);
    }
  }
}
