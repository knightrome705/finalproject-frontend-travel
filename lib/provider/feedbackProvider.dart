import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class feedbackProvider extends ChangeNotifier{
  Future feedBack({required feedback,required user_id})async{
    var data={"user_id":user_id,"feedback":feedback,"initial_date":DateTime.now().toString()};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/add_feedback_api.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Thanks for your response");
    }
    notifyListeners();
  }
  String? user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user_crenditals");
      user_id = result.toString();
      notifyListeners();
  }



}