import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Models/Packages.dart';
import 'package:travel/Provider/homeProvider.dart';
import 'package:travel/ipdata.dart';
import 'package:travel/profile.dart';
import 'package:travel/replies.dart';
import 'package:travel/Feedback.dart';
import 'package:travel/widgets/cust_drawer.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<homeProvider>(context, listen: false).userCrenditails();
    Future.delayed(Duration(seconds: 1)).whenComplete(() => Provider.of<homeProvider>(context, listen: false).getUser());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text(
          "TraVEl",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child:const Text("Feedback"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Doubt()),
                    );
                  },
                ),
                PopupMenuItem(
                  child: Text("Replies"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Replies(),
                    ));
                  },
                ),
                PopupMenuItem(
                  child:const Text("Profile"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Profile(),
                    ));
                  },
                ),
              ];
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: Provider.of<homeProvider>(context, listen: false).viewPackages(),
        builder: (context,AsyncSnapshot snapshot) {
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
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120, left: 200),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<homeProvider>(context,listen: false).showSheet(
                                    context,
                                    snapshot.data["data"][index]["p_id"],
                                    snapshot.data["data"][index]["p_name"],
                                    snapshot.data["data"][index]["p_description"],
                                    "${IpData.ip}/${IpData.image}/${snapshot.data["data"][index]["p_image1"]}",
                                    "${IpData.ip}/${IpData.image}/${snapshot.data["data"][index]["p_image2"]}",
                                  );
                                },
                                child: Text("show"),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(100, 40)),
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
