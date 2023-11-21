import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/ipdata.dart';

class Social extends StatefulWidget {
  const Social({super.key});

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  Future getPostes()async{
    Response response=await get(Uri.parse("http://192.168.230.94/PHP/finalproject/API/view_posts_api.php"));
    if(response.statusCode==200) {
      var result = jsonDecode(response.body);
      return result;
    }
  }

  Future removePost({required post_id})async{
    var value={"post_id":post_id,"user_id":user_id};
  Response response=await  post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/removePost_api.php"),body: value);
  print(response.body);
  if(response.statusCode==200){
    Fluttertoast.showToast(msg: "Removed");
    setState(() {

    });
  }else{
    Fluttertoast.showToast(msg: "Failed");
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
        title: Text("TraVEl"),
          ),
      body: FutureBuilder(
        future: getPostes(),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context,index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("${IpData.ip}/${IpData.image2}/${snapshot.data["data"][index]["photo"]}"),
                          ),
                          title: Text(snapshot.data["data"][index]["first_name"]),
                          subtitle: Text(snapshot.data["data"][index]["email"]),
                          trailing: IconButton(onPressed: (){
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: Text("Are you sure?"),
                                actions: [
                                  TextButton(onPressed:(){
                                    removePost(post_id:snapshot.data["data"][index]["post_id"] );
                                    Fluttertoast.showToast(msg: "Removed");
                                    Navigator.of(context).pop();
                                  }, child:Text("Remove"))
                                ],
                              );
                            },);
                          },icon: Icon(Icons.remove_circle),),
                        ),
                        Container(
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage("${IpData.ip}/${IpData.image2}/${snapshot.data["data"][index]["memories"]}"),
                                fit: BoxFit.fill
                              )
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [SizedBox(
                            width: 10,
                          ),Icon(Icons.heart_broken_sharp,size: 35,),SizedBox(width:35,),Icon(Icons.chat,size: 35,),SizedBox(width: 20,),Icon(Icons.share,size: 40,)],
                        ),
                        Row(
                          children: [SizedBox(width: 20,),
                            Text(snapshot.data["data"][index]["title"],style: GoogleFonts.vinaSans(fontSize: 25),),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text(snapshot.data["data"][index]["description"],style: GoogleFonts.vinaSans(fontSize: 15),)
                          ],
                        )
                      ],
                    ),
                  );
                }
            );
          }else{
            return Center(
              child: Text("Something went wrong"),
            );
          }

        }
      ),
    );
  }
}
