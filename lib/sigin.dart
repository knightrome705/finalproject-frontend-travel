import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:travel/login.dart';

class Siginup extends StatefulWidget {
  @override
  SiginupState createState() {
    return SiginupState();
  }
}

class SiginupState extends State<Siginup> {
  @override
  XFile? _image;
  bool secure = true;
  pickImageFromgallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      setState(() {
        _image = xFile;
      });
    }
  }

  pickImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      setState(() {
        _image = xFile;
      });
    }
  }

  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();
  Future addUser() async {
    final uri=Uri.parse("http://192.168.230.94/PHP/finalproject/API/add_user_api.php");
    var request=http.MultipartRequest("POST",uri);
    request.fields["first_name"]=first_name.text;
    request.fields["last_name"]=last_name.text;
    request.fields["email"]=email.text;
    request.fields["phone"]=phone.text;
    request.fields["password"]=password.text;
    var pic=await http.MultipartFile.fromPath("photo",_image!.path);
    request.files.add(pic);
    var response=await request.send();
    if(response.statusCode==200){
      print("Sucess");
      Fluttertoast.showToast(msg: "Registerd");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login(),));
    }else{
      Fluttertoast.showToast(msg: "Failed");
    }
  }

  void selectCameraorGallery() {
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
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: Center(
          child: Container(
            height: 600,
            width: 350,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Text(
                      "SIGIN UP",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        _image == null
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(File(_image!.path))),
                                ),
                              ),
                        Positioned(
                            bottom: -10,
                            right: -10,
                            child: IconButton(
                                onPressed: () {
                                  selectCameraorGallery();
                                  // pickImage();
                                },
                                icon: Icon(Icons.add_a_photo)))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 280,
                      child: TextFormField(
                        controller: first_name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your first name";
                          }
                        },
                        decoration: InputDecoration(
                            label: Text("first_name"),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 280,
                      child: TextFormField(
                        controller: last_name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your last name";
                          }
                        },
                        decoration: InputDecoration(
                            label: Text("last name"),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 280,
                      child: TextFormField(
                        controller: email,
                        validator: (value) {
                          final RegExp _emailRegex =
                              RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          if (value!.isEmpty) {
                            return "please enter your email";
                          } else if (!_emailRegex.hasMatch(value)) {
                            return "Enter a valid email";
                          }
                        },
                        decoration: InputDecoration(
                            label: Text("Email"), border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 280,
                      child: TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your phone";
                          } else if (value.length < 10 && value.length > 10) {
                            return "please enter a valid number";
                          }
                        },
                        decoration: InputDecoration(
                            label: Text("phone"), border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 280,
                      child: TextFormField(
                        controller: password,
                        obscureText: secure,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter password";
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    secure = !secure;
                                  });
                                },
                                icon: secure == false
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            label: Text("password"),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        bool validate = formkey.currentState!.validate();
                        if (validate == true) {
                          addUser();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          minimumSize: MaterialStatePropertyAll(
                              Size(double.infinity, 50))),
                      child: Text("Sigin",style: TextStyle(color: Colors.white),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => Login(),
                              ));
                            },
                            child: Text("log in"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
