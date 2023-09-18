// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:crud_sederhana_raden/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';

class DrawerNavigation extends StatefulWidget {

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://media.licdn.com/dms/image/D5603AQGWFTkVgoiKjA/profile-displayphoto-shrink_800_800/0/1680541139382?e=1700697600&v=beta&t=ufUnHeDgFiogBxQiGJ8bWaGoROH0K1nI-6PUnhKYpXA'),
              ),
              accountName: Text('Raden Dimas Erlangga'),
              accountEmail: Text('Zirkified123@gmail.com'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen())),
            ),
              ListTile(
              leading: Icon(Icons.home),
              title: Text('Kategori'),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
