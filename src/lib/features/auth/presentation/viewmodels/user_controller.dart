import 'package:get/get.dart';
import '../../domain/models/authentication_user.dart';
import 'package:loggy/loggy.dart';

import '../../domain/repositories/i_auth_repository.dart';

//this is a hardcoded user to simulate a successful auth response
//const _kHardcodedEmail = 'sebastianotero@uninorte.edu.co';
//const _kHardcodedPassword = 'Hola123.';
//const _kHardcodedName = 'Sebastian Monsalve';
//
//const _kProfessorEmail = 'professor@test.com';
//const _kProfessorPassword = 'Hola123';
//const _kProfessorName = 'Josh Doe';

class UserController extends GetxController {
  final IAuthRepository authentication;
  final logged = false.obs;
  final _loggedUser = Rxn<AuthenticationUser>();
  final RxBool isLoading = false.obs;

  UserController(this.authentication);

  AuthenticationUser? get loggedUser => _loggedUser.value;

  set loggedUser(AuthenticationUser? user) {
    _loggedUser.value = user;
  }

  bool get isLoggedIn => logged.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    logInfo('AuthenticationController initialized');
    logged.value = await validateToken();
  }

  bool get isLogged => logged.value;

  /// returns true and navigates to /home-student if credentials match or eturns false otherwise
  Future<bool> login(String email, String password) async {
    // check if credentials match student
    logInfo('AuthenticationController: Login $email $password');
    await authentication.login(email, password);
    await getLoggedUser();
    logged.value = true;
    Get.toNamed('/home-professor');
    return true;
    //if (email == _kHardcodedEmail && password == _kHardcodedPassword) {
    //  logInfo('AuthenticationController: Login $email $password');
    //  await authentication.login(email, password);
    //  await getLoggedUser();
    //  logged.value = true;
    //  Get.toNamed('/home-student');
    //  return true;
    //}
    // check if credentials match professor
    //if (email == _kProfessorEmail && password == _kProfessorPassword) {
    //  logged.value = true;
    //  _userName.value = _kProfessorName;
    //  _userEmail.value = email;
    //
    //  Get.toNamed('/home-professor');
    //  return true;
    //}
    //return false;
  }

  Future<bool> signUp(
    String name,
    String email,
    String password,
    bool direct,
  ) async {
    logInfo('AuthenticationController: Sign Up $email $password');
    await authentication.signUp(email, password, name, direct);
    return true;
  }

  Future<bool> validate(String email, String validationCode) async {
    logInfo('Controller Validate $email $validationCode');
    var rta = await authentication.validate(email, validationCode);
    return rta;
  }

  Future<void> logOut() async {
    logInfo('AuthenticationController: Log Out');
    logged.value = false;
    await authentication.logOut();
    logged.value = false;
    //temporal
    Get.offAllNamed('/');
  }

  Future<bool> validateToken() async {
    logInfo('validateToken: validateToken');
    var rta = await authentication.validateToken();
    if (rta) {
      await getLoggedUser();
    }
    return rta;
  }

  Future<void> forgotPassword(String email) async {
    logInfo('AuthenticationController: Forgot Password $email');
    await authentication.forgotPassword(email);
  }

  Future<AuthenticationUser> getLoggedUser() async {
    logInfo('AuthenticationController: Get Logged User');
    isLoading.value = true;
    var rta = await authentication.getLoggedUser();
    _loggedUser.value = rta;
    isLoading.value = false;
    return rta;
  }

  Future<List<AuthenticationUser>> getUsers() async {
    logInfo('AuthenticationController: Get Users');
    var rta = await authentication.getUsers();
    return rta;
  }
}
