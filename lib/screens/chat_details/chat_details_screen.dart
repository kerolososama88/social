import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/model/user_model.dart';
import 'package:social/screens/chat_details/widget/build_message.dart';
import 'package:social/screens/chat_details/widget/build_my_message.dart';
import 'package:social/social_layout/cubit/cubit.dart';
import 'package:social/social_layout/cubit/states.dart';
import 'package:social/style/custome_color.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatefulWidget {
  UserModel? userModel;

  ChatDetailsScreen({
    super.key,
    this.userModel,
  });

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var textControllr = TextEditingController();

  @override
  void initState() {
    SocialCubit.get(context).getUserData().then((value) {
      SocialCubit.get(context).getMessages(widget.userModel!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(widget.userModel!.image!),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.userModel!.name!,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
            leading: const BackButton(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var message =
                      SocialCubit.get(context).message[index];
                      if (SocialCubit.get(context).userModel!.uId ==
                          message.senderId) {
                        return buildMyMessage(message);
                      } else {
                        buildMessage(message);
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15.0,
                    ),
                    itemCount: SocialCubit.get(context).message.length,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textControllr,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'type your message here...',
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        color: defaultColor,
                        child: MaterialButton(
                          onPressed: () {
                            SocialCubit.get(context).sendMessage(
                              receiverId: widget.userModel!.uId!,
                              text: textControllr.text,
                              dataTime: DateTime.now.toString(),
                            );
                          },
                          minWidth: 1,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }




}
