// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetasol_app/Models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreDatabase extends AuthService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> addNewUser(UserModel user) async {
    DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid);

    DocumentReference validNumbersRef =
        FirebaseFirestore.instance.collection('validnumbers').doc('numbers');

    late bool testResult1;
    late bool testResult2;

    // Add object to 'users' collection
    try {
      await userRef.set(user.toMap());
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

  Future<dynamic> addNewVessel2(Map<String, dynamic> parsedVesselMap) async {
    DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid);

    dynamic resultValue;
    final userDoc = await userRef.get();

    try {
      final vesselMap = userDoc.get('vessels') as Map;

      // Look for existing vessel
      vesselMap.forEach((key, value) {
        if (key == parsedVesselMap['Vessel name']) {
          throw ('A vessel already exists with the same name');
        }
      });

      // If no duplicate vessels found, then add current vessel
      await userRef.set({
        'vessels': {parsedVesselMap['Vessel name']: parsedVesselMap}
      }, SetOptions(merge: true)).catchError((e) {
        throw (e);
      });

      resultValue = true;
    } on StateError catch (error) {
      switch (error.message) {

        // Case if user has no registered vessels
        case 'field does not exist within the DocumentSnapshotPlatform':
          await userRef.update({
            'vessels': {parsedVesselMap['Vessel name']: parsedVesselMap}
          }).catchError((e) {
            resultValue = e;
          });
          break;

        case 'A vessel already exists with the same name':
          return resultValue = error.message;

        default:
          resultValue = error.message;
          break;
      }
    }
    return resultValue;
  }

  Future<dynamic> deleteVessel(Map selectedVessel) async {
    DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid);

    // Update user vessel list with removed selected vessel
    try {
      final vesselList = await userRef.get();
      final vesselMap = vesselList.get('vessels') as Map;
      vesselMap
          .removeWhere((key, value) => key == selectedVessel['Vessel name']);
      userRef.update({'vessels': vesselMap});

      return true;
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> addVesselImages(
      XFile image1, XFile image2, XFile image3, String vesselName) async {
    dynamic resultValue;
    // Firebase storage reference to users image
    Reference imageDirectoryRef = FirebaseStorage.instance
        .ref()
        .child(AuthService().auth.currentUser!.uid)
        .child(vesselName);

    // Add the images with thier own respective child name
    try {
      imageDirectoryRef.child('manufacturing_label').putFile(
            File(image1.path),
          );
      imageDirectoryRef.child('wiring_diagram_drivelines').putFile(
            File(image2.path),
          );
      imageDirectoryRef.child('wiring_diagram_navigation_system').putFile(
            File(image3.path),
          );

      resultValue = true;
    } catch (error) {
      resultValue = error;
    }
    return resultValue;
  }

  Future<dynamic> removeVesselImages(String vesselName) async {
    Reference imageDirectoryRef = FirebaseStorage.instance
        .ref()
        .child(AuthService().auth.currentUser!.uid)
        .child(vesselName);

    try {
      await imageDirectoryRef.child('manufacturing_label').delete();
      await imageDirectoryRef.child('wiring_diagram_drivelines').delete();
      await imageDirectoryRef
          .child('wiring_diagram_navigation_system')
          .delete();

      return true;
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> checkDuplicatePhone(String usersPhone) async {
    DocumentReference numberListRef =
        FirebaseFirestore.instance.collection('validnumbers').doc('numbers');
    try {
      final response = await numberListRef.get();
      final numberArray = await response.get(FieldPath(['numberarray']));

      // Check for duplicate phone number
      for (var number in numberArray) {
        if (number == usersPhone) {
          return false;
        }
      }

      return true;
    } on StateError catch (error) {
      switch (error.message) {

        // Case if there is no valid number list
        case 'cannot get a field on a DocumentSnapshotPlatform which does not exist':
          return true;

        default:
          print('EEEEEEEEEEEEEEEEEEEEEE');
          return error.message;
      }
    }
  }

  Future<bool> sendTicket(String problemType, String description) async {
    final user = AuthService().auth.currentUser!;
    DocumentReference ticketListRef =
        FirebaseFirestore.instance.collection('tickets').doc(user.uid);
    DateTime date = DateTime.now();
    final formattedDate = '${date.day}-${date.month}-${date.year}';

    List ticketObject = [
      {
        'type': problemType,
        'Sent date': formattedDate,
        'description': description,
        'contact': user.phoneNumber,
      }
    ];

    // Try adding a new ticket to database
    try {
      await ticketListRef.set({'tickets': FieldValue.arrayUnion(ticketObject)},
          SetOptions(merge: true));
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<dynamic> deleteNumberFromList() async {
    final phoneNum = AuthService().auth.currentUser!.phoneNumber;
    final numberRef =
        FirebaseFirestore.instance.collection('validnumbers').doc('numbers');
    dynamic resultValue;

    try {
      await numberRef.update({
        'numberarray': FieldValue.arrayRemove([phoneNum])
      });
      resultValue = true;
    } catch (error) {
      if (error.toString() ==
          '[cloud_firestore/not-found] Some requested document was not found.') {
        return resultValue = false;
      }
      resultValue = error;
    }

    return resultValue;
  }

  Future<dynamic> deleteUserDocument() async {
    final uid = AuthService().auth.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

    try {
      await userRef.delete();
      return true;
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> deleteUserTickets() async {
    final ticketRef = FirebaseFirestore.instance.collection('tickets');
    final uid = AuthService().auth.currentUser!.uid;

    try {
      await ticketRef.doc(uid).delete();
      return true;
    } catch (error) {
      return error;
    }
  }
}
