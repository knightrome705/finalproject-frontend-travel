import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/Provider/enquiryProvider.dart';

class Enquiry extends StatelessWidget {
  final TextEditingController enquiry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<enquiryProvider>(context).userCrenditails();

    return Scaffold(
      appBar: AppBar(
        title:const Text("TraVel"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
             const Text(
                "Enquiry:",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 250,
                width: 350,
                child: TextField(
                  controller: enquiry,
                  expands: false,
                  minLines: 100,
                  maxLines: 200,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
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
    );
  }
}
