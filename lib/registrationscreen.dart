import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import 'loginscreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController1 = new TextEditingController();
  TextEditingController _passwordController2 = new TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.teal[50],
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(60, 20, 60, 20),
                  child: Image.asset("assets/images/ElectricalVendor.png")),
              SizedBox(height: 5),
              Card(
                margin: EdgeInsets.all(20),
                color: Colors.red[50],
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    children: [
                      Text(
                        'Registration',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email', icon: Icon(Icons.email, color: Colors.black54,)),
                      ),
                      TextField(
                        controller: _passwordController1,
                        decoration: InputDecoration(
                            labelText: 'Password', 
                            icon: Icon(Icons.lock, color: Colors.black54,),
                            suffix: InkWell(
                              onTap: _togglePass,
                              child: Icon(Icons.visibility),
                            ),
                            ),
                            obscureText: _obscureText,
                      ),
                      TextField(
                        controller: _passwordController2,
                        decoration: InputDecoration(
                            labelText: 'Enter Password Again',
                            icon: Icon(Icons.lock, color: Colors.black54,),
                            suffix: InkWell(
                              onTap: _togglePass,
                              child: Icon(Icons.visibility),
                              ),
                        ),
                        obscureText: _obscureText,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                              value: _rememberMe,
                              onChanged: (bool value) {
                                _onChange(value);
                              }),
                          Text("Remember Me")
                        ],
                      ),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minWidth: 200,
                          height: 50,
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: _onRegister,
                          color: Colors.black54),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child:
                    Text("Already Register", style: TextStyle(fontSize: 16)),
                onTap: _alreadyRegister,
              ),
              SizedBox(height: 5),
            ],
          ),
        )),
      ),
    );
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  void _alreadyRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => LoginScreen()));
  }

  void _onRegister() {
    String _email = _emailController.text.toString();
    String _password1 = _passwordController1.text.toString();
    String _password2 = _passwordController2.text.toString();

    if (_email.isEmpty || _password1.isEmpty || _password2.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email/Password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (_password1 != _password2) {
      Fluttertoast.showToast(
        msg: "Register Failed",
        toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
          return;
    }
    //checking the data integrity

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Register new user"),
            content: Text("Are you sure?"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _registerUser(_email, _password1);
                },
              ),
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _registerUser(String email, String password) {
    http.post(
        Uri.parse(
            "https://javathree99.com/s270088/electricalvendor/php/register_user.php"),
        body: {
          "email": email,
          "password": password,
        }).then((response) {
      print(response.body);
      if(response.body == "success"){
        Fluttertoast.showToast(
          msg: "Registration Success. Please check your email for verification link.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      }else{
        Fluttertoast.showToast(
          msg: "Registration Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      }
    });
  }

  void _togglePass(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
