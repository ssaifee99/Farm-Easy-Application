import 'dart:convert';

import 'package:farmeasy/landingPage.dart';
import 'package:farmeasy/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'globals.dart' as globals;

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  static const String routeName = "./";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xFF4CAF50),
                title: Text('User Login Form')),
            body: Center(child: LoginUser())));
  }

  MyApp();
}

class LoginUser extends StatefulWidget {
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State {
  // For CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final personalContactController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String personalContactNumber = personalContactController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    var url = 'https://farmeazy.000webhostapp.com/login_user.php';

    // Store all data with Param Name.
    var data = {
      'personal_contact_number': personalContactNumber,
      'password': password
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    print(message);
//    print(message['id']);
//    print(message['module_id']);

    // If the Response Message is Matched.
    if (message != "Invalid contact_number or Password Please Try Again") {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      globals.temperature = message["temperature"].toString();
      globals.humidity = message["humidity"].toString();
      globals.moisture = message["moisture"].toString();

      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LandingPage(contactNumber: personalContactController.text)));
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      print('Debugggggg1');
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final createNewAccount = GestureDetector(
      child: Text('Create New Account',
          style: TextStyle(
              decoration: TextDecoration.underline, color: Colors.blue)),
      onTap: () {
        Navigator.push(context, PageThree("enter value"));
      },
    );

    return Scaffold(
        //backgroundColor: Color(0xFF9E9E9E),
//        backgroundColor: Color(0xFF4CAF50),
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage("images/bg5.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
          child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
//            SizedBox(
//              height: 155.0,
//              child: Image.asset(
//                "images/shweta.png",
//                fit: BoxFit.contain,
//              ),
//            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('User Login Form',
                    style: TextStyle(
                      fontSize: 40,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.brown[700],
                    ))),
            Divider(),
            SizedBox(height: 40),
            Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: personalContactController,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: 'Enter Your Contact Number Here',
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: Colors.black87),
                      labelStyle:
                          new TextStyle(color: const Color(0xFF000000))),
                )),
            Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: passwordController,
                  autocorrect: true,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter Your Password Here',
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: Colors.black87),
                      labelStyle:
                          new TextStyle(color: const Color(0xFF000000))),
                )),

            RaisedButton(
              onPressed: userLogin,
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
              child: Text('Click Here To Login'),
            ),
            SizedBox(
              height: 10.0,
            ),
            createNewAccount,
            Visibility(
                visible: visible,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator())),
          ],
        ),
      )),
    ));
  }
}

class ProfileScreen extends StatelessWidget {
// Creating String Var to Hold sent Email.
  final String email;

// Receiving Email using Constructor.
  ProfileScreen({Key key, @required this.email}) : super(key: key);

// User Logout Function.
  logout(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Profile Screen'),
                automaticallyImplyLeading: false),
            body: Center(
                child: Column(
              children: <Widget>[
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: Text('Email = ' + '\n' + email,
                        style: TextStyle(fontSize: 20))),
                RaisedButton(
                  onPressed: () {
                    logout(context);
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Click Here To Logout'),
                ),
              ],
            ))));
  }
}
