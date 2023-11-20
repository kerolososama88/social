import 'package:flutter/material.dart';

import '../../../../model/user_model.dart';
import '../../../../screens/chat_details/chat_details_screen.dart';

Widget buildChatItem(index, UserModel model, context) => InkWell(
  onTap: () {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatDetailsScreen(
              userModel: model,
            )));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
            model.image!,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          model.name!,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  ),
);