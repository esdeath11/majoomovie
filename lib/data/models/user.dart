class User {
  final int? id;
  final String email;
  final String username;
  final String password;

  User(
      {this.id,
      required this.email,
      required this.username,
      required this.password});

  User.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        email = res['email'],
        username = res['username'],
        password = res['password'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password
    };
  }
}
