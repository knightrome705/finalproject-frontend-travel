import 'package:flutter/material.dart';
import 'package:travel/Feedback.dart';
import 'package:travel/profile.dart';
import 'package:travel/replies.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child:const Text("Feedback"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Doubt()),
              );
            },
          ),
          PopupMenuItem(
            child: Text("Replies"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Replies(),
              ));
            },
          ),
          PopupMenuItem(
            child:const Text("Profile"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Profile(),
              ));
            },
          ),
        ];
      },
    );
  }
}
