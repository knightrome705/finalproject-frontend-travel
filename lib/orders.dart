import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/ipdata.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Future orderList()async{
    var data={"user_id":user_id.toString()};
    Response response =await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/view_orders_api.php"),body:data );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return data;
    }
  }
  var remove;
  Future removeOrder({required o_id})async{
    var data={"o_id":o_id};
  Response response=await  post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/remove_package_orders_api.php"),body: data);
  if(response.statusCode==200){
    remove=jsonDecode(response.body);
    Fluttertoast.showToast(msg: "Removed");
    setState(() {

    });
  }
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

  @override
  void initState() {
    userCrenditails();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TraVel"),
      ),
      body: FutureBuilder(
        future: orderList(),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context,index) {
                  return ListTile(
                    title: Text(snapshot.data["data"][index]["p_name"]),
                    subtitle: Text(snapshot.data["data"][index]["date"]),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${IpData.ip}/${IpData.image}/${snapshot.data["data"][index]["p_image"]}"),
                    ),
                    trailing: ElevatedButton(onPressed: (){
                      removeOrder(o_id: snapshot.data["data"][index]["o_id"]);
                    },child:Text("Remove"),),
                  );
                }
            );
          }else{
            return Center(
              child:Text("Something went wrong") ,
            );
          }

        }
      ),
    );
  }
}
