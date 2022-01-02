import 'package:baskitian/constants.dart';
import 'package:flutter/material.dart';

import 'constants.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: myPt0,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
class SecondButton extends StatelessWidget {
  const SecondButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FlatButton(
        // shape: RoundedRectangleBorder(
        //     side: BorderSide(color: Colors.blue, width: 1,borderRadius: BorderRadius.circular(20))
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blue),
        ),
        color: myPt0,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueGrey,
          ),
        ),

      ),
    );
  }
}
