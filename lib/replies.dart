import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Replies extends StatefulWidget {
  const Replies({super.key});

  @override
  State<Replies> createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  Future repliesfromAdmin()async{
    var data={"user_id":user_id};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/view_reply_query_admin_api.php"),body: data);
    var data1;
    if(response.statusCode==200){
       data1=jsonDecode(response.body);

    }
    return data1;
  }
  Future removeReply({required id})async{
    var data={"id":id};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/remove_query_api.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "cleared");
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
  }

  @override
  void initState() {
    userCrenditails();
    // TODO: implement initState
    repliesfromAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TraVeL"),
      ),
      body: FutureBuilder(
        future:repliesfromAdmin(), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.hasData){
          if(snapshot.data['data']==null){
            return Center(child: Text("no data"));
          }else{
          return ListView.builder(
              itemCount: snapshot.data["data"].length,
              itemBuilder: (context,index) {
                return ListTile(
                  title: Text(snapshot.data["data"][index]["reply"],style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(snapshot.data["data"][index]["quires"]??"no data"),
                  trailing: ElevatedButton(onPressed: (){
                    removeReply(id: snapshot.data["data"][index]["q_id"]);
                  },child: Text("clear"),),
                );
              }
          );
        }}else{
          return Center(
            child:Text("Something went wrong") ,
          );
        }

      } ,

      ),
    );
  }
}
