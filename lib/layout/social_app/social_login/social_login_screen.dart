import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zigzag_app_flutter/layout/social_app/social_login/cubit/social_login_cubit.dart';
import 'package:zigzag_app_flutter/layout/social_app/social_register/social_register_screen.dart';
import 'package:zigzag_app_flutter/modules/social_app/social_layout.dart';
import 'package:zigzag_app_flutter/shared/components/components.dart';
import 'package:zigzag_app_flutter/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SocialLoginSuccessState) {
            print('state of state.loginModel.status is $state');
            CacheHelper.saveData('uId', state.uId).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
            //showToast(state.loginModel.message, ToastState.SUCCESS);
          } else {
            print('state of state.loginModel.status.false is $state');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        Text('LOGIN now to browse our social app',
                            style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                            emailController,
                            'Email Address',
                            Icons.email_outlined,
                            null,
                            false,
                            TextInputType.emailAddress,
                            true, (value) {
                          if (value!.isEmpty) {
                            return 'email cannot be empty';
                          }
                        }, () {}, (value) {}, () {}, () {}),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                            passwordController,
                            'password',
                            Icons.lock,
                            SocialLoginCubit.get(context).suffix,
                            //Icons.visibility_outlined,
                            SocialLoginCubit.get(context).isPassword,
                            //true,
                            TextInputType.emailAddress,
                            true,
                            (value) {
                              if (value!.isEmpty) {
                                return 'password cannot be empty';
                              }
                            },
                            () {},
                            (value) {},
                            () {},
                            () {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        // state is ShopLoginLoadingState() ? defaultButton(Colors.blue, () {}, 'login', 10.0) : Center(
                        //   child: CircularProgressIndicator(),
                        // ),
                        defaultButton(Colors.blue, () {
                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                                emailController.text, passwordController.text);
                          }
                        }, 'login', 10.0, true, double.infinity, 40.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dont\'t have an account? '),
                            defaultTextButton(() {
                              navigateTo(context, SocialRegisterScreen());
                            }, 'Register')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
