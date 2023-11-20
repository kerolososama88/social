import 'package:flutter/material.dart';

import '../../../model/message_model.dart';

Widget buildMessage(MessageModel model) => Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
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