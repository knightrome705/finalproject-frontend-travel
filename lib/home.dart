import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/Booknow.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/Orders.dart';
import 'package:travel/login.dart';
import 'package:travel/profile.dart';
import 'package:travel/replies.dart';
import 'package:travel/social.dart';
import 'ipdata.dart';
import 'package:travel/Feedback.dart';

class Homepage extends StatefulWidget {
  @override
  HomepageState createState() {
    return HomepageState();
  }
}

class HomepageState extends State<Homepage> {
  var result;
  bool isSingleTrip = true;
  Future viewPackages() async {
    Response response = await get(Uri.parse(
        "http://192.168.230.94/PHP/finalproject/API/view_packages_api.php"));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result;
    }
  }

  void showSheet(String p_id, String pkgName,String pkgDescription, String pkgImg, String pkgSecImg) {
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
                options: CarouselOptions(height:250,autoPlay: true,autoPlayInterval: Duration(seconds:1)),
                items: [pkgImg, pkgSecImg].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: NetworkImage("$i"))),
                      );
                    },
                  );
                }).toList(),
              ),

            SizedBox(
              height: 80,
            ),
              ElevatedButton(onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>Conform(p_id: p_id,p_image: pkgImg,description:pkgDescription,p_name:pkgName)));
              },
                  style: ButtonStyle(
                    backgroundColor:MaterialStatePropertyAll(Colors.red),
                    minimumSize: MaterialStatePropertyAll(
                      Size(double.infinity,50)
                    )
                  ),
                  child: Text("Join now"))
            ],
          ),
        );
      },
    );
  }
  var user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user_crenditals");
    setState(() {
      user_id = result.toString();
    });
    print("dat2 is ${user_id}");
  }
  var image;
  Future getUser() async {
    var user = {"id": user_id};
    Response response = await post(
        Uri.parse(
            "http://192.168.230.94/PHP/finalproject/API/view_user_api.php"),
        body: user);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        image=data["data"]["photo"];
      });
    }
  }

  @override
  void initState() {
    userCrenditails();
    Future.delayed(Duration(seconds: 1)).whenComplete(() => getUser());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "TraVEl",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        actions: [
          PopupMenuButton(icon:Icon(Icons.more_vert),
              itemBuilder:(context){
            return [
              PopupMenuItem(child: Text("Feedback"),
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Doubt(),));

              },
              ),
              PopupMenuItem(child: Text("Replies"),
                onTap: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Replies()));

                }

                ,),
              PopupMenuItem(child: Text("Profile"),
                onTap: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile()));

                }

                ,)
              
            ];
            
            
    })
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Container(
              height: 100,
              width: 100,
              decoration:
                  BoxDecoration( shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${IpData.ip}/${IpData.image2}/${image}")
                  )),
            )),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BottomNav(),
                  ));
                },
                title: Text("Home"),
                leading: Icon(Icons.home),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Social(),
                  ));
                },
                title: Text("Posts"),
                leading: Icon(Icons.group),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Homepage(),
                  ));
                },
                title: Text("Packages"),
                leading: Icon(Icons.wallet_travel),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Profile(),
                  ));
                },
                title: Text("Profile"),
                leading: Icon(Icons.account_circle),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Orders(),
                  ));
                },
                title: Text("Orders"),
                leading: Icon(Icons.table_rows_sharp),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                onTap: ()async {
                  SharedPreferences prefer=await SharedPreferences.getInstance();
                  prefer.setBool("user_logged", false);
                  prefer.remove("user_crenditals");
                  Fluttertoast.showToast(msg: "Exit");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Login(),
                  ));
                },
                title: Text("Logout"),
                leading: Icon(Icons.logout),
              ),
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: viewPackages(),
        builder: (context, snapshot) {
          // if(snapshot.connectionState==ConnectionState.waiting){
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!["data"].length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        child: Container(
                          height: 200,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 120, left: 200),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    showSheet(
                                        snapshot.data["data"][index]["p_id"],
                                        snapshot.data["data"][index]["p_name"],
                                      snapshot.data["data"][index]["p_description"],
                                        "${IpData.ip}/${IpData.image}/${snapshot.data["data"][index]["p_image1"]}",
                                        "${IpData.ip}/${IpData.image}/${snapshot.data["data"][index]["p_image2"]}",
                                        );
                                  },
                                  child: Text("show"),
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStatePropertyAll(Size(100, 40)),
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue),
                                  ),
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                "${IpData.ip}/${IpData.image}/${snapshot.data["data"][index]["p_image"]}",
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                spreadRadius: 2,
                              )
                            ],
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    ],
                  );
                });
          } else {
            return Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
