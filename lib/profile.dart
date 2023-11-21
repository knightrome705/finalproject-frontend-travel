import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/Feedback.dart';
import 'package:travel/ipdata.dart';
import 'package:travel/login.dart';
import 'package:travel/MakePost.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User data not available"),
            backgroundColor: Colors.red,
          ),
        );
      }

  }

  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user_crenditals");
    setState(() {
      user_id = result.toString();
    });
    print("dat2 is ${user_id}");
  }

  @override
  void initState() {
    userCrenditails();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "TraVEl",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Post"),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MakePost(),));
                    },

                ),
                  PopupMenuItem(child:Text("Feedback"),
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Doubt(),));

                  },
                  ),
                PopupMenuItem(
                    child: Text("Logout"),
                  onTap: ()async{
                    SharedPreferences prefer=await SharedPreferences.getInstance();
                    prefer.remove("user_crenditals");
                    prefer.setBool("user_logged", false);
                    Fluttertoast.showToast(msg: "Exit");
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
                  },
                ),

                ];

              })
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(100),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "${IpData.ip}/${IpData.image2}/${snapshot.data["data"]["photo"]}")),
                                  color: Colors.green,
                                  shape: BoxShape.circle),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                spreadRadius: 5)
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.data["data"]["first_name"],style: GoogleFonts.vinaSans(fontSize: 25),),
                        SizedBox(
                          width: 8,
                        ),
                        Text(snapshot.data["data"]["last_name"],style: GoogleFonts.vinaSans(fontSize: 25),),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(snapshot.data["data"]["email"],style: GoogleFonts.vinaSans(fontSize: 25),),
                    SizedBox(
                      height: 30,
                    ),
                    Text(snapshot.data["data"]["password"],style: GoogleFonts.vinaSans(fontSize: 25),),
                  ],
                );
              } else {
                return Center(
                  child: Text("Something went wrong"),
                );
              }
            }),
      ),
    );
  }
}
