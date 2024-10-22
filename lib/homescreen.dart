import 'package:dolarboom/responsive/android/screens/homescreen/mobile_body.dart';
import 'package:dolarboom/responsive/responsive_layaout.dart';
import 'package:dolarboom/responsive/web/screens/homescreen/desktop_body.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayaout(
      mobileBody: MyMobileBody(),
      desktopBody: MyDesktopBody()),
    );
  }
}