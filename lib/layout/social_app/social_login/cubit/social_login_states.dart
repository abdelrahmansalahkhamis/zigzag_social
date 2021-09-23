part of 'social_login_cubit.dart';

@immutable
abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {}

class ShopChangePasswordVisibilityState extends SocialLoginStates {}
