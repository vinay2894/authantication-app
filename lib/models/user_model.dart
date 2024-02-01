class UserModel {
  late String email;
  late String password;

  UserModel({
    required this.email,
    required this.password,
  });

  factory UserModel.fromMap({required Map data}) {
    return UserModel(
      email: data['email'],
      password: data['password'],
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'email': email,
      'password': password,
    };
  }
}
