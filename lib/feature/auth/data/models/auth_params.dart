// String email,
// String password,
// String name,
// String confirmPassword,
class AuthParams {
  String? name;
  String? email;
  String? password;
  String? confirmPassord;

  AuthParams({this.name, this.email, this.password, this.confirmPassord});
  factory AuthParams.fromJson(Map<String, dynamic> json) {
    return AuthParams(
      name: json["name"],
      email: json['email'],
      password: json['password'],
      confirmPassord: json["password_confirmation"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassord,
    };
  }
}
