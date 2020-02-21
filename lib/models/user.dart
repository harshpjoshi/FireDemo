class User {
  final String name;
  final String email;
  final String id;

  User(this.name, this.email, this.id);

  factory User.fromMap(Map<String, dynamic> json, String id) {
    return User(json['name'], json['email'], json['id']);
  }

  Map<String, dynamic> toJson() => {'name': name, 'email': email, 'id': id};
}
