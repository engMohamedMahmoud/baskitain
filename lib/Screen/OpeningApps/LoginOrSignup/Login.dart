import 'dart:async';
import 'dart:convert';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:baskitian/Screen/B3_CartScreen/CartUIComponent/Map.dart';
import 'package:baskitian/Screen/BottomNavigationBar/BottomNavigationBar.dart';

import '../../../constants.dart';
import 'package:baskitian/Screen/B3_CartScreen/CartUIComponent/Delivery.dart';
import 'LoginAnimation.dart';
import 'Signup.dart';
import 'forgetPassword.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

/// Component Widget this layout UI
class _loginScreenState extends State<loginScreen>
    with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;


  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var tap = 0;
  String email;
  String password;
  bool remember = false;

  @override

  /// set state animation controller
  void initState() {




    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
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
    sanimationController.dispose();
    super.dispose();
  }



  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
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
  /// Email Validation
  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context).tr('email');
    } else {
      if (!regex.hasMatch(value))
        return AppLocalizations.of(context).tr("email is not valid");
      else
        return null;
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


            // Top(),
            Container(
              /// Set Background image in layout
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/img/backgroundgirl.jpeg"),
                fit: BoxFit.cover,
              )),
              child: Container(

                /// Set component layout
                child: ListView(
                  children: <Widget>[
                    Stack(
                      // alignment: AlignmentDirectional.topStart,
                      children: <Widget>[

                        // Bottom(),
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
                            ),padding: EdgeInsets.only(left: 20,right: 20,top: 20),),
                            Spacer(),
                            Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),child: InkWell(child: new Icon(Icons.close,color: myPt0,size: 30,), onTap: (){
                              // Navigator.of(context).pushReplacement(
                              //     PageRouteBuilder(pageBuilder: (_, __, ___) => cart()));
                              Navigator.of(context).pushReplacement(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new bottomNavigationBar()));

                            },),)
                          ],
                        ),




                        Column(
                          children: <Widget>[
                            Container(
                              // alignment: AlignmentDirectional.topStart,
                              child: Column(
                                children: <Widget>[



                                  Padding(padding: EdgeInsets.all(15),
                                    child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [

                                            SizedBox(height: 60),
                                            Container(alignment: (AppLocalizations.of(context).locale.languageCode == 'ar')?Alignment.topRight: Alignment.topLeft,padding: EdgeInsets.only(left: 5, right: 5),child: Text(
                                              AppLocalizations.of(context)
                                                  .tr("Hello! Welcome back"),
                                              style: TextStyle(
                                                  color: myPt0,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "San"),
                                            ),),

                                            SizedBox(height: 40),
                                            buildEmailFormField(),
                                            SizedBox(height: 20),
                                            buildPasswordFormField(),
                                            SizedBox(height: 20),
                                            Container(alignment: (AppLocalizations.of(context).locale.languageCode == 'ar')?Alignment.topRight: Alignment.topLeft,padding: EdgeInsets.only(left: 10, right: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  //ForgetPasswordScreen
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (BuildContext context) =>
                                                          new ForgetPasswordScreen()));
                                                },
                                                child: Text(

                                                  AppLocalizations.of(context).tr("Forgot Password"),
                                                  style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.w700,color:myPt0),
                                                ),
                                              ),),



                                            SizedBox(height:20),

                                            ArgonButton(
                                              height: 50,
                                              roundLoadingShape: true,
                                              width: MediaQuery.of(context).size.width * 0.9,
                                              onTap: (startLoading, stopLoading, btnState) async {

                                                if (_formKey.currentState.validate()) {
                                                  _formKey.currentState.save();


                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  if (btnState == ButtonState.Idle) {
                                                    startLoading();
                                                    // var appLanguage = Provider.of<AppLanguage>(context);
                                                    final String apiUrl = "$url/User/Login";

                                                    final response = await http.post(Uri.parse(apiUrl), body: {
                                                      "Password":password,
                                                      "Number": email,
                                                      "Language": AppLocalizations.of(context).locale.languageCode.toUpperCase()
                                                    });
                                                    var jsonData = json.decode(response.body.toString());


                                                    try{
                                                      if (response.statusCode == 200){

                                                        if (jsonData["data"]["ProfilePicture"] != null) {
                                                          prefs.setString('token', jsonData["token"]);
                                                          prefs.setString('_id', jsonData["data"]["_id"]);
                                                          prefs.setString('FirstName', jsonData["data"]["FirstName"]);
                                                          prefs.setString('LastName', jsonData["data"]["LastName"]);
                                                          prefs.setString('Email', jsonData["data"]["Email"]);
                                                          prefs.setString('Number', jsonData["data"]["Number"]);
                                                          prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);



                                                          stopLoading();
                                                          setState(() {
                                                            tap = 1;
                                                          });

                                                        }else{


                                                          prefs.setString('token', jsonData["token"]);
                                                          prefs.setString('_id', jsonData["data"]["_id"]);
                                                          prefs.setString('FirstName', jsonData["data"]["FirstName"]);
                                                          prefs.setString('LastName', jsonData["data"]["LastName"]);
                                                          prefs.setString('Email', jsonData["data"]["Email"]);
                                                          prefs.setString('Number', jsonData["data"]["Number"]);
                                                          // prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);




                                                          stopLoading();
                                                          Toast.show(response.body,context,backgroundColor:Colors.green, textColor: Colors.white);
                                                          // Navigator.of(context).push(
                                                          //     PageRouteBuilder(
                                                          //         pageBuilder: (_, __, ___) =>
                                                          //             MapPage(lat:prefs.getDouble('lat') ,long: prefs.getDouble('long'),)));
                                                          final navigator = Navigator.of(context);
                                                          await navigator.push(
                                                            MaterialPageRoute(
                                                              builder: (context) => MapPage(
                                                                lat: prefs.getDouble('lat'),long: prefs.getDouble('long'),
                                                              ),
                                                            ),
                                                          );
                                                        }


                                                      } else{

                                                        print("hello");
                                                        stopLoading();
                                                        Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                                        // Navigator.of(context).push(
                                                        //     PageRouteBuilder(
                                                        //         pageBuilder: (_, __, ___) =>
                                                        //             MapPage(lat:prefs.getDouble('lat') ,long: prefs.getDouble('long'),)));
                                                        final navigator = Navigator.of(context);
                                                        await navigator.push(
                                                          MaterialPageRoute(
                                                            builder: (context) => MapPage(
                                                              lat: prefs.getDouble('lat'),long: prefs.getDouble('long'),
                                                            ),
                                                          ),
                                                        );


                                                        // Visibility(child: showAlertDialog(context), visible: false,);
                                                      }
                                                    }catch(err){
                                                      stopLoading();
                                                      Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                                      Navigator.of(context).push(
                                                          PageRouteBuilder(
                                                              pageBuilder: (_, __, ___) =>
                                                                  delivery()));
                                                    }


                                                  }
                                                }


                                              },
                                              child: Text(
                                                AppLocalizations.of(context).tr("login"),
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
                                                  color: myPt0,
                                                  // size: loaderWidth ,
                                                ),
                                              ),
                                              borderRadius: 5.0,
                                              color: myPt0,
                                            )




                                          ],
                                        )
                                    ),),

                                  Padding(padding: EdgeInsets.only(top: 30.0)),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        /// To set white line (Click to open code)
                                        Container(
                                          color: myPt0,
                                          height: 0.5,
                                          width: 80.0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),

                                          /// navigation to home screen if user click "OR SKIP" (Click to open code)
                                          child:
                                          InkWell(
                                            onTap: () {
                                              // Navigator.of(context).pushReplacement(
                                              //     PageRouteBuilder(
                                              //         pageBuilder: (_, __, ___) =>
                                              //         new bottomNavigationBar()));
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .tr("or"),
                                              style: TextStyle(
                                                  color: myPt0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "San",
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),

                                        /// To set white line (Click to open code)
                                        Container(
                                          color: myPt0,
                                          height: 0.5,
                                          width: 80.0,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10.0)),
                                  Center(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[

                                            ClipOval(
                                              child: Material(
                                                // button color
                                                child: InkWell(

                                                  splashColor: myPt0,
                                                  customBorder: Border.all(color: myPt0, width: 1.0),// inkwell color
                                                  child: SizedBox(width: 56, height: 56, child:
                                                  Padding(
                                                    padding: EdgeInsets.all(15.0),
                                                    child: Image.asset(
                                                      "assets/img/google.png",
                                                      height: 10.0, width: 10.0,
                                                    ),
                                                  )),
                                                  onTap: () {},
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20,),
                                            ClipOval(
                                              child: Material(
                                                color: Color.fromRGBO(107, 112, 248, 1.0), // button color
                                                child: InkWell(
                                                  splashColor: myPt0, // inkwell color
                                                  child: SizedBox(width: 56, height: 56, child:
                                                  Padding(
                                                    padding: EdgeInsets.all(15.0),
                                                    child: Image.asset(
                                                      "assets/img/icon_facebook.png",
                                                      height: 10.0, width: 10.0,
                                                    ),
                                                  )),
                                                  onTap: () {},
                                                ),
                                              ),
                                            )
                                          ])),
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
                                            .tr('notHaveSignUp'),
                                        style: TextStyle(
                                            color: myPt0,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Sans"),
                                      )),
                                  Padding(padding: EdgeInsets.only(top: 30.0)),
                                  SizedBox(height: 40,),

                                ],
                              ),
                            ),
                          ],
                        ),

                        /// Set Animaion after user click buttonLogin
                        SizedBox(height: 200,),
                        tap == 0
                            ? Visibility(child: new LoginAnimation(animationController: sanimationController.view), visible: false,)
                            : Visibility(child: new LoginAnimation(animationController: sanimationController.view), visible: true,)


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
          borderSide: BorderSide(color: myPt0,width: 4.0),
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

  TextFormField buildEmailFormField() {
    return TextFormField(

      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 20, color: myPt0),
      onSaved: (newValue) {
        email = newValue;
      },
      onChanged: (value) {
        email = value;
      },
      validator: validateEmail,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)
            .tr('email'),
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
        labelText: AppLocalizations.of(context)
            .tr('email'),
        labelStyle: TextStyle(fontSize: 15.0, color: Colors.grey),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 2.0),

          //  when the TextFormField in unfocused
        ) ,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: myPt0,width: 2.0),
          // borderRadius: BorderRadius.circular(20.0),
          //  when the TextFormField in focused
        ) ,

        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 0, right: 15,),

          child:  Icon(
            Icons.email_outlined,
            color: Colors.grey,
          ),
          // Image.asset(
          //   'assets/images/user.png',
          //   // height: getProportionateScreenWidth(5),
          //   width: 2,
          //   height: 2,
          // ),
        ),
      ),
    );
  }




}

///buttonCustomFacebook class
class buttonCustomFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(107, 112, 248, 1.0),
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15.0)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/icon_facebook.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              AppLocalizations.of(context).tr('loginFacebook'),
              style: TextStyle(
                  color: myPt0,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            ),
          ],
        ),
      ),
    );
  }
}

///buttonCustomGoogle class
class buttonCustomGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: myPt0,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.0)],
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/google.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              AppLocalizations.of(context).tr('loginGoogle'),
              style: TextStyle(
                  color: Colors.black26,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            )
          ],
        ),
      ),
    );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt, image;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: Icon(
                    Icons.close
                    // color: myPt0,
                    // height: 25.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    txt,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black, fontFamily: "San"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          AppLocalizations.of(context).tr('login'),
          style: TextStyle(
              color: myPt0,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Color(0xFF121940), Color(0xFF6E48AA)])),
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

