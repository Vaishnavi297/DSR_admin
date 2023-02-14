import 'package:country_picker/country_picker.dart';
import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/UserModel.dart';
import 'package:dsr_admin/services/AuthServices.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/Common.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:dsr_admin/utils/Images.dart';
import 'package:dsr_admin/utils/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import 'dashboard_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  Country selectedCountry = defaultCountry();

  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController mobileNumberCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileNumberFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  //region New Logic
  String buildMobileNumber() {
    return '${selectedCountry.phoneCode}-${mobileNumberCont.text.trim()}';
  }

  ///endregion

  ///region SignUp Tapped
  onSubmit() {
    appStore.setLoading(true);

    if (formKey.currentState!.validate()) {
      hideKeyboard(context);
      UserModel userData = UserModel()
        ..fullName = "${firstNameCont.text.validate()} ${lastNameCont.text.validate()}"
        ..mobileNumber = buildMobileNumber()
        ..email = emailCont.text.validate()
        ..password = passwordCont.text.validate();

      authService.signUpWithEmailPassword(context, email: emailCont.text.trim(), password: passwordCont.text.trim(), userData: userData).then((value) async {
        DashboardScreen().launch(context, isNewTask: true);

        appStore.setLoading(false);
      }).catchError((e) {
        appStore.setLoading(false);
      });
    }
  }

  ///endregion

  ///region UI Widget
  Widget getWelcomeTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        60.height,
        Image.asset(ic_app_logo, height: 150, width: 150),
        20.height,
        Text("Welcome to BSR", style: boldTextStyle(size: 24)),
        8.height,
        Text('Sign in to continue with your credentials'),
        28.height,
        SlideMenu(
          menuItems: <Widget>[
            Container(
              color: Colors.black12,
              child: IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ),
            Container(
              color: Colors.red,
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.delete),
                onPressed: () {},
              ),
            ),
          ],
          child: const ListTile(
            title: Text("Just drag me"),
          ),
        ),
      ],
    );
  }

  Widget formWidget() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField(
            textFieldType: TextFieldType.NAME,
            controller: firstNameCont,
            focus: firstNameFocus,
            nextFocus: lastNameFocus,
            errorThisFieldRequired: 'This field is required',
            decoration: inputDecoration(context, labelText: 'First Name', hintText: 'Enter your first name'),
          ),
          16.height,
          AppTextField(
            textFieldType: TextFieldType.NAME,
            controller: lastNameCont,
            focus: lastNameFocus,
            nextFocus: emailFocus,
            errorThisFieldRequired: 'This field is required',
            decoration: inputDecoration(context, labelText: 'Last Name', hintText: 'Enter your last name'),
          ),
          24.height,
          AppTextField(
            controller: emailCont,
            decoration: inputDecoration(context, hintText: 'Enter your email', labelText: 'Email Address'),
            nextFocus: mobileNumberFocus,
            textFieldType: TextFieldType.EMAIL,
            errorThisFieldRequired: 'This field is required',
            autoFillHints: [AutofillHints.email],
          ),
          24.height,
          AppTextField(
            textFieldType: isAndroid ? TextFieldType.PHONE : TextFieldType.NAME,
            controller: mobileNumberCont,
            focus: mobileNumberFocus,
            buildCounter: (_, {required int currentLength, required bool isFocused, required int? maxLength}) {
              return TextButton(
                child: Text('Change Country', style: primaryTextStyle(size: 14)),
                onPressed: () {
                  changeCountry();
                },
              );
            },
            errorThisFieldRequired: 'This field is required',
            nextFocus: passwordFocus,
            decoration: inputDecoration(context, labelText: 'Phone Number', hintText: 'Enter your phone number').copyWith(
              prefixText: '+${selectedCountry.phoneCode} ',
              hintText: 'Example: ${selectedCountry.example}',
            ),
          ),
          8.height,
          AppTextField(
            controller: passwordCont,
            textFieldType: TextFieldType.PASSWORD,
            textInputAction: TextInputAction.done,
            focus: passwordFocus,
            isValidationRequired: true,
            errorThisFieldRequired: 'This field is required',
            decoration: inputDecoration(context, labelText: 'Enter your password'),
            onFieldSubmitted: (s) {
              onSubmit();
            },
          ),
        ],
      ),
    );
  }

  ///endregion

  ///region Change Country
  Future<void> changeCountry() async {
    showCountryPicker(
      context: context,
      showPhoneCode: true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        selectedCountry = country;
        setState(() {});
      },
    );
  }

  ///endregion

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
                getWelcomeTitle(),
                formWidget(),
                24.height,
                AppButton(
                  onTap: () async {
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
          Observer(builder: (context) => Loader().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
