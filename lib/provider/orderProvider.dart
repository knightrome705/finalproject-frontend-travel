import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class orderProvider extends ChangeNotifier{
  Future orderList()async{
    var data={"user_id":user_id.toString()};
    Response response =await post(Uri.parse("http://192.168.1.72/PHP/finalproject/API/view_orders_api.php"),body:data );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return data;
    }
  }
  var remove;
  Future removeOrder({required o_id})async{
    var data={"o_id":o_id};
    Response response=await  post(Uri.parse("http://192.168.1.72/PHP/finalproject/API/remove_package_orders_api.php"),body: data);
    if(response.statusCode==200){
      remove=jsonDecode(response.body);
      Fluttertoast.showToast(msg: "Removed");
      notifyListeners();
    }
  }
  String? user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user_crenditals");
      user_id = result.toString();
    notifyListeners();
  }




}