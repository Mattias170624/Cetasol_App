// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/Widgets/NavScreenWidgets/VesselPage/add_vessel_container.dart';
import 'package:cetasol_app/Widgets/NavScreenWidgets/VesselPage/registered_vessels.dart';
import 'package:flutter/material.dart';

class VesselScreen extends StatelessWidget {
  const VesselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50)),
            AddVesselContainer(),
            Expanded(
              child: RegisteredVessels(),
            ),
          ],
        ),
      ),
    );
  }
}
