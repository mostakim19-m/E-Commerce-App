import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Widget? suffixIcon;
  final TextInputType? keyBoardType;
  final TextEditingController? controller;
  final bool? obscureText;
  final void Function()? onTap;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.suffixIcon,
    this.keyBoardType,
    this.controller,
    this.obscureText,
    this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTap: onTap,
        obscureText: obscureText??false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This is required';
          }
          return null;
        },
        controller: controller,
        keyboardType: keyBoardType,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          label: Text(
            labelText,
          ),
          labelStyle: const TextStyle(
              color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 24),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 4, color: Colors.teal)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.red)),
        ),
      ),
    );
  }
}