import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:travel/BottomNavigator.dart';
import 'package:travel/Provider/enquiryProvider.dart';

import '../bottom_nav/BottomNavigator.dart';

class Enquiry extends StatelessWidget {
  final TextEditingController enquiry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<enquiryProvider>(context).userCrenditails();
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:const Text("TraVel"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Enquiry:",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              TextField(
                  controller: enquiry,
                  expands: false,
                  minLines: 10,
                  maxLines: 25,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              SizedBox(
                height: height*0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<enquiryProvider>(context, listen: false).enquiryPackage(
                    enquiry: enquiry,
                    user_id: Provider.of<enquiryProvider>(context, listen: false).user_id,
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BottomNav()),
                  );
                },
                child:const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
