import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
    required this.themeMode,
    required this.onThemeMode,
  }) : super(key: key);
  final ThemeMode? themeMode;
  final ValueChanged<ThemeMode>? onThemeMode;

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? themeButtonText;
  themeButtonTextCalc() async {
    if (widget.themeMode == ThemeMode.light) {
      setState(() {
        themeButtonText = "Light";
      });
    } else if (widget.themeMode == ThemeMode.dark) {
      setState(() {
        themeButtonText = "Dark";
      });
    } else if (widget.themeMode == ThemeMode.system) {
      setState(() {
        themeButtonText = "System";
      });
    }
  }

  @override
  void didUpdateWidget(CustomDrawer oldWidget) {
    if (oldWidget.themeMode != widget.themeMode) {
      themeButtonTextCalc();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    themeButtonTextCalc(); // calling here as buttonTextCalc need context for localization of app
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("themeButtonText $themeButtonText");
    debugPrint(
        "brightness.name: ${WidgetsBinding.instance!.window.platformBrightness}");
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ElevatedButton(
                    onPressed: () {
                      // toggling the theme mode in this sequence system -> light -> dark
                      if (widget.themeMode == ThemeMode.light) {
                        widget.onThemeMode?.call(ThemeMode.dark);
                      } else if (widget.themeMode == ThemeMode.dark) {
                        widget.onThemeMode?.call(ThemeMode.system);
                      } else if (widget.themeMode == ThemeMode.system) {
                        widget.onThemeMode?.call(ThemeMode.light);
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Theme Mode - $themeButtonText',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
