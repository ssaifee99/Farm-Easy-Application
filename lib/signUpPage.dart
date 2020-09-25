import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageThree extends MaterialPageRoute<Null> {
  final String content;
  final int group = 1;

  PageThree(this.content)
      : super(builder: (BuildContext context) {
          TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

          return Scaffold(
            appBar: AppBar(
              title: Text('Create new account'),
              backgroundColor: Color(0xFF4CAF50),
            ),
            body: RegisterUser(),
          );
        });
}

class RegisterUser extends StatefulWidget {
  RegisterUserState createState() => RegisterUserState();
}

class RegisterUserState extends State<RegisterUser> {
  bool validateName(String name) {
    if (name == null) {
      return true;
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();

  // Boolean variable for CircularProgressIndicator.
  bool isVisibleName = false;
  bool isVisibleContactNumber = false;
  bool isVisibleGSMNumber = false;
  bool isVisibleAddress = false;
  bool isVisiblePassword = false;
  bool isVisibleReEnterPassword = false;
  bool visible = false;

  bool validateFields() {
    isVisibleName = false;
    isVisibleContactNumber = false;
    isVisibleGSMNumber = false;
    isVisiblePassword = false;
    isVisibleAddress = false;
    isVisibleReEnterPassword = false;
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (nameController.text.length == 0) isVisibleName = true;

    if (!regExp.hasMatch(personalContactNumberController.text))
      isVisibleContactNumber = true;

    if (!regExp.hasMatch(gsmContactNumberController.text))
      isVisibleGSMNumber = true;

    if (addressController.text.length == 0) isVisibleAddress = true;

    if (passwordController.text.length == 0) isVisiblePassword = true;

    if (passwordController.text != reEnterPasswordController.text)
      isVisibleReEnterPassword = true;

    return (isVisibleName ||
        isVisibleContactNumber ||
        isVisibleGSMNumber ||
        isVisibleAddress ||
        isVisiblePassword ||
        isVisibleReEnterPassword);
  }

  bool _validate = false;

  // Getting value from TextField widget.
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final personalContactNumberController = TextEditingController();
  final gsmContactNumberController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });
    print("Hello Moto!!");

    print(nameController.text);
    print(isVisibleName);
    // Getting value from Controller
    String name = nameController.text;
    String gender = genderController.text;
    String personalContactNumber = personalContactNumberController.text;
    String gsmContactNumber = gsmContactNumberController.text;
    String address = addressController.text;
    String password = passwordController.text;
    String reEnteredPassword = reEnterPasswordController.text;

    if (!validateFields()) {
      print(isVisibleName);
      // SERVER API URL
      var url = 'https://farmeazy.000webhostapp.com/register_users.php';

      // Store all data with Param Name.
      var data = {
        'full_name': name,
        'gender': gender,
        'personal_contact_number': personalContactNumber,
        'gsm_contact_number': gsmContactNumber,
        'address': address,
        'password': password
      };

      print('before API call');
      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));
      print('after API call');
      print(response.toString());
      print(response.body.toString());
      print('after response.body.toString()');
      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        setState(() {
          visible = false;
        });
      }

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
                  nameController.clear();
                  genderController.clear();
                  personalContactNumberController.clear();
                  gsmContactNumberController.clear();
                  addressController.clear();
                  passwordController.clear();
                  reEnterPasswordController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        visible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Scaffold(
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 32.0),
                  child: Center(
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              //Full Name
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    child: Text(
                                      "Name",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      color: Colors.blue[50],
                                      child: TextFormField(
                                        controller: nameController,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          hintText: "enter full name",
                                          fillColor: Colors.blue[50],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Visibility(
                                visible: isVisibleName,
                                child: Text(
                                  "Name can't be empty!!",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.red[800],
                                  ),
                                ),
                              ),
                              //Gender
                              GenderRow(),

                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    child: Text(
                                      "Contact Number",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      color: Colors.blue[50],
                                      child: TextField(
                                        controller:
                                            personalContactNumberController,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          hintText:
                                              "enter personal contact number",
                                          fillColor: Colors.blue[50],
                                          errorText: _validate
                                              ? 'Value Can\'t Be Empty'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 5.0,
                              ),
                              Visibility(
                                  visible: isVisibleContactNumber,
                                  child: Text(
                                    "Invalid contact number!!",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.red[800],
                                    ),
                                  )),

                              //GSM Contact Number
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    child: Text(
                                      "GSM Contact Number",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      color: Colors.blue[50],
                                      child: TextField(
                                        controller: gsmContactNumberController,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          hintText: "enter GSM contact number",
                                          fillColor: Colors.blue[50],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Visibility(
                                visible: isVisibleGSMNumber,
                                child: Text(
                                  "Invalid GSM number!!",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.red[800],
                                  ),
                                ),
                              ),
                              //Address
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    child: Text(
                                      "Address",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      color: Colors.blue[50],
                                      child: TextField(
                                        controller: addressController,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          hintText: "enter permanent address",
                                          fillColor: Colors.blue[50],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Visibility(
                                visible: isVisibleAddress,
                                child: Text(
                                  "Address can't be empty!!",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.red[800],
                                  ),
                                ),
                              ),
                              //Password
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    child: Text(
                                      "Password",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      color: Colors.blue[50],
                                      child: TextField(
                                        controller: passwordController,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          hintText: "enter password",
                                          fillColor: Colors.blue[50],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Visibility(
                                visible: isVisiblePassword,
                                child: Text(
                                  "Password can't be empty!!",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.red[800],
                                  ),
                                ),
                              ),
                              //Reenter Password
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    child: Text(
                                      "Re-enter Password",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),

                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      color: Colors.blue[50],
                                      child: TextField(
                                        controller: reEnterPasswordController,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue[50],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          hintText: "re enter password",
                                          fillColor: Colors.blue[50],
                                        ),
                                      ),
                                    ),
                                  ),

                                  //Sign up button
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Visibility(
                                visible: isVisibleReEnterPassword,
                                child: Text(
                                  "Passwords do not match!!",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.red[800],
                                  ),
                                ),
                              ),
                              RaisedButton(
                                onPressed: userRegistration,
                                color: Colors.green,
                                textColor: Colors.black,
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text('sign up'),
                              ),

                              Visibility(
                                visible: visible,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class GenderRow extends StatefulWidget {
  @override
  _GenderRowState createState() => _GenderRowState();
}

class _GenderRowState extends State<GenderRow> {
  int group = 1;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        width: 80.0,
        child: Text(
          "Gender",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      SizedBox(
        width: 40.0,
      ),
      Text("Male"),
      Radio(
        value: 1,
        groupValue: group,
        onChanged: (T) {
          print(T);

          setState(() {
            group = T;
          });
        },
      ),
      SizedBox(
        width: 15.0,
      ),
      Text("Female"),
      Radio(
        value: 2,
        groupValue: group,
        onChanged: (T) {
          print(T);

          //T is the selected option
          setState(() {
            group = T;
          });
        },
      ),
    ]);
  }
}
