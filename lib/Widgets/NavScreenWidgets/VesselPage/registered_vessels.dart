// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisteredVessels extends StatefulWidget {
  @override
  State<RegisteredVessels> createState() => _RegisteredVesselsState();
}

class _RegisteredVesselsState extends State<RegisteredVessels> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService().auth.currentUser!.uid)
      .collection('Registered vessels list')
      .snapshots();

  @override
  void dispose() {
    super.dispose();
  }

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
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    color: Colors.red,
                    child: const Text('Something went wrong'),
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

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: snapshot.data?.docs == null ||
                          snapshot.data!.docs.isEmpty
                      ? Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
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
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 20, top: 5),
                                height: 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                'No registered vessels yet',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                                Map vesselInfoMap = document.data()! as Map;
                                return Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      _listTileBuilder(vesselInfoMap),
                                    ],
                                  ),
                                );
                              })
                              .toList()
                              .cast(),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTileBuilder(Map vesselDetails) {
    List<Widget> displayItems() {
      List<Widget> list = [];

      try {
        vesselDetails.forEach(
          (key, value) {
            list.add(
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 20, bottom: 5),
                child: Text('$key : $value'),
              ),
            );
          },
        );
      } catch (error) {
        list.clear();
        list.add(
          Center(
            child: Text('No vessels found'),
          ),
        );
        print(error);
      }
      return list;
    }

    return Container(
      color: Color.fromARGB(255, 238, 238, 238),
      child: ExpansionTile(
        leading: Padding(
          padding: EdgeInsets.all(0),
          child: Icon(Icons.directions_boat_filled_outlined),
        ),
        iconColor: Theme.of(context).colorScheme.onPrimary,
        collapsedIconColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(vesselDetails['Vessel name']),
        children: displayItems(),
      ),
    );
  }
}
