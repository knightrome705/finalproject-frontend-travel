

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/socialProvider.dart';
import 'package:travel/ipdata.dart';

class Social extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<socialProvider>(context, listen: false).userCrenditails();

    return Scaffold(
      appBar: AppBar(
        title:const Text("TraVEl"),
      ),
      body: FutureBuilder(
        future: Provider.of<socialProvider>(context, listen: false).getPostes(),
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data["data"].length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${IpData.ip}/${IpData.image2}/${snapshot.data["data"][index]["photo"]}"),
                        ),
                        title: Text(snapshot.data["data"][index]["first_name"]),
                        subtitle: Text(snapshot.data["data"][index]["email"]),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:const Text("Are you sure?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Provider.of<socialProvider>(context, listen: false)
                                            .removePost(post_id: snapshot.data["data"][index]["post_id"]);
                                        Fluttertoast.showToast(msg: "Removed");
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Remove"),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.remove_circle),
                        ),
                      ),
                      Container(
                        height: 500,
                        width: 500,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "${IpData.ip}/${IpData.image2}/${snapshot.data["data"][index]["memories"]}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                         const Icon(Icons.heart_broken_sharp, size: 35),
                         const SizedBox(width: 35),
                         const Icon(Icons.chat, size: 35),
                         const  SizedBox(width: 20),
                        const  Icon(Icons.share, size: 40),
                        ],
                      ),
                      Row(
                        children: [
                        const  SizedBox(
                            width: 20,
                          ),
                          Text(
                            snapshot.data["data"][index]["title"],
                            style: TextStyle(fontSize: 20)
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Text(
                            snapshot.data["data"][index]["description"],
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
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
