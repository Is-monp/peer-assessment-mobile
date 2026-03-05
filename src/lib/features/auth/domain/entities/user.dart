class AuthUser {
  final String name;
  final String email;
  final String password;
  int? id;

  AuthUser({
    required this.name,
    required this.email,
    required this.password,
    this.id,
  });
}
