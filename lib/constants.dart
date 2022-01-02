import 'package:flutter/material.dart';




// Url
const String url = "https://alsaydaly.herokuapp.com";

// Colors

const myPt0 = Color.fromRGBO(112, 160, 172, 1.0);
const myPink0 = Color.fromRGBO(239, 179, 162, 1.0);
const myPink1 = Color.fromRGBO(247, 165, 176, 1.0);
const myPink2 = Color.fromRGBO(255, 86, 113, 1.0);
const myPink3 = Color.fromRGBO(177, 60, 85, 1.0);
const myPink4 = Color.fromRGBO(198, 57, 77, 1.0);
const myPink5 = Color.fromRGBO(238, 77, 111, 1.0);
const myPink6 = Color.fromRGBO(170, 36, 40, 1.0);

const KbackgroundColor = Color(0xFFF5F6F9);
const mygreen1 = Color.fromRGBO(142, 173, 117, 1.0);
const mygreen2 = Color.fromRGBO(72, 105, 60, 1.0);
const myblue0 = Color.fromRGBO(114, 160, 160, 1.0);
const myblue1 = Color.fromRGBO(111, 159, 171, 1.0);

const blue1 = Color.fromRGBO(69, 73, 82, 1.0);
const blue2 = Color.fromRGBO(76, 77, 97, 1.0);
const yellow1 = Color.fromRGBO(188, 174, 86, 1.0);
const Color primary = Color(0xffed4264);
const Color secondary = Color(0xffffedbc);
const Color shadow = Color.fromRGBO(142, 39, 60, 0.2);
const Color background = Color(0xfffffdf8);
const Color textDark = Color.fromRGBO(28, 7, 12, 0.5);
final kTitle = TextStyle(color: primary, fontSize: 60.0, fontFamily: 'Lobster');
final kBottomText = TextStyle(color: textDark, fontSize: 14.0);
final kInputTextStyle = TextStyle(color: textDark, fontSize: 16.0);
final kForgotPassTextStyle = TextStyle(color: textDark, fontSize: 15.0);
const Color fb = Color(0xff3b5998);
const Color twitter = Color(0xff1da1d2);
const Color google = Color(0xffdb4437);

// Buttons Names
// enum Buttons {
//   Email,
//   Google,
//   Facebook,
//   GitHub,
//   LinkedIn,
//   Pinterest,
//   Tumblr,
//   Twitter
// }




const kPrimaColor = Color.fromRGBO(66, 89, 255, 1.0);
const kPrimaryLightColor = Color(0xFFFFECDF);

// Regulation Experation
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp passwordValidationRexExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');