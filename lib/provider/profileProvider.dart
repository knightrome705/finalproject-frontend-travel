import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/login.dart';

class profileProvider extends ChangeNotifier{

  var data;
  String? user_id;
  Future getUser() async {
    var user = {"id": user_id};
    Response response = await post(
        Uri.parse(
            "http://192.168.230.94/PHP/finalproject/API/view_user_api.php"),
        body: user);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      Fluttertoast.showToast(msg: "Unavailable");

    }
    notifyListeners();

  }

  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user_crenditals");
      user_id = result.toString();
      notifyListeners();
  }
  void logout(BuildContext context)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('user_logged', false);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => Login(),));
    notifyListeners();
  }

}