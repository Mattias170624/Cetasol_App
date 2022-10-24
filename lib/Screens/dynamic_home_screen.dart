// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/NavScreenWidgets/SettingsPage/settings_screen.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:cetasol_app/Screens/trouble_shoot_screen.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:cetasol_app/Screens/vessel_screen.dart';
import 'package:cetasol_app/Screens/media_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _pageIndex = 1;

  void _setCurrentPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: SettingsScreen(),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Icon(Icons.settings),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          _choosePageTitle(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      bottomNavigationBar: BottomBarInspiredInside(
        backgroundColor: Theme.of(context).colorScheme.primary,
        color: Theme.of(context).colorScheme.error,
        colorSelected: Theme.of(context).colorScheme.onSurface,
        duration: Duration(milliseconds: 200),
        itemStyle: ItemStyle.circle,
        indexSelected: _pageIndex,
        padbottom: Platform.isAndroid ? 10 : 0,
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
      body: _chooseWhatPage(),
    );
  }

  String _choosePageTitle() {
    switch (_pageIndex) {
      case 0:
        return 'Media';
      case 1:
        return 'Vessel';
      case 2:
        return 'Troubleshoot';
      default:
        return 'Error';
    }
  }

  Widget _chooseWhatPage() {
    switch (_pageIndex) {
      case 0:
        return MediaScreen();
      case 1:
        return VesselScreen();
      case 2:
        return TroubleshootScreen();
      default:
        return Center(
          child: Text('Error'),
        );
    }
  }
}

const List<TabItem> items = [
  TabItem(
    icon: Icons.newspaper_rounded,
    title: 'Media',
  ),
  TabItem(
    icon: Icons.directions_boat_filled_rounded,
    title: 'Vessel',
  ),
  TabItem(
    icon: Icons.troubleshoot_rounded,
    title: 'Troubleshoot',
  ),
];
