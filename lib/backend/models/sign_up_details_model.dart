class SignUpDetailsModel {
  final String email;
  final String password;
  final String name;
  final String phone;

  SignUpDetailsModel({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> signUpJsonData = {};
    signUpJsonData['email'] = email;
    signUpJsonData['password'] = password;
    signUpJsonData['f_name'] = name;
    signUpJsonData['phone'] = phone;

    return signUpJsonData;
  }
}
