import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


Widget defaultButtom({
   double? width,
   Function()? function,
   Color ?color,
   String ?text,
   Color ?background,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: function,
        child: Text(
          text!,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaultAppBar({
   required BuildContext context,
   required String title,
  required List<Widget> action,
})=>AppBar(
  leading:  InkWell(
    onTap: (){
      Navigator.of(context).pop();
    },
    child: const FaIcon(
      FontAwesomeIcons.arrowLeft,
      color: Colors.black,
    ),
  ),
title:  Text(
title,

style: const TextStyle(
color: Colors.black
),
),
  actions: action,
);

Widget defaultFormField({
  required  controller,
  required String text,
  required Color color,
  required IconData prefixIcon ,
   required validator,

})=>Container(
  decoration: const BoxDecoration(
    // border: Border.all(width: 1.2,color: Colors.grey),
    borderRadius:  BorderRadius.all(Radius.circular(15)),
  ),
  child:TextFormField(
    controller:controller,
    decoration:InputDecoration(
      labelText: text,
      prefixIcon: Icon(prefixIcon),
    ),
  ),
);

Widget defaultTextButtom({
  required Function() function,
  required String text,
  required Color color,
}) =>
    TextButton(onPressed: function,
        child: Text(text,
      style: TextStyle(
      color: color,
    ),));

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0,
    );

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}


