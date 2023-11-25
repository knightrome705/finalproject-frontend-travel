import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel/Feedback.dart';
import 'package:travel/Provider/profileProvider.dart';
import 'package:travel/ipdata.dart';
import 'package:travel/MakePost.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<profileProvider>(context, listen: false).userCrenditails();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const Text(
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MakePost()));
                  },
                ),
                PopupMenuItem(
                  child:const Text("Feedback"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Doubt()));
                  },
                ),
                PopupMenuItem(
                  child:const Text("Logout"),
                  onTap: ()  {
                     Provider.of<profileProvider>(context, listen: false).logout(context);
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: Provider.of<profileProvider>(context).getUser(),
          builder: (context,AsyncSnapshot snapshot) {
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
                              border: Border.all(
                                color: Colors.yellow,
                                width: 10
                              ),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage("${IpData.ip}/${IpData.image2}/${snapshot.data!["data"]["photo"]}"),
                              ),
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                       const BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          spreadRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft:const Radius.circular(50),
                        bottomRight:const Radius.circular(50),
                      ),
                    ),
                  ),
                 const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!["data"]["first_name"],
                        style: GoogleFonts.vinaSans(fontSize: 25),
                      ),
                     const SizedBox(
                        width: 8,
                      ),
                      Text(
                        snapshot.data!["data"]["last_name"],
                        style: GoogleFonts.vinaSans(fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    snapshot.data!["data"]["email"],
                    style: GoogleFonts.vinaSans(fontSize: 25),
                  ),

                ],
              );
            } else {
              return Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}
