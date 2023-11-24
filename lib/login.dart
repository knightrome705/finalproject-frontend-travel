import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/loginProvider.dart';
import 'package:travel/sigin.dart';

class Login extends StatelessWidget {
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
            height: 500,
            width: 350,
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
                        height: 30,
                      ),
                      SizedBox(
                        width: 280,
                        height: 40,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: Provider.of<loginProvider>(context).emailController,
                          validator: (value) {
                            final RegExp _emailRegex =
                            RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                            if (value!.isEmpty) {
                              return "please enter your email";
                            } else if (!_emailRegex.hasMatch(value)) {
                              return "enter a valid email";
                            }
                          },
                          decoration: InputDecoration(label: Text("Email"), border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        width: 280,
                        child: TextFormField(
                          controller: Provider.of<loginProvider>(context).passwordController,
                          obscureText: Provider.of<loginProvider>(context).secure,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your password";
                            }
                          },
                          decoration: InputDecoration(
                            label: Text("Password"),
                            suffixIcon: IconButton(
                              onPressed: () {
                                Provider.of<loginProvider>(context, listen: false).security();
                              },
                              icon: Provider.of<loginProvider>(context).secure == false
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
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
                          minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                        ),
                        child: Center(
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
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
