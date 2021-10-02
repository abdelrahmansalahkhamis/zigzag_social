import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zigzag_app_flutter/modules/social_app/cubit/social_cubit.dart';
import 'package:zigzag_app_flutter/shared/components/components.dart';
import 'package:zigzag_app_flutter/shared/styles/colors.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
            actions: [
              defaultTextButton(() {
                var now = DateTime.now();
                if (SocialCubit.get(context).postImage == null) {
                  SocialCubit.get(context)
                      .createPost(now.toString(), textController.text);
                } else {
                  SocialCubit.get(context)
                      .uploadPostImage(now.toString(), textController.text);
                }
              }, 'Post')
            ],
            //backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 20.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      // backgroundImage: NetworkImage(
                      //     'https://image.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg'),
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Text(
                        '${SocialCubit.get(context).userModel!.name}',
                        style: TextStyle(height: 1.3),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind ....',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                          height: 160.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              //image: NetworkImage('${model!.image}'),
                              image: FileImage(
                                  SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            ),
                          )),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                              radius: 20.0,
                              child: Icon(
                                Icons.close,
                                size: 16.0,
                              )))
                    ],
                  ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('add photo')
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('# tags')],
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
