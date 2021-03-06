class BaseUser {
  final int id;
  final String username;
  final String? password;
  final String? token;

  BaseUser(
      {required this.id, required this.username, this.password, this.token});
}
