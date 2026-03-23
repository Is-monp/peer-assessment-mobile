import 'package:get/get.dart';
import '../../domain/models/authentication_user.dart';
import 'package:loggy/loggy.dart';
import '../../domain/repositories/i_auth_repository.dart';

<<<<<<< Updated upstream
//Center cambio
import 'package:src/core/navigation/navigation_service.dart';

//this is a hardcoded user to simulate a successful auth response
//const _kHardcodedEmail = 'sebastianotero@uninorte.edu.co';
//const _kHardcodedPassword = 'Hola123.';
//const _kHardcodedName = 'Sebastian Monsalve';
//
//const _kProfessorEmail = 'professor@test.com';
//const _kProfessorPassword = 'Hola123';
//const _kProfessorName = 'Josh Doe';

=======
>>>>>>> Stashed changes
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
  bool get isLogged => logged.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    logInfo('AuthenticationController initialized');
    logged.value = await validateToken();
  }

  Future<bool> login(String email, String password) async {
    logInfo('AuthenticationController: Login $email $password');
    await authentication.login(email, password);
    await getLoggedUser();
    logged.value = true;
<<<<<<< Updated upstream
    NavigationService.toHomeProfessor();
=======
>>>>>>> Stashed changes
    return true;
  }

  Future<bool> signUp(String name, String email, String password, bool direct) async {
    logInfo('AuthenticationController: Sign Up $email $password');
    await authentication.signUp(email, password, name, direct);
    return true;
  }

  Future<bool> validate(String email, String validationCode) async {
    logInfo('Controller Validate $email $validationCode');
    return await authentication.validate(email, validationCode);
  }

  Future<void> logOut() async {
    logInfo('AuthenticationController: Log Out');
    await authentication.logOut();
<<<<<<< Updated upstream
    logged.value = false;
    //temporal
    NavigationService.toLogin();
=======
    logged.value = false; 
>>>>>>> Stashed changes
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
    return await authentication.getUsers();
  }
}