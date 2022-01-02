import 'dart:async';
import 'dart:convert';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:baskitian/Screen/BottomNavigationBar/BottomNavigationBar.dart';
import 'OtpForgetPassword.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'Signup.dart';


class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

/// Component Widget this layout UI
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;


  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var tap = 0;
  String email;
  String password;
  bool remember = false;
  String phoneNumber;
  String code;


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

                                            SizedBox(height: 50),

                                            Container(alignment: (AppLocalizations.of(context).locale.languageCode == 'ar')?Alignment.topRight: Alignment.topLeft,padding: EdgeInsets.only(left: 15, right: 15),child:
                                            Text(
                                              AppLocalizations.of(context)
                                                  .tr("Enter your phone number and we 'll send you a link to reset your password"),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18.0,
                                                  fontFamily: "San"),
                                            ),),

                                            SizedBox(height: 30),
                                            buildPhoneFormField(),
                                            SizedBox(height: 20),

                                            SizedBox(height:20),

                                            ArgonButton(
                                              height: 50,
                                              roundLoadingShape: true,
                                              width: MediaQuery.of(context).size.width * 0.9,
                                              onTap: (startLoading, stopLoading, btnState) async {

                                                if (_formKey.currentState.validate()) {
                                                  _formKey.currentState.save();
                                                  String myUrl = "$url/User/OTP/$phoneNumber/ForgetPassword/${data.locale.languageCode.toUpperCase()}";
                                                  var response = await http.get(Uri.parse(myUrl));
                                                  var jsonData = json.decode(response.body);

                                                  if (response.statusCode == 200){
                                                    if (response.body.length == 4){


                                                      stopLoading();
                                                      Toast.show(response.body,context,backgroundColor:Colors.green, textColor: Colors.white);
                                                      code = "1234";
                                                      Navigator.of(context).pushReplacement(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (BuildContext context) =>
                                                              new OtpForgetPassword(code,phoneNumber)));


                                                    }else{
                                                      stopLoading();
                                                      Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                                      code = "1234";
                                                      Navigator.of(context).pushReplacement(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (BuildContext context) =>
                                                              new OtpForgetPassword(code,phoneNumber)));
                                                    }
                                                  }
                                                  else{
                                                    stopLoading();
                                                    Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                                    code = "1234";
                                                    Navigator.of(context).pushReplacement(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (BuildContext context) =>
                                                            new OtpForgetPassword(code,phoneNumber)));

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
                                                  color: myPt0,
                                                  // size: loaderWidth ,
                                                ),
                                              ),
                                              borderRadius: 5.0,
                                              color: myPt0,
                                            ),

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




                                          ],
                                        )
                                    ),),

                                  Padding(padding: EdgeInsets.only(top: 10.0)),




                                ],
                              ),
                            ),
                          ],
                        ),

                        /// Set Animaion after user click buttonLogin
                        // SizedBox(height: 200,),
                        // tap == 0
                        //     ? Visibility(child: new LoginAnimation(animationController: sanimationController.view), visible: false,)
                        //     : Visibility(child: new LoginAnimation(animationController: sanimationController.view), visible: true,)


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



  /// phoneNumber Validation
  String validateMobile(String value) {
    // let re = /(\+201)[0-9]{9}$/;
    //(201)[0-9]{9}
    String patttern = r'(^(01)[0-9]{9}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return AppLocalizations.of(context).tr("phone");
    }
    else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context).tr("Please enter valid mobile number");
    }
    return null;
  }
  TextFormField buildPhoneFormField() {
    return TextFormField(

      keyboardType: TextInputType.phone,
      style: TextStyle(fontSize: 20, color: myPt0),
      onSaved: (newValue) {
        phoneNumber = newValue;
      },
      onChanged: (value) {
        phoneNumber = value;
      },
      validator: validateMobile,
      maxLength: 11,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)
            .tr('phone'),
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
        labelText: AppLocalizations.of(context)
            .tr('phone'),
        labelStyle: TextStyle(fontSize: 15.0, color: Colors.grey),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 2.0),

          //  when the TextFormField in unfocused
        ) ,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 2.0),
          // borderRadius: BorderRadius.circular(20.0),
          //  when the TextFormField in focused
        ) ,

        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 0, right: 15,),

          child:  Icon(
            Icons.phone,
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

