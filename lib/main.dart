import 'package:flutter/material.dart';
import 'package:flutter_dark_mode_demo/sharedPreferences/app_theme_shared_preferences.dart';

import 'drawer.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  int? retrieveSavedThemeModeIndex = await retrieveSavedThemeMode();
  final ThemeMode savedThemeMode = retrieveSavedThemeModeIndex == 0
      ? ThemeMode.system
      : retrieveSavedThemeModeIndex == 1
          ? ThemeMode.light
          : ThemeMode.dark;

  runApp(
    MyApp(
      savedThemeMode: savedThemeMode,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.savedThemeMode}) : super(key: key);

  final ThemeMode? savedThemeMode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Keeps track of theme
  late ThemeMode? themeMode = widget.savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      //Add themeMode as themeMode
      themeMode: themeMode,
      //Add ThemeData.dark() as darkTheme
      darkTheme: ThemeData.dark(),

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        themeMode: themeMode,
        onThemeMode: (ThemeMode value) {
          setState(() {
            themeMode = value;
            saveThemeMode(value == ThemeMode.system
                ? 0
                : value == ThemeMode.light
                    ? 1
                    : 2);
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.themeMode, this.onThemeMode})
      : super(key: key);

  final ThemeMode? themeMode; //
  final ValueChanged<ThemeMode>? onThemeMode; //

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: CustomDrawer(
        themeMode: widget.themeMode,
        onThemeMode: (ThemeMode value) {
          widget.onThemeMode?.call(value);
        },
      ),
    );
  }
}
