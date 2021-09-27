import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zigzag_app_flutter/layout/social_app/new_post/new_post_screen.dart';
import 'package:zigzag_app_flutter/shared/components/components.dart';

import 'cubit/social_cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      // TODO: implement listener
      if (state is SocialNewPostState) {
        navigateTo(context, NewPostScreen());
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context);
      return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search))
            ],
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Colors.blue,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Colors.red,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow))),
            child: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.upload_sharp), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_city), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.verified_user_sharp), label: 'Settings')
              ],
            ),
          ));
    });
  }

  Widget buildWidgetData(context, model) {
    var model = SocialCubit.get(context).userModel;
    return Column(
      children: [
        if (!FirebaseAuth.instance.currentUser!.emailVerified)
          Container(
            color: Colors.amber.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(child: Text('please verify your email')),
                  SizedBox(
                    width: 20.0,
                  ),
                  // defaultButton(Colors.blue, () {}, 'verify your email', 10.0,
                  //     true, 240.0)
                  defaultTextButton(() {
                    FirebaseAuth.instance.currentUser!
                        .sendEmailVerification()
                        .then((value) {
                      showToast('check your mail', ToastState.SUCCESS);
                    }).catchError((error) {});
                  }, 'SEND')
                ],
              ),
            ),
          )
      ],
    );
  }
}
