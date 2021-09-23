import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zigzag_app_flutter/modules/social_app/cubit/social_cubit.dart';
import 'package:zigzag_app_flutter/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var model = SocialCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            actions: [
              defaultTextButton(() {}, 'Update'),
              SizedBox(
                width: 15.0,
              )
            ],
            title: Text('Edit profile'),
            titleSpacing: 0.0,
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                                      image: NetworkImage('${model!.image}'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              IconButton(
                                  onPressed: () {},
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
                                backgroundImage: NetworkImage('${model.cover}'),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
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
                  height: 5.0,
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
                    bioController,
                    'Bio',
                    Icons.info,
                    null,
                    false,
                    TextInputType.name,
                    true,
                    (value) {},
                    () {},
                    (value) {},
                    () {},
                    () {})
              ],
            ),
          ),
        );
      },
    );
  }
}
