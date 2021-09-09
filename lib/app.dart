import 'package:authentification/connectivity_provider.dart';
import 'package:authentification/screens/main_screen.dart';
import 'package:authentification/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: MainScreen(),
        )
      ],
      child: MaterialApp(
        title: 'Home',
        home: Container(
          child: Welcome(),
        ),
      ),
    );
  }
}
