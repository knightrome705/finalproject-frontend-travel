import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/profileProvider.dart';

import '../../constants/ipdata.dart';
import '../../ui/widget/Cust_poup_2.dart';


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var height=MediaQuery.of(context).size.height;
    // var width=MediaQuery.of(context).size.width;
    Provider.of<profileProvider>(context, listen: false).userCrenditails();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const Text(
          "TraVEl",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        actions:const [
          Profile_popup(),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: Provider.of<profileProvider>(context).getUser(),
          builder: (context,AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration:const BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          spreadRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(100),
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.yellow,
                                width: 10
                              ),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage("${IpData.ip}/${IpData.image2}/${snapshot.data!["data"]["photo"]}"),
                              ),
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                 const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!["data"]["first_name"],
                        style: GoogleFonts.vinaSans(fontSize: 25),
                      ),
                     const SizedBox(
                        width: 8,
                      ),
                      Text(
                        snapshot.data!["data"]["last_name"],
                        style: GoogleFonts.vinaSans(fontSize: 25),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    snapshot.data!["data"]["email"],
                    style: GoogleFonts.vinaSans(fontSize: 25),
                  ),

                ],
              );
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}

