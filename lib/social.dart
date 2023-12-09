

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/socialProvider.dart';
import 'package:travel/ipdata.dart';

class Social extends StatelessWidget {
  const Social({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
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
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data["data"].length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                        child: const Text("Remove"),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.remove_circle),
                          ),
                        ),
                        Container(
                          height:height*0.40,
                          width: width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${IpData.ip}/${IpData.image2}/${snapshot.data["data"][index]["memories"]}"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height*0.1,
                        ),
                        Row(
                          children: [
                           const Icon(Icons.favorite, size: 35),
                            SizedBox(width: width*0.03),
                           const Icon(Icons.chat, size: 35),
                             SizedBox(width: width*0.03),
                          const  Icon(Icons.share, size: 40),
                          ],
                        ),
                        Row(
                          children: [
                           SizedBox(
                              width: width*0.03,
                            ),
                            Text(
                              snapshot.data["data"][index]["title"],
                              style: const TextStyle(fontSize: 20)
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: width*0.02),
                            Text(
                              snapshot.data["data"][index]["description"],
                              style: const TextStyle(fontSize: 15),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
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
