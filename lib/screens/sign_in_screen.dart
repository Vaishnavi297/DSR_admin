import 'package:dsr_admin/screens/dashboard_screen.dart';
import 'package:dsr_admin/screens/sign_up_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/Common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  ///region UI Widget
  Widget welcomeTitleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        60.height,
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField(
            controller: emailController,
            decoration: inputDecoration(context, hintText: 'Enter your email', labelText: 'Email Address'),
            nextFocus: passFocus,
            textFieldType: TextFieldType.EMAIL,
            errorThisFieldRequired: 'This field is required',
            autoFillHints: [AutofillHints.email],
          ),
          24.height,
          AppTextField(
            controller: passController,
            textFieldType: TextFieldType.PASSWORD,
            textInputAction: TextInputAction.done,
            focus: passFocus,
            isValidationRequired: true,
            errorThisFieldRequired: 'This field is required',
            autoFillHints: [AutofillHints.password],
            decoration: inputDecoration(context, hintText: 'Enter your password', labelText: 'Password'),
            onFieldSubmitted: (s) {
              onSubmit();
            },
          ),
        ],
      ),
    );
  }

  /// endregion

  /// region Login Tapped
  onSubmit() {
    appStore.setLoading(true);
    if (formKey.currentState!.validate()) {
      hideKeyboard(context);

      authService.signInWithEmail(emailController.text.trim(), passController.text.trim()).then((value) async {
        toast('Login Successfully', print: true);
        DashboardScreen().launch(context, isNewTask: true);
        appStore.setLoading(false);
      }).catchError((e) {
        log(e.toString());
        appStore.setLoading(false);
      });
    }
  }

  /// endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, context.statusBarHeight + 16, 16, 16),
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
                  width: context.width() - context.navigationBarHeight,
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
          Observer(builder: (context) => Loader().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
