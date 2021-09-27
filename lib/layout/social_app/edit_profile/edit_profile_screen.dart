import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zigzag_app_flutter/modules/social_app/cubit/social_cubit.dart';
import 'package:zigzag_app_flutter/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;

        var coverImage = SocialCubit.get(context).coverImage;

        // nameController.text = model!.name;
        // bioController.text = model!.bio;
        // phoneController.text = model!.phone;

        return Scaffold(
          appBar: AppBar(
            actions: [
              defaultTextButton(() {
                SocialCubit.get(context).updateUser(nameController.text,
                    phoneController.text, bioController.text);
              }, 'Update'),
              SizedBox(
                width: 15.0,
              )
            ],
            title: Text('Edit profile'),
            titleSpacing: 0.0,
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 190.0,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                    height: 160.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0)),
                                      image: DecorationImage(
                                        //image: NetworkImage('${model!.image}'),
                                        image: coverImage == null
                                            ? NetworkImage('${model!.cover}')
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: CircleAvatar(
                                        radius: 20.0,
                                        child: Icon(
                                          Icons.camera,
                                          size: 16.0,
                                        )))
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  //backgroundImage: NetworkImage('${model.cover}'),
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${model!.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        Icons.camera,
                                        size: 16.0,
                                      )))
                            ],
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(Colors.blue, () {
                                SocialCubit.get(context).uploadProfileImage(
                                    nameController.text,
                                    phoneController.text,
                                    bioController.text);
                              }, 'upload profile', 1.0, true, double.infinity,
                                  40),
                              if (state is SocialUserUpdateLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator()
                            ],
                          )),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(Colors.blue, () {
                                SocialCubit.get(context).uploadCoverImage(
                                    nameController.text,
                                    phoneController.text,
                                    bioController.text);
                              }, 'upload cover', 1.0, true, double.infinity,
                                  40),
                              if (state is SocialUserUpdateLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator()
                            ],
                          ))
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  defaultTextFormField(
                      nameController,
                      'name',
                      Icons.person,
                      null,
                      false,
                      TextInputType.name,
                      true,
                      (value) {},
                      () {},
                      (value) {},
                      () {},
                      () {}),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                      phoneController,
                      'Phone',
                      Icons.info,
                      null,
                      false,
                      TextInputType.name,
                      true,
                      (value) {},
                      () {},
                      (value) {},
                      () {},
                      () {}),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                      bioController,
                      'Bio',
                      Icons.info,
                      null,
                      false,
                      TextInputType.text,
                      true,
                      (value) {},
                      () {},
                      (value) {},
                      () {},
                      () {})
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
