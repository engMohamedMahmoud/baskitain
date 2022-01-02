import 'dart:async';
import 'dart:convert';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:http/http.dart' as http;
import 'package:baskitian/Screen/BottomNavigationBar/BottomNavigationBar.dart';
import '../../../constants.dart';
import 'Login.dart';
import 'Signup.dart';

class RestPasswordScreen extends StatefulWidget {
  final String mobile;

  RestPasswordScreen(this.mobile);
  @override
  _RestPasswordScreenScreenState createState() => _RestPasswordScreenScreenState(mobile);
}

/// Component Widget this layout UI
class _RestPasswordScreenScreenState extends State<RestPasswordScreen>
    with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController animationController;


  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var tap = 0;
  String password;
  String conformPassword;
  bool remember = false;

  final String mobile;

  _RestPasswordScreenScreenState(this.mobile);

  @override

  /// set state animation controller
  void initState() {




    animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 300))
      ..addStatusListener((statuss) {
        if (statuss == AnimationStatus.dismissed) {
          setState(() {
            tap = 0;
          });
        }
      });
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
    // TODO: implement dispose
  }



  /// Playanimation set forward reverse
  Future<Null> _Playanimation() async {
    try {
      await animationController.forward();
      await animationController.reverse();
    } on TickerCanceled {}
  }


  /// Password Validation
  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context).tr("password");
    } else {
      if (!regex.hasMatch(value))
        return AppLocalizations.of(context).tr("password is not valid");
      else
        return null;
    }
  }
  /// Confirm Password Validation
  String validateConfirmPassword(String value) {

    if (value.isEmpty) {
      return  AppLocalizations.of(context).tr("Confirm Password");
    }else if (value != password ){
      return AppLocalizations.of(context).tr("Passwords don't match");
    }
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;

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
              // color: myPink0,
              child: Container(
                /// Set gradient color in image
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       Color.fromRGBO(0, 0, 0, 0.2),
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

                        // Bottom(),

                        Column(
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.topCenter,
                              child: Column(
                                children: <Widget>[
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
                                  // Container(alignment: (AppLocalizations.of(context).locale.languageCode == 'ar')?Alignment.topRight: Alignment.topLeft,padding: EdgeInsets.only(left: 10, right: 10),child: Text(
                                  //   AppLocalizations.of(context)
                                  //       .tr("Phone Number Verification"),
                                  //   style: TextStyle(
                                  //       fontSize: 20.0,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontFamily: "San"),
                                  // ),),

                                  Center(
                                    child: Text(
                                      "${AppLocalizations.of(context).tr("Reset Password")}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0,
                                          // fontWeight: FontWeight.w900,
                                          fontFamily: "Sans"),
                                    ),
                                  ),


                                  Padding(
                                      padding: EdgeInsets.only(
                                          top:  20.0)),


                                  // SizedBox(height: 180,),

                                  Padding(padding: EdgeInsets.all(25),
                                    child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20),
                                            buildPasswordFormField(),
                                            SizedBox(height: 20,),
                                            buildConfirmPasswordFormField(),


                                            SizedBox(height:20),

                                            ArgonButton(
                                              height: 50,
                                              roundLoadingShape: true,
                                              width: MediaQuery.of(context).size.width * 0.9,
                                              onTap: (startLoading, stopLoading, btnState) async {

                                                if (_formKey.currentState.validate()) {
                                                  _formKey.currentState.save();

                                                  var response = await http.get(Uri.parse("$url/User/OTP/$mobile/ForgetPassword/${AppLocalizations.of(context).locale.languageCode.toUpperCase()}"));
                                                  var jsonData = json.decode(response.body);

                                                  if (response.statusCode == 200){
                                                    stopLoading();
                                                    Toast.show(response.body,context,backgroundColor:mygreen2, textColor: Colors.white);

                                                    Navigator.of(context).pushReplacement(
                                                        MaterialPageRoute(builder: (BuildContext context) => new loginScreen()));
                                                  }
                                                  else{
                                                    stopLoading();
                                                    Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);

                                                    Navigator.of(context).pushReplacement(
                                                        MaterialPageRoute(builder: (BuildContext context) => new loginScreen()));

                                                  }


                                                }


                                              },
                                              child: Text(
                                                AppLocalizations.of(context).tr("Continue"),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              loader: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    gradient: LinearGradient(
                                                        colors: <Color>[Colors.white, myPt0])),
                                                child: SpinKitRotatingCircle(
                                                  color: Colors.white,
                                                  // size: loaderWidth ,
                                                ),
                                              ),
                                              borderRadius: 5.0,
                                              color: myPt0,
                                            )




                                          ],
                                        )
                                    ),),

                                  SizedBox(height:20),
                                  /// Button Login
                                  FlatButton(
                                      padding: EdgeInsets.only(top: 20.0),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                new Signup()));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .tr("notHave"),
                                        style: TextStyle(
                                            color: myPt0,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Sans"),
                                      )),
                                  SizedBox(height: 70,),

                                ],
                              ),
                            ),
                          ],
                        ),

                        /// Set Animaion after user click buttonLogin
                        SizedBox(height: 200,),
                        tap == 0
                            ? Visibility(child: AnimationSplashLogin(animationController: animationController.view,), visible: false,)
                            : Visibility(child: new AnimationSplashLogin(animationController: animationController.view,), visible: true,)


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



  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(fontSize: 20, color: myPt0),
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {

        conformPassword = value;
      },

      validator: validateConfirmPassword,


      decoration: InputDecoration(
        hintText:  AppLocalizations.of(context)
            .tr("Confirm Password"),
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
        labelText: AppLocalizations.of(context)
            .tr("Confirm Password"),
        labelStyle: TextStyle(fontSize: 15.0, color:Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 4.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //  when the TextFormField in unfocused
        ) ,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 4.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //  when the TextFormField in focused
        ) ,
        border: UnderlineInputBorder(
        ),
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 0, right: 15,),

          child: Icon(
            Icons.vpn_key,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(fontSize: 20, color: myPt0),
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {

        password = value;
      },

      validator: validatePassword,


      decoration: InputDecoration(
        hintText:  AppLocalizations.of(context)
            .tr('password'),
        hintStyle: TextStyle(fontSize: 20.0, color:Colors.grey),
        labelText: AppLocalizations.of(context)
            .tr('password'),
        labelStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 4.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //  when the TextFormField in unfocused
        ) ,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 4.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //  when the TextFormField in focused
        ) ,
        border: UnderlineInputBorder(
        ),
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 0, right: 15,),

          child: Icon(
            Icons.vpn_key,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }





}



class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo(0, size.height - 70);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

/// Set Animation Login if user click button login
class AnimationSplashLogin extends StatefulWidget {
  AnimationSplashLogin({Key key, this.animationController})
      : animation = new Tween(
    end: 900.0,
    begin: 70.0,
  ).animate(CurvedAnimation(
      parent: animationController, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final AnimationController animationController;
  final Animation animation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.0),
      child: Container(
        height: animation.value,
        width: animation.value,
        decoration: BoxDecoration(
          color: myPink6,
          shape: animation.value < 600 ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  @override
  _AnimationSplashLoginState createState() => _AnimationSplashLoginState();
}

/// Set Animation Login if user click button login
class _AnimationSplashLoginState extends State<AnimationSplashLogin> {
  @override
  Widget build(BuildContext context) {
    widget.animationController.addListener(() {
      if (widget.animation.isCompleted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => new loginScreen()));
      }
    });
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: widget._buildAnimation,
    );
  }
}

