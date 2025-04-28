import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  final String token;
  final String userEmail;
  final String userNicename;
  final String userDisplayName;
  final String id;

  LoginResponseModel({
    required this.token,
    required this.userEmail,
    required this.userNicename,
    required this.userDisplayName,
    required this.id,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      // Use null-aware operators to ensure default values if the field is null
      token: json["token"] ?? '',
      userEmail: json["userEmail"] ?? '',
      userNicename: json["userNicename"] ?? '',
      userDisplayName: json["userDisplayName"] ?? '',
      id: json["id"]?.toString() ?? '', // Ensure 'id' is always a string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userEmail': userEmail,
      'userNicename': userNicename,
      'userDisplayName': userDisplayName,
      'id': id,
    };
  }
}
