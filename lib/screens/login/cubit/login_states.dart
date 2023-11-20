
abstract class SocialLoginState{}

class SociaLoginInitalState extends SocialLoginState{}

class SociaLoginLoadinglState extends SocialLoginState{}

class SociaLoginSuccessState extends SocialLoginState{
  final String uId;

  SociaLoginSuccessState(this.uId);
}
class SociaLoginErrorState extends SocialLoginState{
  final String error;

  SociaLoginErrorState(this.error);
}

class SociaLoginChangePasswordVisibilityState extends SocialLoginState{}