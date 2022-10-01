// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetasol_app/Models/user_model.dart';

class FirestoreDatabase extends AuthService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addNewUser(UserModel user) async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection('users');

    DocumentReference validNumbersRef =
        FirebaseFirestore.instance.collection('validnumbers').doc('numbers');

    // Add object to 'users' collection
    await userRef
        .add(user.toMap())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    // Add users phone to 'validnumbers' collection
    await validNumbersRef.update({
      "numberarray": FieldValue.arrayUnion([user.phone])
    }).onError(
      (error, stackTrace) => print(error),
    );
  }

  Future<bool> checkDuplicatePhone(String usersPhone) async {
    DocumentReference validNumbersRef =
        FirebaseFirestore.instance.collection('validnumbers').doc('numbers');

    bool finalResult = false;

    await validNumbersRef.get().then((result) {
      final validNumbers = result.get(FieldPath(['numberarray']));

      if (validNumbers == null) {
        // List does not exist
        return finalResult == false;
      }

      finalResult = true;
      for (var number in validNumbers) {
        if (number == usersPhone) {
          // Number duplicate found in database
          return finalResult = false;
        }
      }
    });

    return finalResult;
  }
}
