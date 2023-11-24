import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/siginProvider.dart';
import 'package:travel/login.dart';

class Siginup extends StatelessWidget {
  @override
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
                key: Provider.of<siginProvider>(context).formkey,
                child: Column(
                  children: [
                    Text(
                      "SIGIN UP",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Provider.of<siginProvider>(context).image == null
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
                   const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 280,
                      child: TextFormField(
                        controller: Provider.of<siginProvider>(context).first_name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your first name";
                          }
                        },
                        decoration: InputDecoration(
                            label:const Text("first_name"),
                            border: OutlineInputBorder()),
                      ),
                    ),
                   const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 280,
                      child: TextFormField(
                        controller: Provider.of<siginProvider>(context).last_name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your last name";
                          }
                        },
                        decoration: InputDecoration(
                            label:const Text("last name"),
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
                        controller: Provider.of<siginProvider>(context).email,
                        keyboardType: TextInputType.emailAddress,
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
                  const  SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 280,
                      child: TextFormField(
                        controller: Provider.of<siginProvider>(context).phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your phone";
                          } else if (value.length < 10 && value.length > 10) {
                            return "please enter a valid number";
                          }
                        },
                        decoration: InputDecoration(
                            label:const Text("phone"), border: OutlineInputBorder()),
                      ),
                    ),
                  const  SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 280,
                      child: TextFormField(
                        controller: Provider.of<siginProvider>(context).password,
                        obscureText: Provider.of<siginProvider>(context).secure,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter password";
                          } else if (value.length < 6) {
                            return "Enter a value of length 6";
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  Provider.of<siginProvider>(context,listen: false).security();
                                },
                                icon: Provider.of<siginProvider>(context,listen: false).secure == false
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            label:const Text("password"),
                            border: OutlineInputBorder()),
                      ),
                    ),
                   const SizedBox(
                      height: 20,
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
                          MaterialStateProperty.all(Size(double.infinity, 50))),
                      child:const Text(
                        "Sigin",
                        style:const TextStyle(color: Colors.white),
                      ),
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
