import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/remote/cache_helper.dart';
import '../../../constans/constans_buttom.dart';
import '../../../social_layout/home_screen/layout_screen.dart';
import '../../../style/custome_color.dart';
import '../../register/screen/register_screen.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var passwordConteroller = TextEditingController();
  var emailConteroller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SociaLoginCubit(SociaLoginInitalState()),
      child: BlocConsumer<SociaLoginCubit, SocialLoginState>(
        listener: (context, state) {
          if (state is SociaLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastState.ERROR,
            );
          }
          if (state is SociaLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        height: 170,
                          width: 200,
                          imageUrl:
                      'https://img.freepik.com/free-vector/sign-page-abstract-concept-illustration_335657-3875.jpg?w=826&t=st=1696429172~exp=1696429772~hmac=c9a1b3afd4f9bc374c153967dbd77d1680cffbea25f048d515d55a5817227fd6'
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'Login now to communicate with friends',
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey,
                                ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailConteroller,
                        decoration: const InputDecoration(
                          label: Text('Email Address'),
                          prefix: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your emil address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordConteroller,
                        obscureText: SociaLoginCubit.get(context).isPassword
                            ? true
                            : false,
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          prefix: const Icon(Icons.lock),
                          suffix: SociaLoginCubit.get(context).suffixWidget(),
                        ),
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            SociaLoginCubit.get(context).userLogin(
                              context: context,
                              email: emailConteroller.text,
                              password: passwordConteroller.text,
                            );
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! SociaLoginLoadinglState,
                        builder: (context) => defaultButtom(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              SociaLoginCubit.get(context).userLogin(
                                context: context,
                                email: emailConteroller.text,
                                password: passwordConteroller.text,
                              );
                            }
                          },
                          color: Colors.white,
                          text: 'LOGIN',
                          background: defaultColor,
                          width: double.infinity,
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Don not have an account?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          defaultTextButtom(
                            function: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                            },
                            text: 'Register',
                            color: defaultColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
