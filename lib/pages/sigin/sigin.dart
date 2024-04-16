import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/siginProvider.dart';

import '../login/login.dart';
// import 'package:travel/login.dart';

class Siginup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: Center(
          child: Container(
            height: height*0.80,
            width: width*0.90,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: Provider.of<siginProvider>(context).formkey,
                child: Column(
                  children: [
                   const Text(
                      "SIGIN UP",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height*0.01,
                    ),
                    Stack(
                      children: [
                        Provider.of<siginProvider>(context).image == null
                            ? Container(
                          height: height*0.15,
                          width: width*0.25,
                          decoration:const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        )
                            : Container(
                          height: height*0.15,
                          width: width*0.25,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(File(Provider.of<siginProvider>(context).image!.path))),
                          ),
                        ),
                        Positioned(
                            bottom: -10,
                            right: -10,
                            child: IconButton(
                                onPressed: () {
                                  Provider.of<siginProvider>(context, listen: false).selectCameraorGallery(context: context);
                                  // selectCameraorGallery();
                                  // pickImage();
                                },
                                icon:const Icon(Icons.add_a_photo)))
                      ],
                    ),
                    SizedBox(
                      height: height*0.02,
                    ),
                    SizedBox(
                      height: height*0.055,
                      width: width*0.7,
                      child: TextFormField(
                        controller: Provider.of<siginProvider>(context).first_name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your first name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label:Text("first_name"),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: height*0.02,
                    ),
                    SizedBox(
                      height:height*0.055,
                      width: width*0.7,
                      child: TextFormField(
                        controller: Provider.of<siginProvider>(context).last_name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your last name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label:Text("last name"),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: height*0.02,
                    ),
                    SizedBox(
                      height: height*0.055,
                      width: width*0.7,
                      child: TextFormField(
                        controller: Provider.of<siginProvider>(context).email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final RegExp emailRegex =
                          RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          if (value!.isEmpty) {
                            return "please enter your email";
                          } else if (!emailRegex.hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label: Text("Email"), border: OutlineInputBorder()),
                      ),
                    ),
                   SizedBox(
                      height: height*0.02,
                    ),
                    SizedBox(
                      height: height*0.055,
                      width: width*0.7,
                      child: TextFormField(
                        controller: Provider.of<siginProvider>(context).phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your phone";
                          } else if (value.length < 10 && value.length > 10) {
                            return "please enter a valid number";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label:Text("phone"), border: OutlineInputBorder()),
                      ),
                    ),
                   SizedBox(
                      height:height*0.02,
                    ),
                    SizedBox(
                      height: height*0.055,
                      width:  width*0.7,
                      child: TextFormField(
                        controller: Provider.of<siginProvider>(context).password,
                        obscureText: Provider.of<siginProvider>(context).secure,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter password";
                          } else if (value.length < 6) {
                            return "Enter a value of length 6";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  Provider.of<siginProvider>(context,listen: false).security();
                                },
                                icon: Provider.of<siginProvider>(context,listen: false).secure == false
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            label:const Text("password"),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: height*0.02,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        bool validate =
                        Provider.of<siginProvider>(context,listen: false).formkey.currentState!.validate();
                        if (validate == true) {
                          Provider.of<siginProvider>(context,listen: false).addUser(context);
                          // addUser();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                          minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, height*0.06))),
                      child:const Text(
                        "Sigin",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => Login(),
                              ));
                            },
                            child:const Text("log in"))
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
