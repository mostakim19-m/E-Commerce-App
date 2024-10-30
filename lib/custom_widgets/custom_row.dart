import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String firstText;
  final String secondText;
  final void Function()?onTap;
  const CustomRow({super.key, required this.firstText, required this.secondText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text( firstText,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
        SizedBox(width:10,),
        InkWell(
          onTap: onTap,
          child: Text(secondText,style: TextStyle(
            fontSize: 25,
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),),
        ),
      ],
    );
  }
}
