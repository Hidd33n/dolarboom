import 'package:flutter/material.dart';

class ResponsiveLayaout extends StatelessWidget {
final Widget mobileBody;
final Widget desktopBody;

ResponsiveLayaout({required this.mobileBody, required this.desktopBody});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints){
        if (contraints.maxWidth < 600) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}