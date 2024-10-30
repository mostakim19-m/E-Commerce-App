import 'package:flutter/material.dart';
import 'package:new_projects/pages/card_screen.dart';
import 'package:new_projects/pages/home_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int index=0;
  List<Widget>screens=[
    HomeScreen(),
    Center(child: Text('Favorite Screen'),),
    CardScreen(),
    Center(child: Text('Profile Screen'),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo,
          selectedFontSize: 20,
          currentIndex:index,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          onTap: (value) {
            setState(() {
              index=value;
            });
          },
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp),label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
      ]),
    );
  }
}
