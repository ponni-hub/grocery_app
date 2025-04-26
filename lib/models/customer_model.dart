class CustomerModel {
  String? email;
  String? fullName;
  String? password;

  CustomerModel({this.fullName, this.email, this.password});

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {};

    map.addAll(
      {
        'email': email,
        'first_name': fullName,
        'password': password,
        'username': email,
      },
    );
    return map;
  }
}
