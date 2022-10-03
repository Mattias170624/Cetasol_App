// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetasol_app/Models/user_model.dart';

class FirestoreDatabase extends AuthService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> addNewUser(UserModel user) async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection('users');

    DocumentReference validNumbersRef =
        FirebaseFirestore.instance.collection('validnumbers').doc('numbers');

    late bool testResult1;
    late bool testResult2;

    // Add object to 'users' collection
    try {
      await userRef.add(user.toMap());
      print('Added user to users collection');
      testResult1 = true;
    } catch (error) {
      print(error);
      testResult1 = false;
    }

    try {
      await validNumbersRef.update({
        "numberarray": FieldValue.arrayUnion([user.phone])
      });
      print('Added users phone to valid numbers collection');
      testResult2 = true;
    } catch (error) {
      print(error);
      testResult2 = false;
    }

    return (testResult1 && testResult2);
  }

  Future<bool> checkDuplicatePhone(String usersPhone) async {
    DocumentReference validNumbersRef =
        FirebaseFirestore.instance.collection('validnumbers').doc('numbers');

    try {
      final response = await validNumbersRef.get();
      final numberArray = await response.get(FieldPath(['numberarray']));

      for (var number in numberArray) {
        if (number == usersPhone) {
          // Case on duplicate phone number
          return false;
        }
      }
      return true;
    } catch (error) {
      print('$error');
      return false;
    }
  }
}
