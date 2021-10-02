import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:zigzag_app_flutter/layout/social_app/chats/chat_screen.dart';
import 'package:zigzag_app_flutter/layout/social_app/feed/feeds_screen.dart';
import 'package:zigzag_app_flutter/layout/social_app/new_post/new_post_screen.dart';
import 'package:zigzag_app_flutter/layout/social_app/settings/settings_screen.dart';
import 'package:zigzag_app_flutter/layout/social_app/users/users_screen.dart';
import 'package:zigzag_app_flutter/models/messageModel.dart';
import 'package:zigzag_app_flutter/models/post_model.dart';
import 'package:zigzag_app_flutter/models/social_model.dart';
import 'package:zigzag_app_flutter/shared/constants/constants.dart';
import 'package:zigzag_app_flutter/shared/network/local/cache_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'social_states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData('uId'))
        .get()
        .then((value) {
      print('value.data() is ${value.data()}');
      userModel = SocialUserModel.fromJson(value.data()!);
      print('model is : => ${userModel!.name}');
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
    if (index == 1) {
      getUsers();
    }
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNav());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadProfileImage(
    @required String name,
    @required String phone,
    @required String bio,
  ) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImagePickedSuccessState());
        print(value);
        updateUser(name, phone, bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImagePickedErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImagePickedErrorState());
    });
  }

  void uploadCoverImage(
    @required String name,
    @required String phone,
    @required String bio,
  ) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImagePickedSuccessState());
        print(value);
        updateUser(name, phone, bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImagePickedErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImagePickedErrorState());
    });
  }

  // void updateUserImages(
  //   @required String name,
  //   @required String phone,
  //   @required String bio,
  // ) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (profileImage != null && coverImage != null) {
  //   } else {
  //     updateUser(name, phone, bio);
  //   }
  // }

  void updateUser(
      @required String name, @required String phone, @required String bio,
      {String? cover, String? image}) {
    SocialUserModel model = SocialUserModel(
        userModel!.email,
        name,
        phone,
        userModel!.uId,
        image ?? userModel!.image,
        cover ?? userModel!.cover,
        bio,
        false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {})
        .catchError((error) {
      print('error is: -> ${error.toString()}');
      emit(SocialUserUpdateErrorState());
    });
    getUserData();
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage(
    @required String dateTime,
    @required String text,
  ) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(dateTime, text, postimage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost(@required String dateTime, @required String text,
      {String? postimage}) {
    PostModel model = PostModel(userModel!.name, text, uId, userModel!.image,
        dateTime, postimage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print('error is: -> ${error.toString()}');
      emit(SocialCreatePostErrorState());
    });
    getUserData();
  }

  List<PostModel> posts = [];
  List<String> postsIds = [];
  List<int> likes = [];
  Future<void> getPosts() async {
    await FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          print('value.docs.length is: -> ${value.docs.length}');
          print('element.id is: -> ${element.id}');
          likes.add(value.docs.length);
          postsIds.add(element.id);
          posts.add(PostModel.fromJson((element.data())));
        }).catchError((error) {});
      });

      // value.docs.forEach((element) {
      //   postsIds.add(element.id);
      //   posts.add(PostModel.fromJson((element.data())));
      // });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });
        print('model is : => ${userModel}');
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error));
      });
    }
  }

  void sendMessage(String text, String dateTime, String receiverId) {
    MessageModel model =
        MessageModel(userModel!.uId, receiverId, dateTime, text);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
      sendButtonEnabled = false;
    }).catchError((error) {
      emit(SocialSendMessageerrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageerrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  var sendButtonEnabled = false;

  void changeSendButtonSate() {
    if (sendButtonEnabled) {
      sendButtonEnabled = false;
      emit(SocialMessageTextButtonEnabledState());
    } else {
      sendButtonEnabled = true;
      emit(SocialMessageTextButtonDisabledState());
    }
  }
}
