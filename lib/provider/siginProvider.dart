import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:travel/login.dart';
import 'package:http/http.dart' as http;

import '../pages/login/login.dart';

class siginProvider extends ChangeNotifier{
  XFile? image;
  bool secure = true;
  pickImageFromgallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
        image = xFile;
    }
    notifyListeners();
  }

  pickImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
        image = xFile;
    }
    notifyListeners();
  }

  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();
  Future addUser(BuildContext context) async {
    final uri=Uri.parse("http://192.168.230.94/PHP/finalproject/API/add_user_api.php");
    var request=http.MultipartRequest("POST",uri);
    request.fields["first_name"]=first_name.text;
    request.fields["last_name"]=last_name.text;
    request.fields["email"]=email.text;
    request.fields["phone"]=phone.text;
    request.fields["password"]=password.text;
    var pic=await http.MultipartFile.fromPath("photo",image!.path);
    request.files.add(pic);
    var response=await request.send();
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Registerd");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login(),));
    }else{
      Fluttertoast.showToast(msg: "Failed");
    }
    notifyListeners();
  }

  void selectCameraorGallery({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        child: Row(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          pickImageFromCamera();
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                        )),
                    Text("Camera")
                  ],
                )),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          pickImageFromgallery();
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.file_copy,
                          size: 40,
                        )),
                    Text("Gallery")
                  ],
                ))
          ],
        ),
      ),
    );
    notifyListeners();
  }
  void security(){
    secure = !secure;
    notifyListeners();
  }


}