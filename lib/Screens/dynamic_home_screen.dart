// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/NavScreenWidgets/MediaPage/media_screen.dart';
import 'package:cetasol_app/Widgets/NavScreenWidgets/SettingsPage/settings_screen.dart';
import 'package:cetasol_app/Widgets/NavScreenWidgets/TroublshootPage/trouble_shoot_screen.dart';
import 'package:cetasol_app/Widgets/NavScreenWidgets/VesselPage/vessel_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  void _setCurrentPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 14, 38, 61),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      bottomNavigationBar: Container(
        child: BottomBarInspiredInside(
          backgroundColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.error,
          colorSelected: Theme.of(context).colorScheme.onSurface,
          duration: Duration(milliseconds: 200),
          itemStyle: ItemStyle.circle,
          indexSelected: _pageIndex,
          padbottom: 10,
          padTop: 10,
          iconSize: 25,
          items: items,
          onTap: (int newPageIndex) => _setCurrentPage(newPageIndex),
          chipStyle: ChipStyle(
            convexBridge: true,
            background: Theme.of(context).colorScheme.onPrimary,
            size: 0,
          ),
        ),
      ),
      body: _chooseWhatPage(),
    );
  }

  Widget _chooseWhatPage() {
    switch (_pageIndex) {
      case 0:
        return VesselScreen();
      case 1:
        return TroubleshootScreen();
      case 2:
        return MediaScreen();
      case 3:
        return SettingsScreen();
      default:
        return Center(
          child: Text('Error'),
        );
    }
  }
}

const List<TabItem> items = [
  TabItem(
    icon: Icons.directions_boat_filled_rounded,
    title: 'Vessel',
  ),
  TabItem(
    icon: Icons.troubleshoot_rounded,
    title: 'Troubleshoot',
  ),
  TabItem(
    icon: Icons.newspaper_rounded,
    title: 'Media',
  ),
  TabItem(
    icon: Icons.settings,
    title: 'Settings',
  ),
];
