// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/Models/registered_vessel_model.dart';
import 'package:flutter/material.dart';

class RegisteredVessels extends StatefulWidget {
  @override
  State<RegisteredVessels> createState() => _RegisteredVesselsState();
}

// Item generator for the vessel list
List<RegisteredVesselItem> _generateItems(int numberOfItems) {
  return List<RegisteredVesselItem>.generate(
    numberOfItems,
    (int index) {
      return RegisteredVesselItem(
        headerValue: 'Vessel $index',
        expandedValue: 'This is item number $index',
      );
    },
  );
}

class _RegisteredVesselsState extends State<RegisteredVessels> {
  final List<RegisteredVesselItem> _data = _generateItems(3);
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: SingleChildScrollView(
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
              margin: EdgeInsets.only(bottom: 20, top: 5),
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SingleChildScrollView(
              child: _buildPanel(),
            )
          ],
        ),
      ),
    );
  }

  // Expansion panel list
  Widget _buildPanel() {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.all(0),
      dividerColor: Colors.grey,
      elevation: 2,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          for (var element in _data) {
            element.isExpanded = false;
          }
          _data[_selectedItemIndex].isExpanded = false;
          _data[index].isExpanded = !isExpanded;
          _selectedItemIndex = index;
        });
      },
      children: _data.map<ExpansionPanel>(
        (RegisteredVesselItem item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                leading: Icon(Icons.directions_boat_filled),
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.only(left: 10),
                title: Text(
                  item.headerValue!,
                  style: TextStyle(fontSize: 15),
                ),
              );
            },
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, bottom: 8, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Vessel info 1'),
                  Text('Vessel info 2'),
                  Text('Vessel info 3'),
                ],
              ),
            ),
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            isExpanded: item.isExpanded,
          );
        },
      ).toList(),
    );
  }
}
