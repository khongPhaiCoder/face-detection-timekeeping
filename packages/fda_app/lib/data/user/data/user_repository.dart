import 'package:dio/dio.dart';
import 'package:fda_app/config/https/http_service.dart';
import 'package:fda_app/data/user/user.dart';

class UserRepository {
  Future<User> login(String email, String password) async {
    try {
      final Response response = await HttpService().request(
          url: "authentication/login",
          method: Method.POST,
          params: {'email': email, 'password': password});
      User user = User.fromJson(response.data["user"]);
      return user;
    } catch (e) {
      throw "Sai thông tin!";
    }
  }
}
