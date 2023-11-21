import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/enquiry.dart';

class Conform extends StatefulWidget{

  String p_id,p_name,p_image,description;
  Conform({required this.p_id,required this.p_image,required this.description,required this.p_name });
  @override
  ConformState createState(){
    return ConformState();
  }
}
var user_id;
bool isClicked=true;
List packages=[];
class ConformState extends State<Conform>{
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user_id = sharedPreferences.getInt("user_crenditals").toString();
  }

  Future purchaseTrip(String p_id)async{
    var data={"p_id":p_id.toString(),"user_id":user_id,"date":DateTime.now().toString()};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/order_packages_api.php"),body:data );
    if(response.statusCode==200){
      print(response.body);
    }
  }
  purchasePackage({String? package_id}) {
    packages.add(package_id);
  }
  Future removeTrip(String remove_id)async{
    var data={"id":remove_id};
    Response response=await post(Uri.parse("http://192.168.230.94/PHP/finalproject/API/remove_package_orders_api.php"),body:data );
    if(response.statusCode==200){
      print(response.body);
      print("Sucess");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCrenditails();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("TraVEl"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.p_name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
          Container(
            height: 200,
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(widget.p_image)
              )
            ),
          ),
          Text(widget.description,style: TextStyle(fontSize:20),),
          SizedBox(
            height: 20,
          ),
          TextButton(onPressed:(){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Enquiry(),));


          }, child:Text("Any Doubt?",style: TextStyle(fontSize:20),)),
          Center(
            child: ElevatedButton(onPressed: ()async{
                if(packages.contains(widget.p_id)){
                  await removeTrip(widget.p_id);
                  packages.remove(widget.p_id);
                  Fluttertoast.showToast(msg: "Removed");
                  Future.delayed(Duration(seconds: 1),(){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav(),));

                  });
                  setState(() {

                  });
                }else{
                  purchaseTrip(widget.p_id);
                  purchasePackage(package_id:widget.p_id);
                 Fluttertoast.showToast(msg: "Booked!");
                  Future.delayed(Duration(seconds: 1),(){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav(),));

                  });
                  setState(() {

                  });
                }



            },
                style:ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                    Size(150,40)
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    packages.contains(widget.p_id)==true?Colors.yellow:Colors.red,
                  )
                ),
                child:packages.contains(widget.p_id)==true?Text("Remove now"):Text("Book now"),),
          )

        ],
      ),

    );
  }
}