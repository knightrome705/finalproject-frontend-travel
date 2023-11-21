import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/BottomNavigator.dart';


class Doubt extends StatefulWidget {
  const Doubt({super.key});

  @override
  State<Doubt> createState() => _DoubtState();
}

class _DoubtState extends State<Doubt> {
  TextEditingController feedback=TextEditingController();
  Future feedBack({required feedback,required user_id})async{
    var data={"user_id":user_id,"feedback":feedback,"initial_date":DateTime.now().toString()};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/add_feedback_api.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Thanks for your response");
    }
  }
  var user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user_crenditals");
    setState(() {
      user_id = result.toString();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCrenditails();
  }





  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("TraVeL"),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                width: 20,
                ),
                Text("Feedback",style: TextStyle(fontSize: 20),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height:250,
                  width: 350,
                  child: TextField(
                    controller:feedback ,
                    expands: false,
                    minLines: 100,
                     maxLines:200,
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
                ElevatedButton(onPressed: (){
                  feedBack(feedback: feedback.text, user_id: user_id);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav(),));
                }, child:Text("Submit")),
              ],
            )
          ],
        ),


      ),
    );
  }
}
