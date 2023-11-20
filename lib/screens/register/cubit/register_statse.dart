
abstract class RegisterState{}

class RegisterInitalState extends RegisterState{}

class RegisterLoadinglState extends RegisterState{}

class RegisterSuccessState extends RegisterState{
  // final ShopLoginModel shopLoginModel;
  //
  // RegisterSuccessState(this.shopLoginModel);
}

class RegisterErrorState extends RegisterState{
  final String error;

  RegisterErrorState(this.error);
}

class RegisterCreateUserSuccessState extends RegisterState{}

class RegisterCreateUserErrorState extends RegisterState{
  final String error;

  RegisterCreateUserErrorState(this.error);
}


class RegisterChangePasswordVisibilityState extends RegisterState{}