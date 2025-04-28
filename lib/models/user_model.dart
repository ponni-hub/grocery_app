class UserModel {
  final int id;
  final String email;
  final String nicename;
  final String firstName;
  final String lastName;
  final String displayName;

  UserModel({
    required this.id,
    required this.email,
    required this.nicename,
    required this.firstName,
    required this.lastName,
    required this.displayName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      nicename: json['nicename'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      displayName: json['displayName'],
    );
  }
}
