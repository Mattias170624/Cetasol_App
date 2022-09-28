class UserModel {
  String? email;
  int? phone;

  UserModel(this.email, this.phone);

  // Method used for handling database objects
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
    };
  }
}
