import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Models/Packages.dart';
import 'package:travel/Provider/homeProvider.dart';
import 'package:travel/ipdata.dart';
import 'package:travel/widgets/Cust_popup.dart';
import 'package:travel/widgets/cust_drawer.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    Provider.of<homeProvider>(context, listen: false).userCrenditails();
    Future.delayed(Duration(seconds: 1)).whenComplete(() => Provider.of<homeProvider>(context, listen: false).getUser());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text(
          "TraVEl",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        actions: [
          PopupMenu(),
        ],
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder<Packages>(
        future: Provider.of<homeProvider>(context, listen: false).viewPackages(),
        builder: (context,AsyncSnapshot<Packages> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      child: Container(
                        height: height*0.30,
                        width: width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              "${IpData.ip}/${IpData.image}/${snapshot.data!.data![index].pImage}",
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120, left: 200),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<homeProvider>(context,listen: false).showSheet(
                                    context,
                                    snapshot.data!.data![index].pId!,
                                    snapshot.data!.data![index].pName!,
                                    snapshot.data!.data![index].pDescription!,
                                    "${IpData.ip}/${IpData.image}/${snapshot.data!.data![index].pImage1}",
                                    "${IpData.ip}/${IpData.image}/${snapshot.data!.data![index].pImage2}",
                                    height,width
                                  );
                                },
                                child: Text("more",style: TextStyle(color: Colors.white),),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(width*0.10,height*0.05)),
                                  backgroundColor: MaterialStateProperty.all(Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}

