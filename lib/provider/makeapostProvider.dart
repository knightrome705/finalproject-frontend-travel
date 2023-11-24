import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class makeaProvider extends ChangeNotifier{
  File? image;
  final TextEditingController title=TextEditingController();
  final TextEditingController description=TextEditingController();
  makeaPost()async{

    final uri=Uri.parse("http://192.168.230.94/PHP/finalproject/API/makeaPost_api.php");
    var request=http.MultipartRequest('POST',uri);
    request.fields["user_id"]=user_id;
    request.fields['title']=title.text;
    request.fields['description']=description.text;
    var pic=await http.MultipartFile.fromPath("memories", image!.path);
    request.files.add(pic);
    var response=await request.send();
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Posted");
    }
    notifyListeners();

  }
  var user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user_crenditals");
      user_id = result.toString();
      notifyListeners();
  }

  imageGallery()async{
    ImagePicker imagePicker=ImagePicker();
    XFile? xfile=await  imagePicker.pickImage(source: ImageSource.gallery);
    if(xfile!=null){
        image=File(xfile.path);
    }
    notifyListeners();
  }
  imageCamera()async{
    ImagePicker imagePicker=ImagePicker();
    XFile? xfile=await imagePicker.pickImage(source: ImageSource.camera);
    if(xfile!=null){
        image=File(xfile.path);

    }
    notifyListeners();
  }

}