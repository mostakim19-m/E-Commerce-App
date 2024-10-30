import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({
  String? title,
  List<Widget>? action,
  Widget? leadingIcon,
  Color ? backgroundColor,
}){
  return AppBar(
    elevation: 0,
    backgroundColor:backgroundColor ,
    centerTitle: true,
    leading: leadingIcon,
    title:title!=null? Text(title):null,
    actions: action,
  );
}