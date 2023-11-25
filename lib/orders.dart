
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/orderProvider.dart';
import 'package:travel/ipdata.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<orderProvider>(context, listen: false).userCrenditails();
    return Scaffold(
      appBar: AppBar(
        title:const Text("TraVel"),
      ),
      body: FutureBuilder(
        future: Provider.of<orderProvider>(context).orderList(),
        builder: (context,AsyncSnapshot snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null) {
              return Center(child: Text("No data"));
            }
            return ListView.builder(
              itemCount: snapshot.data["data"].length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data["data"][index]["p_name"]),
                  subtitle: Text(snapshot.data["data"][index]["date"]),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "${IpData.ip}/${IpData.image}/${snapshot.data["data"][index]["p_image"]}"),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Provider.of<orderProvider>(context, listen: false)
                          .removeOrder(
                          o_id: snapshot.data["data"][index]["o_id"]);
                    },
                    child:const Text("Remove"),
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
