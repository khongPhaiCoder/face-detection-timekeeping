import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? email;
  final String? name;

  const User({
    this.name,
    this.email,
    this.id,
  });
  List<Object?> get props => [
        id,
        name,
        email,
      ];
  Map<String, dynamic> toJson() => {
        "_id": this.id,
        "email": this.email,
        "name": this.name,
      };
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
      );
}
