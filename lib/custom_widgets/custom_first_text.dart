import 'package:flutter/material.dart';

class CustomFirstText extends StatelessWidget {
  final String title;
  final String subTitle;
  const CustomFirstText({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45,
              color: Colors.indigo
          ),textAlign: TextAlign.center,),
          SizedBox(height: 10,),
          Text(subTitle,style: TextStyle(
              color: Colors.black,
              fontSize:20,
              fontWeight: FontWeight.bold
          ),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
