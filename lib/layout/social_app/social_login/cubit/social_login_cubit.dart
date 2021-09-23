import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:zigzag_app_flutter/models/social_model.dart';

part 'social_login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  SocialUserModel? socialModel;

  void userLogin(@required String email, @required String password) {
    // emit(ShopLoginLoadingState());
    // DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
    //     .then((value) {
    //   print('login operation is : $value');
    //   print('value.data is ${value.data}');
    //   print('loginModel 1 is is is $loginModel');
    //   loginModel = ShopLoginModel.fromJson(value.data);
    //   print('loginModel 2 is is is $loginModel');
    //   print(loginModel!.status);
    //   print('-----------');
    //   print(loginModel!.message);
    //   print('-----------');
    //   print(loginModel!.data);
    //   emit(ShopLoginSuccessState(loginModel!));
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(ShopLoginErrorState(error));
    // });

    emit(SocialLoginLoadingState());
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        emit(SocialLoginSuccessState(value.user!.uid));
      }).catchError((error) {
        emit(SocialLoginErrorState());
      });
    } catch (error) {
      print(error.toString());
    }
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changePasswordVisibility() {
    //suffix = Icons.visibility_off_outlined;
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}
