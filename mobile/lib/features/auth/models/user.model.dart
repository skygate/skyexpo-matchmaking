class User {
  String id;
  String email;
  String name;
  String token;
  User({this.id, this.email, this.name, this.token});

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'token': token,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      token: json['token'],
    );
  }
}
