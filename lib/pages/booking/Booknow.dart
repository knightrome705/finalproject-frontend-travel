import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/booknowProvider.dart';

import '../bottom_nav/BottomNavigator.dart';
import '../feedback/enquiry.dart';


class Conform extends StatelessWidget {
  final String p_id, p_name, p_image, description;

  Conform({
    required this.p_id,
    required this.p_image,
    required this.description,
    required this.p_name,
  });

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    Provider.of<booknowProvider>(context, listen: false).userCrenditails();

    return Scaffold(
      appBar: AppBar(
        title:const Text("TraVEl"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              p_name,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              height: height*0.20,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(p_image),
                ),
              ),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: height*0.02,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Enquiry()));
              },
              child:const Text("Any Doubt?", style: TextStyle(fontSize:18,fontStyle: FontStyle.italic)),
            ),
              SizedBox(
              height: height*0.02,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Provider.of<booknowProvider>(context, listen: false)
                      .purchaseTrip(p_id);

                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => BottomNav()),
                    );
                  });
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(width, height*0.06),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.red,
                  ),
                ),
                child:const Text("Book now",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
