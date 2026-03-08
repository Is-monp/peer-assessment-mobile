import 'package:get/get.dart';

//this is a hardcoded user to simulate a successful auth response
const _kHardcodedEmail = 'student@test.com';
const _kHardcodedPassword = '1234';
const _kHardcodedName = 'Theo James';

class UserController extends GetxController {
  final _loggedIn = false.obs;
  final _userName = ''.obs;
  final _userEmail = ''.obs;

  bool get isLoggedIn => _loggedIn.value;
  String get userName => _userName.value;
  String get userEmail => _userEmail.value;

  /// returns true and navigates to /home-student if credentials match or eturns false otherwise
  bool login(String email, String password) {
    if (email == _kHardcodedEmail && password == _kHardcodedPassword) {
      _loggedIn.value = true;
      _userName.value = _kHardcodedName;
      _userEmail.value = email;
      Get.toNamed('/home-student');
      return true;
    }
    return false;
  }

  void logout() {
    _loggedIn.value = false;
    _userName.value = '';
    _userEmail.value = '';
    Get.offAllNamed('/');
  }
}
