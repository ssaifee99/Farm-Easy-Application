import 'package:farmeasy/main.dart';
import 'package:farmeasy/screens/account.dart';
import 'package:farmeasy/screens/home.dart';
import 'package:farmeasy/screens/settings.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  final String contactNumber;

  LandingPage({Key key, @required this.contactNumber}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // route for home is '/' implicitly
      routes: <String, WidgetBuilder>{
        // define the routes
        SettingsScreen.routeName: (BuildContext context) => SettingsScreen(),
        AccountScreen.routeName: (BuildContext context) => AccountScreen(),
        MyApp.routeName: (BuildContext context) => MyApp(),
      },
    );
  }
}
