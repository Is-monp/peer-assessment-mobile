import 'package:get/get.dart';

class UserController extends GetxController {
  final _loggedIn = false.obs;
  final _userName = ''.obs;
  final _userEmail = ''.obs;
  final _userPassword = ''.obs;

  bool get isLoggedIn => _loggedIn.value;
  String get userName => _userName.value;
  String get userEmail => _userEmail.value;
  String get userPassword => _userPassword.value;

  void testLogin(String name, String email, String password) {
    _loggedIn.value = !_loggedIn.value;
    _userName.value = name;
    _userEmail.value = email;
    _userPassword.value = password;
  }
}
