import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/Colors.dart';

class HomeCardComponent extends StatefulWidget {
final String? title;
final String? count;


HomeCardComponent({this.title, this.count});

  @override
  _HomeCardComponentState createState() => _HomeCardComponentState();
}

class _HomeCardComponentState extends State<HomeCardComponent> {
  @override
  Widget build(BuildContext context) {
    return  Container(
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
          Text(widget.count.toString(), style: boldTextStyle()),
          8.height,
          Text(widget.title.toString(), style: boldTextStyle())
        ],
      ),
    );
  }
}
