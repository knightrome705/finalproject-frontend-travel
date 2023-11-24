import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class replyProvider extends ChangeNotifier{
  Future repliesfromAdmin()async{
    var data={"user_id":user_id};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/view_reply_query_admin_api.php"),body: data);
    var data1;
    if(response.statusCode==200){
      data1=jsonDecode(response.body);
    }
    return data1;
  }
  Future removeReply({required id})async{
    var data={"id":id};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/remove_query_api.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "cleared");
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