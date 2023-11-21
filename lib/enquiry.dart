import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/BottomNavigator.dart';
class Enquiry extends StatefulWidget {
  const Enquiry({super.key});

  @override
  State<Enquiry> createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  TextEditingController enquiry=TextEditingController();
  Future enquiryPackage({required enquiry,required user_id})async{
    var data={"user_id":user_id,"query":enquiry,"date":DateTime.now().toString()};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/add_query_api.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Replied as soon as possible");
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
    return Scaffold(
      appBar: AppBar(
        title: Text("TraVel"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text("Enquiry:" ,style: TextStyle(fontSize: 20),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 250,
                width: 350,
                child: TextField(
                  controller:enquiry ,
                  expands: false,
                  minLines: 100,
                  maxLines: 200,
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
          ElevatedButton(onPressed: (){
            enquiryPackage(enquiry:enquiry.text, user_id: user_id);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav(),));
          }, child:Text("Submit"))
        ],
      ),
    );
  }
}
