import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/theme/themenotification.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // Altura predeterminada del AppBar

  void _toggleTheme(BuildContext context) {
    final themeNotifier =
        Provider.of<ThemeModeNotifier>(context, listen: false);
    themeNotifier.setThemeMode(
      Theme.of(context).brightness == Brightness.dark
          ? ThemeMode.light
          : ThemeMode.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade300,
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.brightness_6),
          onPressed: () => _toggleTheme(context),
        ),
      ],
    );
  }
}
