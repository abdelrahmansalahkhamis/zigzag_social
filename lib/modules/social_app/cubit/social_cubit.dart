import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:zigzag_app_flutter/layout/social_app/chats/chat_screen.dart';
import 'package:zigzag_app_flutter/layout/social_app/feed/feeds_screen.dart';
import 'package:zigzag_app_flutter/layout/social_app/new_post/new_post_screen.dart';
import 'package:zigzag_app_flutter/layout/social_app/settings/settings_screen.dart';
import 'package:zigzag_app_flutter/layout/social_app/users/users_screen.dart';
import 'package:zigzag_app_flutter/models/social_model.dart';
import 'package:zigzag_app_flutter/shared/constants/constants.dart';
import 'package:zigzag_app_flutter/shared/network/local/cache_helper.dart';

part 'social_states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? model;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData('uId'))
        .get()
        .then((value) {
      print(value.data());
      model = SocialUserModel.fromJson(value.data()!);
      print('model is : => ${model}');
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titles = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNav());
    }
  }
}
