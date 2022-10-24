// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cetasol_app/FirebaseServices/firebase_database.dart';
import 'package:cetasol_app/Screens/vessel_form_screen.dart';
import 'package:cetasol_app/Widgets/NavScreenWidgets/VesselPage/vessel_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisteredVessels extends StatefulWidget {
  @override
  State<RegisteredVessels> createState() => _RegisteredVesselsState();
}

class _RegisteredVesselsState extends State<RegisteredVessels> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> _userDocSnapshot =
      FirebaseFirestore.instance
          .collection('users')
          .doc(AuthService().auth.currentUser!.uid)
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Registered vessels',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10, top: 5),
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: _userDocSnapshot,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    color: Colors.red,
                    child: Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  );
                }

                try {
                  final vesselList = snapshot.data?.get('vessels') as Map;
                  if (vesselList.isNotEmpty) {
                    List<Widget> listOfVesselTiles = [];

                    vesselList.forEach((key, value) {
                      listOfVesselTiles.add(_createVesselTile(value));
                    });

                    return ListView(
                      children: listOfVesselTiles,
                    );
                  }
                } catch (e) {
                  return Center(
                    child: Text('No registered vessels yet'),
                  );
                }
                return Center(
                  child: Text('No registered vessels yet'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ExpansionTile _createVesselTile(Map vesselDetails) {
    return ExpansionTile(
      title: Text(vesselDetails['Vessel name']),
      leading: Icon(Icons.directions_boat_filled_outlined),
      iconColor: Theme.of(context).colorScheme.onPrimary,
      textColor: Theme.of(context).colorScheme.onPrimary,
      collapsedIconColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Colors.black12,
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        Divider(
          height: 1,
          thickness: 1,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: IconButton(
                onPressed: () {
                  _handleEditVessel(vesselDetails);
                },
                icon: Icon(Icons.edit),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Text(
              'Vessel Actions',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: IconButton(
                onPressed: () {
                  _handleDeleteVessel(vesselDetails);
                },
                icon: Icon(Icons.delete_forever),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          height: 1,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Vessel details:',
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: _vesselTextInfoList(vesselDetails),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _vesselTextInfoList(Map vesselDetails) {
    List<Widget> vesselText = [];

    vesselDetails.forEach((key, value) {
      vesselText.add(Text('$key: $value'));
    });

    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: vesselText,
      ),
    );
  }

  void _handleEditVessel(Map selectedVessel) async {
    Map<String, String> textList = {
      'Company name': selectedVessel['Company name'],
      'Vessel name': selectedVessel['Vessel name'],
      'Imo number': selectedVessel['Imo number'],
      'Tech name': selectedVessel['Tech name'],
      'Tech email': selectedVessel['Tech email'],
      'Planning name': selectedVessel['Planning name'],
      'Planning email': selectedVessel['Planning email'],
    };

    _showVesselForm(textList);
    try {} catch (error) {}
  }

  void _showVesselForm(Map<String, String> previousVesselTextInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                'Edit form',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: Container(
              padding: EdgeInsets.all(0),
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: VesselForm(previousVesselTextInfo),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleDeleteVessel(Map selectedVessel) async {
    try {
      await FirestoreDatabase().deleteVessel(selectedVessel);
      await FirestoreDatabase()
          .removeVesselImages(selectedVessel['Vessel name']);
    } catch (error) {
      print(error);
    }
  }
}
