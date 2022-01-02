import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';

import 'package:baskitian/Screen/BottomNavigationBar/BottomNavigationBar.dart';

import '../../../constants.dart';
import 'Login.dart';
import 'Signup.dart';

class ChoseLogin extends StatefulWidget {
  @override
  _ChoseLoginState createState() => _ChoseLoginState();
}

/// Component Widget this layout UI
class _ChoseLoginState extends State<ChoseLogin> with TickerProviderStateMixin {
  /// Declare Animation
  AnimationController animationController;
  var tapLogin = 0;
  var tapSignup = 0;

  @override

  /// Declare animation in initState
  void initState() {
    // TODO: implement initState
    /// Animation proses duration
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tapLogin = 0;
                tapSignup = 0;
              });
            }
          });
    super.initState();
  }

  /// To dispose animation controller
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

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    mediaQuery.devicePixelRatio;
    mediaQuery.size.height;
    mediaQuery.size.width;

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(

        // backgroundColor: myPink1,
        body: Stack(
          children: <Widget>[
            ///
            /// Set background image slider
            ///
            // Container(
            //   color: Colors.white,
            //   child: new Carousel(
            //     boxFit: BoxFit.cover,
            //     autoplay: true,
            //     animationDuration: Duration(milliseconds: 300),
            //     dotSize: 0.0,
            //     dotSpacing: 16.0,
            //     dotBgColor: Colors.transparent,
            //     showIndicator: false,
            //     overlayShadow: false,
            //     images: [
            //       AssetImage('assets/img/girl.png'),
            //       AssetImage("assets/img/SliderLogin2.png"),
            //       AssetImage('assets/img/SliderLogin3.png'),
            //       AssetImage("assets/img/SliderLogin4.png"),
            //     ],
            //   ),
            // ),
            Container(
              color: Colors.white,

              /// Set Background image in layout (Click to open code)
//               decoration: BoxDecoration(
// //              image: DecorationImage(
// //                  image: AssetImage('assets/img/girl.png'), fit: BoxFit.cover)
//                   ),
              child: Container(
                /// Set gradient color in image (Click to open code)
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //         colors: [
                //       Color.fromRGBO(0, 0, 0, 0.3),
                //       Color.fromRGBO(0, 0, 0, 0.4)
                //     ],
                //         begin: FractionalOffset.topCenter,
                //         end: FractionalOffset.bottomCenter)),

                /// Set component layout
                child: ListView(
                  padding: EdgeInsets.all(0.0),
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 50),
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //       top: mediaQuery.padding.top + 50.0),
                                  // ),
                                  Center(
                                    /// Animation text treva shop accept from splashscreen layout (Click to open code)
                                    child: Hero(
                                      tag: "Treva",
                                      child:

                                      Text(
                                        AppLocalizations.of(context)
                                            .tr('title'),
                                        style: TextStyle(
                                          fontFamily: 'Sans',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 32.0,
                                          letterSpacing: 0.4,
                                          color: mygreen2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    child: Image.asset(
                                      "assets/img/logo3.png",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                    ),
                                  ),

                                  /// Padding Text "Get best product in treva shop" (Click to open code)
                                  // Padding(
                                  //     padding: EdgeInsets.only(
                                  //         left: 160.0,
                                  //         right: 160.0,
                                  //         top: mediaQuery.padding.top + 190.0,
                                  //         bottom: 10.0),
                                  //     child: Container(
                                  //       color: myPink6,
                                  //       height: 0.5,
                                  //     )),

                                  /// to set Text "get best product...." (Click to open code)
                                  Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:
                                    TypewriterAnimatedTextKit(
                                      speed: Duration(milliseconds: 100),
                                      totalRepeatCount: 1,
                                      text: [AppLocalizations.of(context).tr('hintChoseLogin')],
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(color: mygreen2,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Sans",
                                          letterSpacing: 1.3
                                      ),
                                      pause: Duration(milliseconds: 0),
                                      displayFullTextOnTap: true,
                                      stopPauseOnTap: true,
                                      isRepeatingAnimation: false,
                                    ),

                                    // Text(
                                    //   AppLocalizations.of(context)
                                    //       .tr('hintChoseLogin'),
                                    //     textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //       color: mygreen2,
                                    //       fontSize: 17.0,
                                    //       fontWeight: FontWeight.normal,
                                    //       fontFamily: "Sans",
                                    //       letterSpacing: 1.3),
                                    // ),
                                  ),),
                                  // Padding(padding: EdgeInsets.only(top: 250.0)),
                                  SizedBox(height: 230),
                                ],
                              ),
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                /// To create animation if user tap == animation play (Click to open code)
                                tapLogin == 0
                                    ? Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: myPink6,
                                          onTap: () {
                                            setState(() {
                                              tapLogin = 1;
                                            });
                                            _Playanimation();
                                            return tapLogin;
                                          },
                                          child: ButtonCustom(
                                              txt: AppLocalizations.of(context)
                                                  .tr('signUp')),
                                        ),
                                      )
                                    : AnimationSplashSignup(
                                        animationController:
                                            animationController.view,
                                      ),
                                Padding(padding: EdgeInsets.only(top: 15.0)),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      /// To set white line (Click to open code)
                                      Container(
                                        color: myPink6,
                                        height: 0.2,
                                        width: 80.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0),

                                        /// navigation to home screen if user click "OR SKIP" (Click to open code)
                                        child:
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushReplacement(
                                                PageRouteBuilder(
                                                    pageBuilder: (_, __, ___) =>
                                                        new bottomNavigationBar()));
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .tr('orSkip'),
                                            style: TextStyle(
                                                color: mygreen2,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Sans",
                                                fontSize: 15.0),
                                          ),
                                        ),
                                      ),

                                      /// To set white line (Click to open code)
                                      Container(
                                        color: myPink6,
                                        height: 0.2,
                                        width: 80.0,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 70.0)),
                              ],
                            ),

                            /// To create animation if user tap == animation play (Click to open code)
                            tapSignup == 0
                                ? Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: myPink6,
                                      onTap: () {
                                        // setState(() {
                                        //   tapSignup = 1;
                                        // });
                                        // _Playanimation();
                                        // return tapSignup;
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                new loginScreen()));
                                      },
                                      child: ButtonCustom(
                                          txt: AppLocalizations.of(context)
                                              .tr('login'),

                                      ),

                                    ),
                                  )
                                : AnimationSplashLogin(animationController: animationController.view,),
                            SizedBox(height: 20),
                          ],
                        ),
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

/// Button Custom widget
class ButtonCustom extends StatelessWidget {
  @override
  String txt;
  GestureTapCallback ontap;

  ButtonCustom({this.txt});

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: myPink6,
        child: LayoutBuilder(builder: (context, constraint) {
          return Container(
            width: 300.0,
            height: 52.0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: mygreen1, blurRadius: 15.0)],
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                    colors: <Color>[myPink6, myPink1])),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30.0),
            //     color: Colors.transparent,
            //     border: Border.all(color:myPink6)),
            child: Center(
                child: Text(
              txt,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Sans",
                  letterSpacing: 0.5),
            )),
          );
        }),
      ),
    );
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

/// Set Animation signup if user click button signup
class AnimationSplashSignup extends StatefulWidget {
  AnimationSplashSignup({Key key, this.animationController})
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
  _AnimationSplashSignupState createState() => _AnimationSplashSignupState();
}

/// Set Animation signup if user click button signup
class _AnimationSplashSignupState extends State<AnimationSplashSignup> {
  @override
  Widget build(BuildContext context) {
    widget.animationController.addListener(() {
      if (widget.animation.isCompleted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => new Signup()));
      }
    });
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: widget._buildAnimation,
    );
  }
}




