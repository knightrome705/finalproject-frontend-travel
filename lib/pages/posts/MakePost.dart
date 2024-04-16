import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/Provider/makeapostProvider.dart';

class MakePost extends StatelessWidget {
  const MakePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    Provider.of<makeaProvider>(context, listen: false).userCrenditails();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("TraVel"),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<makeaProvider>(context, listen: false).imageCamera();
                        },
                        child:const Icon(Icons.camera, size: 50),
                      ),
                     const Text("Camera"),
                    ],
                  ),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<makeaProvider>(context, listen: false).imageGallery();
                        },
                        child:const Icon(Icons.file_copy, size: 50),
                      ),
                     const Text("File"),
                    ],
                  ),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                ),
              ],
            ),
           const SizedBox(
              height: 20,
            ),
            Provider.of<makeaProvider>(context).image == null
                ? SizedBox()
                : Image.file(File(Provider.of<makeaProvider>(context).image!.path), height: 150),
           const SizedBox(
              height: 50,
            ),
           const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
               const Text("Title", style: TextStyle(fontSize: 20)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 50,
                  width: 350,
                  child: TextField(
                    controller: Provider.of<makeaProvider>(context, listen: false).title,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          const  SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text("Description", style: TextStyle(fontSize: 20)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 250,
                  width: 350,
                  child: TextField(
                    controller: Provider.of<makeaProvider>(context, listen: false).description,
                    expands: false,
                    minLines: 100,
                    maxLines: 200,
                    decoration: InputDecoration(border: OutlineInputBorder()),
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
                    Provider.of<makeaProvider>(context, listen: false).makeaPost();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav()));
                  },
                  child:const Text("Post"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
