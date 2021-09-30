import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zigzag_app_flutter/models/social_model.dart';
import 'package:zigzag_app_flutter/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:zigzag_app_flutter/modules/social_app/cubit/social_cubit.dart';
import 'package:zigzag_app_flutter/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (SocialCubit.get(context).users.length > 0) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(SocialCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsetsDirectional.only(start: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
              itemCount: SocialCubit.get(context).users.length);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ChatDetailsScreen(model));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              '${model.name}',
              style: TextStyle(height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
