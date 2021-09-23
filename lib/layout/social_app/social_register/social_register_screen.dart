import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zigzag_app_flutter/layout/social_app/social_login/social_login_screen.dart';
import 'package:zigzag_app_flutter/layout/social_app/social_register/cubit/social_register_cubit.dart';
import 'package:zigzag_app_flutter/modules/social_app/social_layout.dart';
import 'package:zigzag_app_flutter/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegitsterCubit(),
      child: BlocConsumer<SocialRegitsterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
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
                          'Register',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        Text('Register now to browse our hot efforts',
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
                            nameController,
                            'name',
                            Icons.email_outlined,
                            null,
                            false,
                            TextInputType.name,
                            true, (value) {
                          if (value!.isEmpty) {
                            return 'name cannot be empty';
                          }
                        }, () {}, (value) {}, () {}, () {}),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                            phoneController,
                            'phone',
                            Icons.email_outlined,
                            null,
                            false,
                            TextInputType.phone,
                            true, (value) {
                          if (value!.isEmpty) {
                            return 'phone cannot be empty';
                          }
                        }, () {}, (value) {}, () {}, () {}),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                            passwordController,
                            'password',
                            Icons.lock,
                            SocialRegitsterCubit.get(context).suffix,
                            //Icons.visibility_outlined,
                            //ShopLoginCubit.get(context).isPassword,
                            SocialRegitsterCubit.get(context).isPassword,
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
                              SocialRegitsterCubit.get(context)
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
                            SocialRegitsterCubit.get(context).userRegister(
                                emailController.text,
                                nameController.text,
                                phoneController.text,
                                passwordController.text);
                          }
                        }, 'register', 10.0, true, double.infinity, 40.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account? '),
                            defaultTextButton(() {
                              navigateTo(context, SocialLoginScreen());
                            }, 'Login')
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
