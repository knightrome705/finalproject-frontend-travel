import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/BottomNavigator.dart';

class loginProvider with ChangeNotifier {
  int user_id = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool secure = true;
  GlobalKey<FormState> formkey = GlobalKey();
  Future logIn({required email,required password,required BuildContext context}) async {
    var data = {"email": email, "password": password};
    Response response = await post(
      Uri.parse("http://192.168.1.72/PHP/finalproject/API/get_user_api.php"),
      body: data,
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result["data"] == null) {
        Fluttertoast.showToast(msg: "Please register");
      } else {
        user_id = int.parse(result["data"]["user_id"]);
        userCrenditails();
        Fluttertoast.showToast(msg: "Welcome");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav(),));
      }
    }
    notifyListeners();
  }

  Future<void> userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("user_crenditals", user_id);
    sharedPreferences.setBool('user_logged', true);
    notifyListeners();
  }

  void security(){
    secure = !secure;
    notifyListeners();
  }
}
