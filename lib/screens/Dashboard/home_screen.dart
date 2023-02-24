import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/screens/sign_in_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  logOut() {
    showConfirmDialogCustom(context, barrierDismissible: false, title: 'Are you sure want to log out?', onAccept: (e) {
      appStore.setUID('');
      appStore.setEmail('');
      appStore.setName('');
      appStore.setLogin(false);

      SignInScreen().launch(context, isNewTask: true);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarWidget(
        '',
        showBack: false,
        titleWidget: RichText(
          maxLines: 1,
          overflow: TextOverflow.clip,
          text: TextSpan(
            text: 'Hello, ',
            style: secondaryTextStyle(color: Colors.white),
            children: <TextSpan>[
              TextSpan(text: appStore.name, style: boldTextStyle(color: Colors.white)),
            ],
          ),
        ),
        color: primaryColor,
        textColor: white,
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: Icon(Icons.logout, color: Colors.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 130,
              alignment: Alignment.center,
              width: (context.width() - 48) / 2,
              decoration: boxDecorationWithRoundedCorners(borderRadius: radius(8), backgroundColor: context.cardColor, border: Border.all(width: 0.4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: radius(defaultRadius),
                      backgroundColor: primaryColor.withOpacity(0.3),
                    ),
                    child: Icon(Icons.person, color: primaryColor),
                  ),
                  8.height,
                  Text('8', style: boldTextStyle()),
                  8.height,
                  Text('Patients', style: boldTextStyle())
                ],
              ),
            ),
            16.width,
            Container(
              height: 130,
              alignment: Alignment.center,
              width: (context.width() - 48) / 2,
              decoration: boxDecorationWithRoundedCorners(borderRadius: radius(8), backgroundColor: context.cardColor, border: Border.all(width: 0.4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: radius(defaultRadius),
                      backgroundColor: primaryColor.withOpacity(0.3),
                    ),
                    child: Icon(Icons.person, color: primaryColor),
                  ),
                  8.height,
                  Text('8', style: boldTextStyle()),
                  8.height,
                  Text('Patients', style: boldTextStyle())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
