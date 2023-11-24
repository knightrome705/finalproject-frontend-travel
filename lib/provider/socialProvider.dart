import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class socialProvider extends ChangeNotifier{
  Future getPostes()async{
    Response response=await get(Uri.parse("http://192.168.230.94/PHP/finalproject/API/view_posts_api.php"));
    if(response.statusCode==200) {
      var result = jsonDecode(response.body);
      return result;
    }
  }

  Future removePost({required post_id})async{
    var value={"post_id":post_id,"user_id":user_id};
    Response response=await  post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/removePost_api.php"),body: value);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Removed");
    }else{
      Fluttertoast.showToast(msg: "Failed");
    }
    notifyListeners();
  }
  var user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user_crenditals");
      user_id = result.toString();
      notifyListeners();
  }




}