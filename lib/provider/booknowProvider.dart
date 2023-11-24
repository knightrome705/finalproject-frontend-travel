import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class booknowProvider extends ChangeNotifier{

  String? user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user_id = sharedPreferences.getInt("user_crenditals").toString();
    notifyListeners();
  }

  Future purchaseTrip(String p_id)async{
    var data={"p_id":p_id.toString(),"user_id":user_id,"date":DateTime.now().toString()};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/order_packages_api.php"),body:data );
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Booked");
    }
    notifyListeners();
  }

}