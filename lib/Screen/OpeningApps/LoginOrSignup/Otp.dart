import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:baskitian/Screen/B3_CartScreen/CartUIComponent/Delivery.dart';
import 'package:baskitian/Screen/BottomNavigationBar/BottomNavigationBar.dart';
import '../../../constants.dart';
import 'Login.dart';
import 'LoginAnimation.dart';

class Otp extends StatefulWidget {
  final String code;
  final String mobile;

  Otp(this.code, this.mobile);

  @override
  _OtpState createState() => _OtpState(code, mobile);
}

class _OtpState extends State<Otp> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;
  var tap = 0;
  var tapCode = 0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();
  TextEditingController _textFieldController4 = TextEditingController();
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  AnimationController controller;

  final String userOtp;
  final String mobile;

  _OtpState(this.userOtp, this.mobile);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  String phoneNumber;

  /// Set AnimationController to initState
  @override
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
                tapCode = 0;
              });
            }
          });
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    if (controller.isAnimating) {
      controller.stop(canceled: true);
    } else {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    }

    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  /// Dispose animationController
  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    controller.dispose();
    sanimationController.dispose();
    super.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  fetchOrders() async {
    //https://alsaydaly.herokuapp.com/User/OTP/+201099143706/SignUp/EN
    var response = await http.get(
        Uri.parse("$url/User/OTP/+201099143706/SignUp/${AppLocalizations.of(context).locale.languageCode.toUpperCase()}"));
    // var jsonData = json.decode(response.body);
    print(
        "$url/User/OTP/+201099143706/SignUp/${AppLocalizations.of(context).locale.languageCode.toUpperCase()}");

    if (response.statusCode == 200) {
      print("code : ${response.body}");
      Toast.show(response.body, context,
          backgroundColor: Colors.green, textColor: Colors.white);
    } else {
      Toast.show(response.body, context,
          backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  /// Validation OTP for first testified
  String validateOtp1(String value) {
    if (value != userOtp[1]) {
      return "";
    }
    return null;
  }

  /// Validation OTP for second testified
  String validateOtp2(String value) {
    if (value != userOtp[1]) {
      return "";
    }
    return null;
  }

  /// Validation OTP for third testified
  String validateOtp3(String value) {
    if (value != userOtp[2]) {
      return "";
    }
    return null;
  }

  /// Validation OTP for third testified
  String validateOtp4(String value) {
    if (value != userOtp[3]) {
      return "";
    }
    return null;
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              /// Set Background image in layout
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/backgroundgirl.jpeg"),
                    fit: BoxFit.cover,
                  )),
              child: Container(
                /// Set gradient color in image
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       Color.fromRGBO(0, 0, 0, 0.0),
                //       Color.fromRGBO(0, 0, 0, 0.5)
                //     ],
                //     begin: FractionalOffset.topCenter,
                //     end: FractionalOffset.bottomCenter,
                //   ),
                // ),

                /// Set component layout
                child: ListView(
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[

                        Column(
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.topCenter,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Padding(child: Text(
                                        AppLocalizations.of(context)
                                            .tr("title"),
                                        style: TextStyle(
                                            color: myPt0,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "San"),
                                      ),padding: EdgeInsets.only(left: 10,right: 20,top: 10),),
                                      Spacer(),
                                      Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),child: InkWell(child: new Icon(Icons.close,color: myPt0,size: 30,), onTap: (){
                                        // Navigator.of(context).pushReplacement(
                                        //     PageRouteBuilder(pageBuilder: (_, __, ___) => cart()));
                                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                                            pageBuilder: (_, __, ___) => new bottomNavigationBar()));
                                      },),)
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 20.0)),
                                  Center(
                                    child: Text(
                                      "${AppLocalizations.of(context).tr("Enter the code sent to ")} $mobile",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0,
                                          // fontWeight: FontWeight.w900,
                                          fontFamily: "Sans"),
                                    ),
                                  ),

                                  Padding(padding: EdgeInsets.only(top: 40.0)),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: (60),
                                                      child: TextFormField(
                                                        autofocus: true,
                                                        style: TextStyle(fontSize: 24),
                                                        keyboardType: TextInputType.number,
                                                        controller: _textFieldController1,
                                                        textAlign: TextAlign.center,
                                                        decoration: InputDecoration(

                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.grey),
                                                            //  when the TextFormField in unfocused
                                                          ) ,
                                                          focusedBorder: UnderlineInputBorder(
                                                            //  when the TextFormField in focused
                                                          ) ,
                                                          border: UnderlineInputBorder(
                                                          ),

                                                          // If  you are using latest version of flutter then lable text and hint text shown like this
                                                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                                                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
                                                          isDense: true,
                                                        ),
                                                        onChanged: (value) {
                                                          nextField(value, pin2FocusNode);
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (60),
                                                      child: TextFormField(
                                                        focusNode: pin2FocusNode,
                                                        style: TextStyle(fontSize: 24),
                                                        controller: _textFieldController2,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        decoration: InputDecoration(

                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.grey),
                                                            //  when the TextFormField in unfocused
                                                          ) ,
                                                          focusedBorder: UnderlineInputBorder(
                                                            //  when the TextFormField in focused
                                                          ) ,
                                                          border: UnderlineInputBorder(
                                                          ),

                                                          // If  you are using latest version of flutter then lable text and hint text shown like this
                                                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                                                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
                                                          isDense: true,
                                                        ),
                                                        onChanged: (value) => nextField(value, pin3FocusNode),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (60),
                                                      child: TextFormField(
                                                        focusNode: pin3FocusNode,
                                                        style: TextStyle(fontSize: 24),
                                                        controller: _textFieldController3,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        decoration: InputDecoration(

                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.grey),
                                                            //  when the TextFormField in unfocused
                                                          ) ,
                                                          focusedBorder: UnderlineInputBorder(
                                                            //  when the TextFormField in focused
                                                          ) ,
                                                          border: UnderlineInputBorder(
                                                          ),

                                                          // If  you are using latest version of flutter then lable text and hint text shown like this
                                                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                                                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
                                                          isDense: true,
                                                        ),
                                                        onChanged: (value) => nextField(value, pin4FocusNode),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (60),
                                                      child: TextFormField(
                                                        focusNode: pin4FocusNode,
                                                        controller: _textFieldController4,
                                                        style: TextStyle(fontSize: 24),
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        decoration: InputDecoration(

                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.grey),
                                                            //  when the TextFormField in unfocused
                                                          ) ,
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: myPt0),
                                                            //  when the TextFormField in focused
                                                          ) ,
                                                          border: UnderlineInputBorder(
                                                          ),

                                                          // If  you are using latest version of flutter then lable text and hint text shown like this
                                                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                                                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
                                                          isDense: true,
                                                        ),
                                                        onChanged: (value) {
                                                          if (value.length == 1) {
                                                            pin4FocusNode.unfocus();
                                                            // Then you need to check is the code is correct or not
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                (_textFieldController1.text !=
                                                            '' &&
                                                        _textFieldController2
                                                                .text !=
                                                            "" &&
                                                        _textFieldController3
                                                                .text !=
                                                            '' &&
                                                        _textFieldController4
                                                                .text !=
                                                            '')
                                                    ? ArgonButton(
                                                        height: 50,
                                                        roundLoadingShape: true,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        onTap: (startLoading,
                                                            stopLoading,
                                                            btnState) async {
                                                          if (btnState ==
                                                              ButtonState
                                                                  .Idle) {
                                                            startLoading();
                                                            if (_textFieldController1.text != '' &&
                                                                _textFieldController2
                                                                        .text !=
                                                                    "" &&
                                                                _textFieldController3
                                                                        .text !=
                                                                    '' &&
                                                                _textFieldController4
                                                                        .text !=
                                                                    '') {
                                                              String code =
                                                                  "${_textFieldController1.text}${_textFieldController2.text}${_textFieldController3.text}${_textFieldController4.text}";

                                                              if (userOtp == code) {
                                                                stopLoading();
                                                                Navigator.of(context).push(
                                                                    PageRouteBuilder(
                                                                        pageBuilder: (_, __, ___) =>
                                                                            delivery()));
                                                              } else {
                                                                stopLoading();
                                                                Toast.show(AppLocalizations.of(context)
                                                                    .tr("Verification isn't correct"),context,backgroundColor:Colors.red, textColor: Colors.white);
                                                                Navigator.of(context).push(
                                                                    PageRouteBuilder(
                                                                        pageBuilder: (_, __, ___) =>
                                                                            delivery()));
                                                              }
                                                            }
                                                          }
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .tr("Verify"),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        loader: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child:
                                                              SpinKitRotatingCircle(
                                                            color: Colors.white,
                                                            // size: loaderWidth ,
                                                          ),
                                                        ),
                                                        borderRadius: 5.0,
                                                        color: myPt0,
                                                      )
                                                    : Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        alignment:
                                                            Alignment.center,
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .tr("Verify"),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                  alignment: AppLocalizations
                                                                  .of(context)
                                                              .locale
                                                              .languageCode ==
                                                          'en'
                                                      ? Alignment.topLeft
                                                      : Alignment.topRight,
                                                  child: Text(
                                                    "${AppLocalizations.of(context).tr("Resend OTP Code")} ",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),

                                              // TweenAnimationBuilder(
                                              //
                                              //   tween: Tween(begin: 59.0, end: 0.0),
                                              //
                                              //   duration: Duration(seconds: 59),
                                              //   builder: (_, value, child) => Text(
                                              //     " 00:${value.toInt()} ",
                                              //     style: TextStyle(color: kPrimaryColor,fontSize: 18),
                                              //   ),
                                              // ),

                                              AnimatedBuilder(
                                                  animation: controller,
                                                  builder:
                                                      (BuildContext context,
                                                          Widget child) {
                                                    return Text(
                                                      timerString,
                                                      style: TextStyle(
                                                          color: myPt0,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  }),

                                              // AnimatedBuilder(
                                              //     animation: controller,
                                              //     builder: (BuildContext context, Widget child) {
                                              //       return Text(
                                              //         timerString,
                                              //         style: TextStyle(color: kPrimaryColor,fontSize: 18),
                                              //       );
                                              //     }),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          GestureDetector(
                                            child: AnimatedBuilder(
                                              animation: controller,
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                return Text(
                                                  "${AppLocalizations.of(context).tr("Resend OTP Code")} ",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: myPt0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                );
                                              },
                                            ),
                                            onTap: () {
                                              fetchOrders();
                                              print(
                                                  "time : ${controller.value}");
                                              controller.reverse(
                                                  from: controller.value == 0.0
                                                      ? 1.0
                                                      : controller.value);
                                            },
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),

                                          FlatButton(
                                              padding:
                                                  EdgeInsets.only(top: 20.0),
                                              onPressed: () {
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            new loginScreen()));
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .tr('notHaveLogin'),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Sans"),
                                              )),
                                          SizedBox(height: 50),

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        /// Set Animaion after user click buttonLogin
                        SizedBox(
                          height: 200,
                        ),

                        tap == 0
                            ? Visibility(
                                child: new LoginAnimation(
                                    animationController:
                                        sanimationController.view),
                                visible: false,
                              )
                            : Visibility(
                                child: new LoginAnimation(
                                    animationController:
                                        sanimationController.view),
                                visible: true,
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
