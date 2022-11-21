// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String name;
  String email;

  User({
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static List<String> toStrList(User user) {
    return [
      user.name,
      user.email,
    ];
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
