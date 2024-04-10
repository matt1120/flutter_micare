import 'dart:convert';

class RegisterFormModel {
  final String firstName;
  final String lastName;
  final String contactNumber;
  final String email;

  RegisterFormModel({
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.email,
  });

  factory RegisterFormModel.fromRawJson(String str) =>
      RegisterFormModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterFormModel.fromJson(Map<String, dynamic> json) =>
      RegisterFormModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        contactNumber: json["contactNumber"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "contactNumber": contactNumber,
        "email": email,
      };
}
