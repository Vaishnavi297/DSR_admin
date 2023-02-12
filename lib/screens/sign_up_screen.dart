import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/services/AuthServices.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/Common.dart';
import 'package:dsr_admin/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthService authService = AuthService();

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode passFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  onSubmit() {
    appStore.setLoading(true);

    if (formKey.currentState!.validate()) {
      hideKeyboard(context);

      authService.signUpWithEmailPassword(context, email: emailController.text.trim(), password: passController.text.trim()).then((value) async {
        toast('Register Successfully', print: true);

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

  Widget getWelcomeTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(ic_app_logo, height: 150, width: 150),
        20.height,
        Text("Welcome to BSR", style: boldTextStyle(size: 24)),
        8.height,
        Text('Sign in to continue with your credentials'),
        28.height,
      ],
    );
  }

  Widget formWidget() {
    return Form(
      key: formKey,
      child: Column(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getWelcomeTitle(),
            formWidget(),
            24.height,
            AppButton(
              onTap: () async {
                toast('Register');
                onSubmit();
              },
              height: 50,
              width: context.width(),
              text: "Submit",
              color: primaryColor,
              textStyle: boldTextStyle(color: white),
            ),
          ],
        ),
      ),
    );
  }
}
