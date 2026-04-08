import 'package:src/features/auth/domain/models/authentication_user.dart';
import 'package:src/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';

class FakeAuthRepository extends IAuthRepository {
  @override
  Future<void> login(String email, String password) async {
    if (email != "a@a.com" || password != "123456") {
      throw Exception("Invalid email or password");
    }
  }

  @override
  Future<bool> validateToken() async => false;

  @override
  Future<AuthenticationUser> getLoggedUser() async {
    return AuthenticationUser(name: "a", email: "a@a.com", student: true);
  }

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<List<AuthenticationUser>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<bool> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String email, String password, String name, bool direct) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<bool> validate(String email, String validationCode) {
    // TODO: implement validate
    throw UnimplementedError();
  }

  // puedes dejar los demás vacíos si no los usas
}

class FakeUserController extends UserController {
  FakeUserController() : super(FakeAuthRepository());

  @override
  Future<bool> login(String email, String password) async {
    if (email == "a@a.com" && password == "123456") {
      logged.value = true;
      return true;
    } else {
      throw Exception("error");
    }
  }

  @override
  Future<bool> validateToken() async {
    return false;
  }

  @override
  Future<AuthenticationUser> getLoggedUser() async {
    final user = AuthenticationUser(name: "a", email: "a@a.com", student: true);
    loggedUser = user;
    return user;
  }
}
