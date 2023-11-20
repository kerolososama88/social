import 'package:flutter/material.dart';
import 'package:social/model/message_model.dart';

import '../../../style/custome_color.dart';

Widget buildMyMessage(MessageModel model) => Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
    decoration: BoxDecoration(
        color: defaultColor.withOpacity(.2),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
        )),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Text(
        model.text!,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  ),
);