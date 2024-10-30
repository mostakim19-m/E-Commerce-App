import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_projects/pages/bottom_navbar.dart';
import 'package:new_projects/pages/login_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final user =FirebaseAuth.instance;
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => user==true? LoginScreen(): BottomNavbar(),),
            (route) =>false,);
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(child: Text('WelCome E-Commerce App',style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),),),
    );
  }
}
