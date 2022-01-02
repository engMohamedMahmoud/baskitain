import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class chat extends StatefulWidget {
  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).tr('message'),
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22.0,
              letterSpacing: 2.0,
              color: myPt0,
              fontFamily: "Berlin"),
        ),
        iconTheme: IconThemeData(
          color:  myPt0,
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        width: 500.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 150.0)),
            Image.asset(
              "assets/img/notmessage.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 20.0)),
            Text(
              AppLocalizations.of(context).tr('noMessage'),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 19.5,
                  color: Colors.grey,
                  fontFamily: "Gotik"),
            ),
          ],
        ),
      ),
    );
  }
}
