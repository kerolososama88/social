import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/model/user_model.dart';
import 'package:social/screens/register/cubit/register_statse.dart';

import '../../../social_layout/home_screen/layout_screen.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(super.initialState);

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadinglState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        context: context,
        email: email,
        uId: value.user!.uid,
        name: name,
        phone: phone,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required BuildContext context,
    required String email,
    required String uId,
    required String name,
    required String phone,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      bio: 'write you bio...',
      image:
          'https://img.freepik.com/free-photo/cheerful-curly-business-girl-wearing-glasses_176420-206.jpg?w=1380&t=st=1695643430~exp=1695644030~hmac=26be31f6d3295ac276f08c4e4debd0a030a49da95d57674871c5720eb599ade9',
      cover:
          'https://img.freepik.com/free-photo/cheerful-curly-business-girl-wearing-glasses_176420-206.jpg?w=1380&t=st=1695643430~exp=1695644030~hmac=26be31f6d3295ac276f08c4e4debd0a030a49da95d57674871c5720eb599ade9',
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }

  Icon suffix = const Icon(Icons.visibility);
  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(RegisterChangePasswordVisibilityState());
  }

  Widget suffixWidget() {
    return isPassword
        ? IconButton(
            icon: const Icon(Icons.visibility_off),
            onPressed: () => changePasswordVisibility(),
          )
        : IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () => changePasswordVisibility(),
          );
  }
}
