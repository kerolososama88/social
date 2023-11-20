import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../social_layout/home_screen/layout_screen.dart';
import 'login_states.dart';

class SociaLoginCubit extends Cubit<SocialLoginState> {
  SociaLoginCubit(super.initialState);

  static SociaLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    emit(SociaLoginLoadinglState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomeScreen()));
      emit(SociaLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SociaLoginErrorState(error.toString()));
    });

  }

  Icon suffix = const Icon(Icons.visibility);
  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(SociaLoginChangePasswordVisibilityState());
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
