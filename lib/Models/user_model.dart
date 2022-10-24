class UserModel {
  String? email;
  String? phone;

  UserModel(this.email, this.phone);

  // Method used for creating user object in database
  Map<String, dynamic> userInfoToMap() {
    return {
      'email': email,
      'phone': phone,
    };
  }
}
