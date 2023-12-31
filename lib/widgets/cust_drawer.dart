import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/Provider/homeProvider.dart';
import 'package:travel/home.dart';
import 'package:travel/ipdata.dart';
import 'package:travel/login.dart';
import 'package:travel/orders.dart';
import 'package:travel/profile.dart';
import 'package:travel/social.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              height: height*0.30,
              width: width*0.30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.yellow,
                  width: 5
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    "${IpData.ip}/${IpData.image2}/${Provider.of<homeProvider>(context).image}",
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BottomNav(),
                  ),
                );
              },
              title:const Text("Home"),
              leading:const Icon(Icons.home),
            ),
          ),
          SizedBox(
            height: height*0.02,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Social(),
                  ),
                );
              },
              title:const Text("Posts"),
              leading:const Icon(Icons.group),
            ),
          ),
           SizedBox(
            height: height*0.02,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Homepage(),
                  ),
                );
              },
              title:const Text("Packages"),
              leading:const Icon(Icons.wallet_travel),
            ),
          ),
           SizedBox(
            height:height*0.02,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              title:const Text("Profile"),
              leading:const Icon(Icons.account_circle),
            ),
          ),
           SizedBox(
            height:height*0.02,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Orders(),
                  ),
                );
              },
              title:const Text("Orders"),
              leading:const Icon(Icons.table_rows_sharp),
            ),
          ),
           SizedBox(
            height: height*0.02,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Provider.of<homeProvider>(context, listen: false).loginUser();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              title:const Text("Logout"),
              leading:const Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
