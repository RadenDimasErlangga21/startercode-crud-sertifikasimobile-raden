class User {
  int? id;
  late String username;
  late String password;

  User({
    this.id,
    required this.username,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    var mapping = <String, dynamic>{};
    if (id != null) {
      mapping['id'] = id;
    }
    mapping['username'] = username;
    mapping['password'] = password;

    return mapping;
  }
}
