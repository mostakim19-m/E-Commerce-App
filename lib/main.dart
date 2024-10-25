import 'package:flutter/material.dart';
import 'package:new_projects/pages/first_screen.dart';

main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: FirstScreen(),
    );
  }
}
