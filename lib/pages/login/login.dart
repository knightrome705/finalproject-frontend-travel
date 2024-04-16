import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/loginProvider.dart';
import 'package:travel/sigin.dart';

class Login extends StatelessWidget {
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
            height: height*0.5,
            width: width*0.90,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Form(
                  key: Provider.of<loginProvider>(context).formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    const  Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height:height*0.05,
                      ),
                      SizedBox(
                        width: width*0.70,
                        height: height*0.05,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: Provider.of<loginProvider>(context).emailController,
                          validator: (value) {
                            final RegExp emailRegex =
                            RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                            if (value!.isEmpty) {
                              return "please enter your email";
                            } else if (!emailRegex.hasMatch(value)) {
                              return "enter a valid email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(label: Text("Email"), border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: height*0.03,
                      ),
                      SizedBox(
                        height: height*0.05,
                        width: width*0.7,
                        child: TextFormField(
                          controller: Provider.of<loginProvider>(context).passwordController,
                          obscureText: Provider.of<loginProvider>(context).secure,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your password";
                            }else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            suffixIcon: IconButton(
                              onPressed: () {
                                Provider.of<loginProvider>(context, listen: false).security();
                              },
                              icon: Provider.of<loginProvider>(context).secure == false
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height*0.03,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          bool validator = Provider.of<loginProvider>(context,listen: false).formkey.currentState!.validate();
                          if (validator == true) {
                            Provider.of<loginProvider>(context,listen: false).logIn(email: Provider.of<loginProvider>(context,listen: false).emailController.text,password: Provider.of<loginProvider>(context,listen: false).passwordController.text,context:context);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                          minimumSize: MaterialStateProperty.all(Size(double.infinity,height*0.05)),
                        ),
                        child: const Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:height*0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => Siginup(),
                                ),
                              );
                            },
                            child:const Text("Signup"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
