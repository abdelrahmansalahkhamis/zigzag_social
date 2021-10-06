import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zigzag_app_flutter/modules/social_app/cubit/social_cubit.dart';
import 'package:zigzag_app_flutter/shared/components/components.dart';
import 'package:zigzag_app_flutter/shared/constants/constants.dart';

import 'layout/social_app/social_login/social_login_screen.dart';
import 'layout/social_app/social_register/social_register_screen.dart';
import 'modules/social_app/social_layout.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // // If you're going to use other Firebase services in the background, such as Firestore,
  // // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  // print("Handling a background message: ${message.messageId}");
  print(message.data.toString());
  print(message.notification);
  print('Background');
  showToast('Background notif', ToastState.SUCCESS);
}

//final FirebaseMessaging _fcm = FirebaseMessaging();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print('device token :-');

  // _fcm.getToken().then((token) {
  //   print('the token is : ' + token!);
  // });

  print('${token}');

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    print(event.notification);
    print('onMessage');
    showToast('onMessage notif', ToastState.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    print(event.notification);
    print('onMessageOpenedApp');
    showToast('onMessageOpenedApp notif', ToastState.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  // bool? isDark = CacheHelper.getData('isDark');
  // bool? onBoarding = CacheHelper.getData('onBoarding');
  // String? token = CacheHelper.getData('token');
  try {
    uId = CacheHelper.getData('uId');
    print('CacheHelper.getData(id) is : ${uId}');
  } catch (error) {
    print('error.toString() is ${error.toString()}');
  }
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget? widget;

  MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getPosts())
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            //home: const MyHomePage(title: 'Flutter Demo Home Page'),
            home: widget,
          );
        },
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
