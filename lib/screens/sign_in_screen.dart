import 'package:dsr_admin/utils/Common.dart';
import 'package:flutter/material.dart';
import '../component/custom_button.dart';
import '../component/custom_text_field.dart';
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

  submit() {
    appStore.setLoading(true);
    if (formKey.currentState!.validate()) {
      hideKeyboard(context);

      authService.signInWithEmailPassword(context, email: emailController.text.trim(), password: passController.text.trim()).then((value) async {
        //  toast(res.message, print: true);

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
              getWelcomeTitle(),
              getPhoneNumberTextFormField(),
              SizedBox(height: 20),
              getLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getWelcomeTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(ic_app_logo, height: 150, width: 150),
        SizedBox(height: 20),
        Text("Welcome to BSR", style: appTheme.boldTextStyle()),
        SizedBox(height: 8),
        Text('Sign in to continue with your credentials'),
        SizedBox(height: 24),
      ],
    );
  }

  Widget getLoginTitle() {
    return Text("Login", style: appTheme.primaryTextStyle());
  }

  Widget getPhoneNumberTextFormField() {
    return Column(
      children: [
        CustomTextFormField(
          hintText: "Email",
          labelText: "Email",
          radius: 8,
          controller: emailController,
          focusNode: emailFocus,
          contentPadding: EdgeInsets.all(8),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          maxLength: 10,
          counterText: "",
        ),
        SizedBox(height: 8),
        CustomTextFormField(
          hintText: "Password",
          labelText: "Email",
          radius: 8,
          controller: passController,
          focusNode: passFocus,
          contentPadding: EdgeInsets.all(8),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          maxLength: 10,
          counterText: "",
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget getLoginButton() {
    return CustomButton(
      onButtonClick: () async {
        submit();
      },
      height: 50,
      buttonText: "Submit",
      buttonTextStyle: appTheme.boldTextStyle(),
    );
  }
}
