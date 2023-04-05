import 'package:dio/dio.dart';
import 'package:fda_app/config/https/http_service.dart';
import 'package:fda_app/data/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<User> login(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fcmToken = prefs.getString('fcmToken');

      final Response response = await HttpService().request(
          url: "authentication/login",
          method: Method.POST,
          params: {
            'device_token': fcmToken,
            'email': email,
            'password': password
          });
      User user = User.fromJson(response.data["user"]);
      return user;
    } catch (e) {
      throw "Sai thông tin!";
    }
  }
}
