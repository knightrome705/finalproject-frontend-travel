import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/Booknow.dart';
import 'package:travel/Models/Packages.dart';

class homeProvider extends ChangeNotifier {
  var result;
  bool isSingleTrip = true;
  Future<Packages> viewPackages() async {
    Response response = await get(Uri.parse(
        "http://192.168.1.72/PHP/finalproject/API/view_packages_api.php"));
    var result;
    if (response.statusCode == 200) {
      // final packages = packagesFromJson(response.body);
        result = Packages.fromJson(jsonDecode(response.body));


    }
    return Packages.fromJson(jsonDecode(response.body));
  }

  void showSheet(BuildContext context,String p_id, String pkgName,String pkgDescription, String pkgImg, String pkgSecImg,height,width) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pkgName,style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
              CarouselSlider(
                options: CarouselOptions(height:height*0.25,autoPlay: true,autoPlayInterval: Duration(seconds:1)),
                items: [pkgImg, pkgSecImg].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            // color: Colors.amber,
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage("$i"))),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: height*0.02,
              ),


              Text("The travel application's intuitive itinerary feature helps users effortlessly plan their trips, ensuring a seamless and organized travel experience."),
              SizedBox(
                height: height*0.04,
              ),
              ElevatedButton(onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>Conform(p_id: p_id,p_image: pkgImg,description:pkgDescription,p_name:pkgName)));
              },
                  style: ButtonStyle(
                      backgroundColor:MaterialStatePropertyAll(Colors.red),
                      minimumSize: MaterialStatePropertyAll(
                          Size(width,height*0.05)
                      )
                  ),
                  child: Text("Join now",style: TextStyle(color: Colors.white),))
            ],
          ),
        );
      },
    );
    notifyListeners();
  }
  int? user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? result = await sharedPreferences.getInt("user_crenditals");
      user_id = result;
      notifyListeners();
  }
  var image;
  Future getUser() async {
    var user = {"id": user_id.toString()};
    Response response = await post(
        Uri.parse(
            "http://192.168.230.94/PHP/finalproject/API/view_user_api.php"),
        body: user);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
        image=data["data"]["photo"];
    }
    notifyListeners();
  }
  void loginUser()async{
    SharedPreferences prefer=await SharedPreferences.getInstance();
    prefer.setBool("user_logged", false);
    prefer.remove("user_crenditals");
    Fluttertoast.showToast(msg: "Exit");
    notifyListeners();
  }
}