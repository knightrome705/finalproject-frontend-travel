import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/Provider/booknowProvider.dart';
import 'package:travel/enquiry.dart';

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
    Provider.of<booknowProvider>(context, listen: false).userCrenditails();

    return Scaffold(
      appBar: AppBar(
        title:const Text("TraVEl"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            p_name,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 200,
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(p_image),
              ),
            ),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 20),
          ),
         const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Enquiry()));
            },
            child:const Text("Any Doubt?", style: TextStyle(fontSize: 20)),
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
                  Size(150, 40),
                ),
                backgroundColor: MaterialStateProperty.all(
                  Colors.red,
                ),
              ),
              child:const Text("Book now"),
            ),
          ),
        ],
      ),
    );
  }
}
