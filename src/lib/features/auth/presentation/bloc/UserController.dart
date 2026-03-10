import 'package:get/get.dart';

//this is a hardcoded user to simulate a successful auth response
const _kHardcodedEmail = 'student@test.com';
const _kHardcodedPassword = '1234';
const _kHardcodedName = 'Theo James';

const _kProfessorEmail = 'professor@test.com';
const _kProfessorPassword = '1234';
const _kProfessorName = 'Josh Doe';

class UserController extends GetxController {
  final _loggedIn = false.obs;
  final _userName = ''.obs;
  final _userEmail = ''.obs;

  bool get isLoggedIn => _loggedIn.value;
  String get userName => _userName.value;
  String get userEmail => _userEmail.value;

  /// returns true and navigates to /home-student if credentials match or eturns false otherwise
  bool login(String email, String password) {
    // check if credentials match student
    if (email == _kHardcodedEmail && password == _kHardcodedPassword) {
      _loggedIn.value = true;
      _userName.value = _kHardcodedName;
      _userEmail.value = email;
      Get.toNamed('/home-student');
      return true;
    }
    // check if credentials match professor
      if (email == _kProfessorEmail && password == _kProfessorPassword) {
    _loggedIn.value = true;
    _userName.value = _kProfessorName;
    _userEmail.value = email;

    Get.toNamed('/home-professor');
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
