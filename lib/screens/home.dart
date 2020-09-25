import 'package:farmeasy/globals.dart' as globals;
import 'package:farmeasy/main.dart';
import 'package:farmeasy/screens/settings.dart';
import 'package:flutter/material.dart';

import 'account.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({Key key, @required this.email}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var temperature = globals.temperature;
  var humidity = globals.humidity;
  var moisture = globals.moisture;

  Drawer getNavDrawer(BuildContext context) {
    var headerChild = DrawerHeader(child: Text("Header"));
    var aboutChild = AboutListTile(
        child: Text("About"),
        applicationName: "Application Name",
        applicationVersion: "v1.0.0",
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.info));

    ListTile getNavItem(var icon, String s, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    var myNavChildren = [
      headerChild,
      getNavItem(Icons.settings, "Settings", SettingsScreen.routeName),
      getNavItem(Icons.home, "Home", "/"),
      getNavItem(Icons.account_box, "Account", AccountScreen.routeName),
      aboutChild,
      getNavItem(Icons.power_settings_new, "Logout", MyApp.routeName)
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4CAF50),
        title: Text("Your Current Readings"),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: ExactAssetImage("images/bg5.png"),
          )),
//        color: Color(0xFF263238),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                ButtonTheme(
                  minWidth: 50.0,
                  height: 150.0,
                  buttonColor: Color(0xFFD50000),
                  child: RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFFD50000),
                            Color(0xFFD50000),
                            Color(0xFFD50000),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Temperature: " + temperature + "C",
                          style: TextStyle(fontSize: 40)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ButtonTheme(
                  minWidth: 50.0,
                  height: 150.0,
                  buttonColor: Color(0xffffd600),
                  child: RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xffffd600),
                            Color(0xffffd600),
                            Color(0xffffd600),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Humidity       : ' + humidity + "%",
                          style: TextStyle(fontSize: 40)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ButtonTheme(
                  minWidth: 50.0,
                  height: 150.0,
                  buttonColor: Color(0xFF1976D2),
                  child: RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF1976D2),
                            Color(0xFF1976D2),
                            Color(0xFF1976D2),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Moisture       : ' + moisture + "%",
                          style: TextStyle(fontSize: 40)),
                    ),
                  ),
                ),
              ],
            ),
          )),
      // Set the nav drawer
      drawer: getNavDrawer(context),
    );
  }
}
