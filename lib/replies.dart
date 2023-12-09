
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/replyProvider.dart';

class Replies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<replyProvider>(context, listen: false).userCrenditails();

    return Scaffold(
      appBar: AppBar(
        title:const Text("TraVeL"),
      ),
      body: FutureBuilder(
        future: Provider.of<replyProvider>(context, listen: false).repliesfromAdmin(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null) {
              return const Center(child: Text("No data"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data["data"][index]["reply"],
                      style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                    subtitle: Text(snapshot.data["data"][index]["quires"] ?? "No data"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Provider.of<replyProvider>(context, listen: false)
                            .removeReply(id: snapshot.data["data"][index]["q_id"]);
                      },
                      child: const Text("Clear"),
                    ),
                  );
                },
              );
            }
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
