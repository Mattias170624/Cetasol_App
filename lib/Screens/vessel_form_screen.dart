// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/Widgets/NavScreenWidgets/VesselPage/vessel_form.dart';
import 'package:flutter/material.dart';

class VesselFormScreen extends StatefulWidget {
  const VesselFormScreen({super.key});

  @override
  State<VesselFormScreen> createState() => _VesselFormScreenState();
}

class _VesselFormScreenState extends State<VesselFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Vessel form',
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
              child: VesselForm(const {}),
            ),
          ],
        ),
      ),
    );
  }
}
