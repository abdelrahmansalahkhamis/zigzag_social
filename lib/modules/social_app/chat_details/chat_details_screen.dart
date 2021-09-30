import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zigzag_app_flutter/models/social_model.dart';
import 'package:zigzag_app_flutter/modules/social_app/cubit/social_cubit.dart';
import 'package:zigzag_app_flutter/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;
  ChatDetailsScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage('${userModel.image}'),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text('${userModel.name}')
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                buildMessage(),
                SizedBox(height: 10.0),
                buildMyMessage(),
                Spacer(),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, width: 1.0),
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'type your message here ...'),
                      )),
                      Container(
                        height: 50.0,
                        color: defaultColor,
                        child: MaterialButton(
                          onPressed: () {
                            SocialCubit.get(context).sendMessage(
                                messageController.text,
                                DateTime.now().toString(),
                                '${userModel.uId}');
                          },
                          minWidth: 1.0,
                          child: Icon(
                            Icons.send,
                            size: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMessage() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text('hello world'),
        ),
      );

  Widget buildMyMessage() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text('hello world'),
        ),
      );
}
