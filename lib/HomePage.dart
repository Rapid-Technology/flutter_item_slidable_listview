import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_slidable_example/FactoryData.dart';

import 'User.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slidable Item ListView"),
        backgroundColor: Colors.green[700],
        brightness: Brightness.dark,
      ),
      body: ListView.builder(
        itemCount: FactoryData.users.length,
        itemBuilder: (BuildContext context, int index) =>
            item(FactoryData.users[index]),
      ),
    );
  }

  Widget item(User user) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: [
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => print('Archive'),
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            setState(() {
              FactoryData.users.removeWhere((element) => element.id == user.id);
            });
          },
        )
      ],
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: user.photo,
          imageBuilder: (context, imageProvider) => Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        onTap: () {},
      ),
    );
  }
}
