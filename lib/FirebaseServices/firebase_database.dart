import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetasol_app/Models/user_model.dart';

class FirestoreDatabase extends AuthService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addNewUser(UserModel user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .add(user.toMap())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
