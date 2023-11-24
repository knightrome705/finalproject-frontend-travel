import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class enquiryProvider extends ChangeNotifier{
  Future enquiryPackage({required enquiry,required user_id})async{
    var data={"user_id":user_id,"query":enquiry,"date":DateTime.now().toString()};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/add_query_api.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Replied as soon as possible");
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