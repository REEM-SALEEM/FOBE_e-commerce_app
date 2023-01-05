class SignUpModel {
  final String fullName;
  final String email;
  final String phone;
  final String password;

  SignUpModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
        fullName: json["fullname"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        password: json["password"] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      "fullname": fullName,
      "email": email,
      "phone": phone,
      "password": password,
    };
  }
}