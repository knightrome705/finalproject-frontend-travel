import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/BottomNavigator.dart';

class MakePost extends StatefulWidget {
  const MakePost({super.key});

  @override
  State<MakePost> createState() => _MakePostState();
}

class _MakePostState extends State<MakePost> {
  File? image;
  makeaPost()async{
   //  var data={"user_id":user_id,"memories":image,"title":title.text.toString(),"description":description.text.toString()};
   // Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/makeaPost_api.php"),body: data);
   // if(response.statusCode==200){
   //   print(response.body);
   // }
    final uri=Uri.parse("http://192.168.230.94/PHP/finalproject/API/makeaPost_api.php");
    var request=http.MultipartRequest('POST',uri);
    request.fields["user_id"]=user_id;
    request.fields['title']=title.text;
    request.fields['description']=description.text;
    var pic=await http.MultipartFile.fromPath("memories", image!.path);
    request.files.add(pic);
    var response=await request.send();
    if(response.statusCode==200){
      print("uploded");
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
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  imageGallery()async{
    ImagePicker imagePicker=ImagePicker();
  XFile? xfile=await  imagePicker.pickImage(source: ImageSource.gallery);
  if(xfile!=null){
    setState(() {
      image=File(xfile.path);
    });
  }
  }
  imageCamera()async{
    ImagePicker imagePicker=ImagePicker();
   XFile? xfile=await imagePicker.pickImage(source: ImageSource.camera);
    if(xfile!=null){
      setState(() {
        image=File(xfile.path);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCrenditails();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("TraVel"),

        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height:150,
                  width:MediaQuery.of(context).size.width/2,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(onTap:(){
                        imageCamera();
                      },child: Icon(Icons.camera,size: 50,)),
                      Text("camera")
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    )
                  ),
                )
                ,Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width/2,
                  // color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(onTap: (){
                        imageGallery();
                      },  child: Icon(Icons.file_copy,size: 50,)),
                      Text("File")
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                ),
              ],
            ),
          SizedBox(
            height: 20,
          ),
          image==null?SizedBox():Image.file(File(image!.path),height:150,),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(width: 20,),
              Text("Title",style: TextStyle(fontSize: 20),)
            ],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              SizedBox(
                height: 50,
                width:350,
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                ),
              )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Text("Description",style: TextStyle(fontSize: 20),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height:250,
                  width: 350,
                  child: TextField(
                    controller: description,
                    expands: false,
                    minLines: 100,
                    maxLines: 200,
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  makeaPost();
                  Fluttertoast.showToast(msg: "Posted");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav(),));
                }, child:Text("Post"))
              ],
            )




          ],
        )




      ),
    );
  }
}
