import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social/social_layout/cubit/cubit.dart';
import 'package:social/social_layout/cubit/states.dart';
import 'package:social/style/custome_color.dart';
import '../layout_screen/new_post/screen/post_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewPostScreen()),);
          }
      },
      builder: (context, state) {
        var cubit= SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  Text(
              cubit.titles[cubit.currentIndex] ,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                onPressed:(){} ,
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed:(){} ,
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.green,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeButtomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: FaIcon(
                    // ignore: deprecated_member_use
                    FontAwesomeIcons.home,
                    color: defaultColor,
                  ),
                label: 'Home',

              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble,
                    color: defaultColor,
                  ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.upload,
                    color: defaultColor,
                  ),
                label: 'post',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: defaultColor,
                  ),
                label: 'User',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                    color: defaultColor,
                  ),
                label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
