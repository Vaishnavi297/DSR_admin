import 'package:dsr_admin/screens/sign_up_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/Common.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import '../services/AuthServices.dart';
import '../utils/Images.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthService authService = AuthService();

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode passFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  Widget welcomeTitleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(ic_app_logo, height: 150, width: 150, fit: BoxFit.cover),
        20.height,
        Text("Welcome to BSR", style: boldTextStyle(size: 24)),
        8.height,
        Text('Sign in to continue with your credentials', style: secondaryTextStyle()),
        28.height,
      ],
    );
  }

  Widget formWidget() {
    return Column(
      children: [
        AppTextField(
          controller: emailController,
          decoration: inputDecoration(context, labelText: 'Enter your email'),
          nextFocus: passFocus,
          textFieldType: TextFieldType.EMAIL,
        ),
        24.height,
        AppTextField(
          controller: passController,
          textFieldType: TextFieldType.PASSWORD,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          focus: passFocus,
          maxLength: 10,
          isValidationRequired: true,
          decoration: inputDecoration(context, labelText: 'Enter your password'),
          onFieldSubmitted: (s) {
            onSubmit();
          },
        ),
      ],
    );
  }

  /// region Login Tapped
  onSubmit() {
    appStore.setLoading(true);
    if (formKey.currentState!.validate()) {
      hideKeyboard(context);

      authService.signInWithEmailPassword(context, email: emailController.text.trim(), password: passController.text.trim()).then((value) async {
        toast('Login Successfully', print: true);
        // final SnackBar snackBar = SnackBar(
        //   content: Text(value),
        //   action: SnackBarAction(
        //     label: 'Undo',
        //     onPressed: () {},
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // DocumentSubmitScreen().launch(context, isNewTask: true);
        appStore.setLoading(false);
      }).catchError((e) {
        appStore.setLoading(false);
      });
    }
  }
  /// endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              welcomeTitleWidget(),
              formWidget(),
              24.height,
              AppButton(
                onTap: () async {
                  onSubmit();
                },
                height: 50,
                width: context.width(),
                text: "Sign In",
                color: primaryColor,
                textStyle: boldTextStyle(color: white),
              ),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have an account?", style: secondaryTextStyle()),
                  TextButton(
                    onPressed: () {
                      hideKeyboard(context);
                      SignUpScreen().launch(context);
                    },
                    child: Text(
                      'Sign Up',
                      style: boldTextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
