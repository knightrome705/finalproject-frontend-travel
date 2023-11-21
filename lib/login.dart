import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/sigin.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  bool secure = true;
  var result;
  int user_id=0;
  Future logIn() async {
    var data = {"email": email.text, "password": password.text};
    Response response = await post(
        Uri.parse(
            "http://192.168.230.94/PHP/finalproject/API/get_user_api.php"),
        body: data);
    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
      if (result["data"] == null) {
        Fluttertoast.showToast(msg: "please register");
      } else {
        var data1= result["data"]["user_id"];
        setState(() {
          user_id=int.parse(data1);
        });
        print(user_id);
        userCrenditails();
        Fluttertoast.showToast(msg: "welcome");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNav(),
        ));
      }
    }
  }

  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("user_crenditals",user_id);
    sharedPreferences.setBool('user_logged', true);
    var data = sharedPreferences.getInt("user_crenditals");
    print(data);
  }
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blue,
          body: Center(
            child: Container(
              height: 500,
              width: 350,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 280,
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                            validator: (value) {
                              final RegExp _emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                              if (value!.isEmpty) {
                                return "please enter your email";
                              } else if (!_emailRegex.hasMatch(value)) {
                                return "enter a valid email";
                              }
                            },
                            decoration: InputDecoration(
                                label: Text("Email"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 40,
                          width: 280,
                          child: TextFormField(
                            controller: password,
                            obscureText: secure,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your password";
                              }
                            },
                            decoration: InputDecoration(
                                label: Text("Password"),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        secure = !secure;
                                      });
                                    },
                                    icon: secure == false
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off)),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            bool validator = formkey.currentState!.validate();
                            if (validator == true) {
                              logIn();

                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red),
                              minimumSize: MaterialStatePropertyAll(
                                  Size(double.infinity, 50))),
                          child: Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dont have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => Siginup(),
                                  ));
                                },
                                child: Text("Signup"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
