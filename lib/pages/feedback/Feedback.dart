import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/feedbackProvider.dart';
import 'package:travel/pages/bottom_nav/BottomNavigator.dart';

class Doubt extends StatelessWidget {
  final TextEditingController feedback = TextEditingController();

  Doubt({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<feedbackProvider>(context, listen: false).userCrenditails();
    // var height=MediaQuery.of(context).size.height;
    // var width=MediaQuery.of(context).size.width;
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
          const  Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
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
                    minLines:100,
                    maxLines: 200,
                    decoration:const InputDecoration(
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
              ],
            ),
           const SizedBox(
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
