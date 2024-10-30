import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()?onTap;
  const CustomButton({super.key, required this.title, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color:Colors.indigo,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(title,style: const TextStyle(
              color:Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}