import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:zigzag_app_flutter/models/social_model.dart';
import 'package:zigzag_app_flutter/shared/constants/constants.dart';
import 'package:zigzag_app_flutter/shared/network/local/cache_helper.dart';

part 'social_register_states.dart';

class SocialRegitsterCubit extends Cubit<SocialRegisterStates> {
  SocialRegitsterCubit() : super(SocialRegitsterInitialState());

  static SocialRegitsterCubit get(context) => BlocProvider.of(context);

  SocialUserModel? registerModel;

  void userRegister(@required String email, @required String name,
      @required String phone, @required String password) {
    emit(SocialRegitsterInitialState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      //userCreate(email, name, phone, value.user!.uid);
      userCreate(email, name, phone, value.user!.uid);
      uId = value.user!.uid;
      CacheHelper.saveData('uId', value.user!.uid);
      //emit(SocialRegitsterSuccessState());
    }).catchError((error) {
      emit(SocialRegitsterErrorState());
    });
  }

  void userCreate(@required String email, @required String name,
      @required String phone, @required String uId,
      {String bio = 'bio ...',
      String image =
          'https://image.freepik.com/free-photo/covid-19-healthcare-workers-pandemic-preventing-virus-concept-serious-determined-doctor-working-with-coronavirus-patients-wearing-protective-personal-equipment-medical-mask-gloves_1258-58624.jpg',
      String cover = ''}) {
    SocialUserModel model = SocialUserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        isVerifiedEmail: false,
        image: image,
        bio: bio,
        cover: cover);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState());
    });
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
