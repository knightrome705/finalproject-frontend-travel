import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/Provider/feedbackProvider.dart';

class Doubt extends StatelessWidget {
  final TextEditingController feedback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<feedbackProvider>(context, listen: false).userCrenditails();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title:const Text("TraVeL"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
              const  Text(
                  "Feedback",
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
                    controller: feedback,
                    expands: false,
                    minLines: 3,
                    maxLines: 10,
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<feedbackProvider>(context, listen: false).feedBack(
                      feedback: feedback.text,
                      user_id: Provider.of<feedbackProvider>(context, listen: false).user_id,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav(),));
                  },
                  child:const Text("Submit"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
