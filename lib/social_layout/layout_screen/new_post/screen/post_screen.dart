import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/social_layout/cubit/cubit.dart';
import 'package:social/social_layout/cubit/states.dart';
import 'package:social/style/custome_color.dart';

// ignore: must_be_immutable
class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit(SocialInitialState())..getUserData(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Create Post',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
              leading:  const BackButton(
                color: Colors.black,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final now = DateTime.now();
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost(
                        text: textController.text,
                        dataTime: now.toString(),

                      );
                    } else {
                      SocialCubit.get(context).uploadPostImage(
                        text: textController.text,
                        dataTime: now.toString(),
                      );
                    }
                  },
                  child: const Text(
                    'POST',
                    style: TextStyle(
                      color: defaultColor,
                    ),
                  ),
                ),
              ],
            ),
            body:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/cheerful-curly-business-girl-wearing-glasses_176420-206.jpg?w=1380&t=st=1695597335~exp=1695597935~hmac=e9f5b7f4cc8196be60e9321bcd7ccb7e1aad7a831358c47d96300a36038a565a'
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kirolos Osama',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'public',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'what is on your mind...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).postImage !=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            image:FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        alignment: AlignmentDirectional.topEnd,
                          onPressed: (){
                          SocialCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 35,
                              color: defaultColor,
                            ),
                          )
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: defaultColor,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                  'add photo',
                                style: TextStyle(
                                  color: defaultColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            '# tags',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
