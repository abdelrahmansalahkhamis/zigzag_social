import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton(Color background, VoidCallback function, String text,
        double raduis, bool isUpperCased, double width, double height) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCased ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

var passwordVisible = false;

Widget defaultAppBar(
  @required BuildContext context,
  String title,
  List<Widget> actions,
) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_left),
      ),
      title: Text('${title}'),
      actions: actions,
    );
Widget defaultTextFormField(
        @required TextEditingController controller,
        @required String label,
        @required IconData prefix,
        @required IconData? suffix,
        @required bool isPassword,
        @required TextInputType type,
        @required bool isClickable,
        @required String? Function(String? value) validate,
        @required Function onSubmit,
        @required void Function(String? value) onChange,
        @required Function onTap,
        @required VoidCallback suffixPressed) =>
    TextFormField(
      controller: controller,
      validator: validate,
      onChanged: onChange,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit(),
      onTap: onTap(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(icon: Icon(suffix), onPressed: suffixPressed)
            : null,
        // suffixIcon: suffix != null
        //     ? GestureDetector(
        //         child: passwordVisible
        //             ? Icon(Icons.visibility_off)
        //             : Icon(Icons.visibility),
        //         onTap: () {
        //           setState() {
        //             passwordVisible = !passwordVisible;
        //           }

        //           print('pressed');
        //         },
        //       )
        //     : null,
        border: OutlineInputBorder(),
      ),
    );

// Widget buildTaskItem(Map model, context) {
//   return Dismissible(
//     key: Key(model['id'].toString()),
//     child: Padding(
//       padding: EdgeInsets.all(20.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CircleAvatar(
//             radius: 40.0,
//             child: Text('${model['title']}'),
//             backgroundColor: Colors.blue,
//           ),
//           SizedBox(
//             width: 15.0,
//           ),
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   '${model['time']}',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Text(
//                   '${model['date']}',
//                   style: TextStyle(color: Colors.grey),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 15.0,
//           ),
//           IconButton(
//               onPressed: () {
//                 AppCubit.get(context).updateData('done', model['id']);
//               },
//               icon: Icon(
//                 Icons.check_box,
//                 color: Colors.green,
//               )),
//           IconButton(
//               onPressed: () {
//                 AppCubit.get(context).updateData('archived', model['id']);
//               },
//               icon: Icon(
//                 Icons.archive,
//                 color: Colors.black45,
//               )),
//         ],
//       ),
//     ),
//     onDismissed: (direction) {
//       AppCubit.get(context).deleteData(model['id']);
//     },
//   );
// }

//Widget tasksBuilder(List<Map> tasks) =>

// Widget buildArticleItems(article, context, {isSearch = false}) => InkWell(
//       onTap: () {
//         navigateTo(context, WebViewScreen(article['url']));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//           Container(
//             width: 120.0,
//             height: 120.0,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                   10.0,
//                 ),
//                 image: DecorationImage(
//                     image: NetworkImage('${article['urlToImage']}'),
//                     fit: BoxFit.cover)),
//           ),
//           SizedBox(
//             width: 15.0,
//           ),
//           Expanded(
//             child: Container(
//               height: 120.0,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       '${article['title']}',
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                       // style: TextStyle(
//                       //   fontSize: 18.0,
//                       //   fontWeight: FontWeight.w600,
//                       // ),
//                       style: Theme.of(context).textTheme.bodyText1,
//                     ),
//                   ),
//                   Text(
//                     '${article['publishedAt']}',
//                     style: TextStyle(color: Colors.grey),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ]),
//       ),
//     );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultTextButton(VoidCallback function, String text) => TextButton(
    onPressed: function,
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    ));

void showToast(String text, ToastState state) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
