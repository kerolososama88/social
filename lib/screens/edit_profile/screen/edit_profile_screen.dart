import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social/constans/constans_buttom.dart';
import 'package:social/social_layout/cubit/cubit.dart';
import 'package:social/social_layout/cubit/states.dart';
import 'package:social/style/custome_color.dart';

import '../../../constans/componant.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  var namedController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit(SocialInitialState())..getUserData(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialGetUserSuccessState) {
            var userModel = SocialCubit.get(context).userModel;
            namedController.text = userModel!.name ?? '';
            bioController.text = userModel.bio ?? '';
            phoneController.text = userModel.phone ?? '';
          }
        },
        builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: const BackButton(
                color: Colors.black,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUser(
                      name: namedController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(
                      color: defaultColor,
                    ),
                  ),
                )
              ],
            ),
            body: state is SocialGetUserLoadingState
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250.0,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Stack(
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
                                            // ignore: unnecessary_null_comparison
                                            image: (coverImage == null)
                                                ? NetworkImage(
                                                    userModel!.cover ?? '',
                                                  )
                                                : FileImage(File(coverImage.path))
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context)
                                              .getCoverImage();
                                        },
                                        icon: const CircleAvatar(
                                          radius: 20.0,
                                          child: FaIcon(
                                            FontAwesomeIcons.camera,
                                            size: 16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    CircleAvatar(
                                      radius: 63.0,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: CircleAvatar(
                                        radius: 60.0,
                                        //ignore: unnecessary_null_comparison
                                        backgroundImage: (profileImage == null)
                                            ? NetworkImage(userModel!.image ?? '')
                                            : FileImage(File(profileImage.path))
                                                as ImageProvider,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .getProfileImage();
                                      },
                                      icon: const CircleAvatar(
                                        radius: 20.0,
                                        child: FaIcon(
                                          FontAwesomeIcons.camera,
                                          size: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          if(SocialCubit.get(context).profileImage !=null||SocialCubit.get(context).coverImage !=null)
                          Row(
                            children: [
                              if(SocialCubit.get(context).profileImage !=null)
                              Expanded(
                                child: defaultButtom(
                                    function: (){
                                      SocialCubit.get(context).uploadImageProfile(
                                          name: namedController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text,
                                      );
                                    },
                                    color:Colors.white,
                                    text:'UPLOAD PROFILE',
                                    background:defaultColor,
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              if(SocialCubit.get(context).coverImage !=null)
                              Expanded(
                                child: defaultButtom(
                                  function: (){
                                    SocialCubit.get(context).uploadImageCover(
                                      name: namedController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  color:Colors.white,
                                  text:'UPLOAD COVER',
                                  background:defaultColor,
                                ),
                              ),
                            ],
                          ),
                          if(SocialCubit.get(context).profileImage !=null||SocialCubit.get(context).coverImage !=null)
                          const SizedBox(
                            height: 20.0,
                          ),
                          Column(
                            children: [
                              defaultFormField(
                                controller: namedController,
                                text: 'Name',
                                color: Colors.black,
                                prefixIcon: Icons.person,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "name must not be empty";
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          defaultFormField(
                            controller: bioController,
                            text: 'Bio',
                            color: Colors.black,
                            prefixIcon: Icons.info_outlined,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "bio must not be empty";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            text: 'phone',
                            color: Colors.black,
                            prefixIcon: Icons.info_outlined,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "bio must not be empty";
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: defaultButtom(
                              function: (){
                                singOut(context);
                              },
                              color: Colors.white,
                              text: 'SingOut',
                              width:120,
                              background: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
          );
        },
      ),
    );
  }
}
