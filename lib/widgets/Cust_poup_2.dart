import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Feedback.dart';
import 'package:travel/MakePost.dart';
import 'package:travel/Provider/profileProvider.dart';

class Profile_popup extends StatelessWidget {
  const Profile_popup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text("Post"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MakePost()));
            },
          ),
          PopupMenuItem(
            child:const Text("Feedback"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Doubt()));
            },
          ),
          PopupMenuItem(
            child:const Text("Logout"),
            onTap: ()  {
              Provider.of<profileProvider>(context, listen: false).logout(context);
            },
          ),
        ];
      },
    );
  }
}
