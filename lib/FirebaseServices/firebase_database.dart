// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetasol_app/Models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<bool> addNewVessel(Map<String, dynamic> parsedVesselMap) async {
    DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid);
    bool finalResult = false;

    var imageName1 = File(XFile(parsedVesselMap['Image 1']).path);
    var imageName2 = File(XFile(parsedVesselMap['Image 2']).path);
    var imageName3 = File(XFile(parsedVesselMap['Image 3']).path);
    final userUid = AuthService().auth.currentUser!.uid;
    final vesselName = parsedVesselMap['Vessel name'];

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages =
        referenceRoot.child(userUid).child(vesselName);

    Reference imageRef1 = referenceDirImages.child('manufacturing label');
    Reference imageRef2 = referenceDirImages.child('wiring_diagram_drivelines');
    Reference imageRef3 =
        referenceDirImages.child('wiring_diagram_navigation_system');

    try {
      await userRef.collection('Registered vessels list').get().then((result) {
        if (result.docs.isEmpty) {
          finalResult = true;
        } else {
          for (var element in result.docs) {
            if (element.id == parsedVesselMap['Vessel name']) {
              finalResult = false;
              return;
            }
          }
          finalResult = true;
        }
      });

      if (finalResult) {
        await userRef
            .collection('Registered vessels list')
            .doc('${parsedVesselMap['Vessel name']}')
            .set(parsedVesselMap);
      }
    } catch (error) {
      print(error);
      return false;
    }

    try {
      await imageRef1.putFile(imageName1);
      await imageRef2.putFile(imageName2);
      await imageRef3.putFile(imageName3);
    } catch (error) {
      finalResult = false;
      print(error);
    }

    return finalResult;
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
}
