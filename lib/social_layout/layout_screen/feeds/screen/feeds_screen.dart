import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/social_layout/cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../widget/build_Post_Item.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit(SocialInitialState())
        ..getUserData()
        ..getPosts(),
      child: BlocBuilder<SocialCubit, SocialStates>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialCubit.get(context).posts.isNotEmpty &&
                SocialCubit.get(context).userModel != null,
            builder: (BuildContext context) => Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://img.freepik.com/premium-vector/hand-drawn-people-working-together-illustration_52683-76157.jpg?w=1380',
                            fit: BoxFit.cover,
                            height: 200.0,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                          SocialCubit.get(context).posts[index],
                          context,
                          index),
                      itemCount: SocialCubit.get(context).posts.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
