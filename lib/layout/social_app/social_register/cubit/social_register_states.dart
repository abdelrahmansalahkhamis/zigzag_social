part of 'social_register_cubit.dart';

@immutable
abstract class SocialRegisterStates {}

class SocialRegitsterInitialState extends SocialRegisterStates {}

class SocialRegitsterLoadingState extends SocialRegisterStates {}

class SocialRegitsterSuccessState extends SocialRegisterStates {}

class SocialRegitsterErrorState extends SocialRegisterStates {}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates {}

class ShopChangePasswordVisibilityState extends SocialRegisterStates {}
