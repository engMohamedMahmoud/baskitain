import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Screen/OpeningApps/LoginOrSignup/LoginAnimation.dart';
import 'package:baskitian/constants.dart';
import 'package:carousel_pro/carousel_pro.dart';

class onBoarding extends StatefulWidget {
  @override
  _onBoardingState createState() => _onBoardingState();
}

var _fontHeaderStyle = TextStyle(
    fontFamily: "Popins",
    fontSize: 21.0,
    fontWeight: FontWeight.w800,
    color: Colors.black87,
    letterSpacing: 1.5);

var _fontDescriptionStyle = TextStyle(
    fontFamily: "Sans",
    fontSize: 15.0,
    color: Colors.black26,
    fontWeight: FontWeight.w400);

///
/// Page View Model for on boarding
///
final pages = [
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'E-Commerce App',
        style: _fontHeaderStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
            'E commerce application template \nbuy this code template in codecanyon',
            textAlign: TextAlign.center,
            style: _fontDescriptionStyle),
      ),
      mainImage: Image.asset(
        'assets/imgIllustration/IlustrasiOnBoarding1.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Choose Item',
        style: _fontHeaderStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
            'Choose Items wherever you are with this application to make life easier',
            textAlign: TextAlign.center,
            style: _fontDescriptionStyle),
      ),
      mainImage: Image.asset(
        'assets/imgIllustration/IlustrasiOnBoarding2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Buy Item',
        style: _fontHeaderStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
            'Shop from thousand brands in the world \n in one application at throwaway \nprices ',
            textAlign: TextAlign.center,
            style: _fontDescriptionStyle),
      ),
      mainImage: Image.asset(
        'assets/imgIllustration/IlustrasiOnBoarding3.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
];

class _onBoardingState extends State<onBoarding> with TickerProviderStateMixin{

  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;
  //Animation Declaration
  AnimationController sanimationController;
  var tap = 0;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage
            ? myPt0
            : mygreen1,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    sanimationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 400))
      ..addStatusListener((statuss) {
        if (statuss == AnimationStatus.dismissed) {
          setState(() {
            tap = 0;
          });
        }
      });
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

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

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: <Widget>[

                  Container(
                    color: Colors.white,
                    child: new Carousel(
                      boxFit: BoxFit.cover,
                      autoplay: true,
                      animationDuration: Duration(milliseconds: 300),
                      dotSize: 3.0,
                      dotSpacing: 16.0,
                      dotBgColor: Colors.white,
                      showIndicator: true,
                      overlayShadow: false,
                      images: [
                        // AssetImage('assets/img/girl.png'),
                        // AssetImage("assets/img/SliderLogin2.png"),
                        // AssetImage('assets/img/SliderLogin3.png'),
                        // AssetImage("assets/img/SliderLogin4.png"),
                        SlideTile(
                          imagePath: mySLides[0].getImageAssetPath(),
                        ),
                        SlideTile(
                          imagePath: mySLides[1].getImageAssetPath(),
                        ),
                        SlideTile(
                          imagePath: mySLides[2].getImageAssetPath(),
                        )
                      ],
                    ),
                  ),


                  // SlideTile(
                  //   imagePath: mySLides[0].getImageAssetPath(),
                  // ),
                  // SlideTile(
                  //   imagePath: mySLides[1].getImageAssetPath(),
                  // ),
                  // SlideTile(
                  //   imagePath: mySLides[2].getImageAssetPath(),
                  // )
                ],
              ),
              Positioned(
                bottom: 200.0,
                left: 30.0,
                child: Text(
                  AppLocalizations.of(context)
                      .tr("title"),
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w800,
                    height: 0.70,
                    color: myPt0,
                  ),
                ),
              ),
              Positioned(
                bottom: 90.0,
                left: 31.0,
                child:
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 100),
                  totalRepeatCount: 1,
                  text: [AppLocalizations.of(context).tr('hintChoseLogin')],
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(color: mygreen2,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Sans",
                  ),
                  pause: Duration(milliseconds: 0),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                  isRepeatingAnimation: false,
                ),
                // Text(
                //   AppLocalizations.of(context)
                //       .tr("hintChoseLogin"),
                //   style: TextStyle(
                //     fontSize: 16.0,
                //     fontWeight: FontWeight.w400,
                //     color: mygreen1,
                //   ),
                // ),
              ),
              // Positioned(
              //   bottom: 50.0,
              //   left: 30.0,
              //   child: Container(
              //     child: Row(
              //       children: [
              //         for (int i = 0; i < 3; i++)
              //           i == slideIndex
              //               ? _buildPageIndicator(true)
              //               : _buildPageIndicator(false),
              //       ],
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: 30.0,
                right: 30.0,
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: myPt0,
                      borderRadius: BorderRadius.circular(130.0 / 2),
                    ),
                    width: 155.0,
                    height: 40.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(

                        onTap: () async {

                          SharedPreferences prefs;
                          prefs = await SharedPreferences.getInstance();
                          prefs.setString("username", "Login");
                          // Navigator.of(context).pushReplacement(PageRouteBuilder(
                          //   pageBuilder: (_, __, ___) => new ChoseLogin(),
                          //   transitionsBuilder:
                          //       (_, Animation<double> animation, __, Widget widget) {
                          //     return Opacity(
                          //       opacity: animation.value,
                          //       child: widget,
                          //     );
                          //   },
                          //   transitionDuration: Duration(milliseconds: 1500),
                          // ));
                          /////////////////////////////////////////////////
                          setState(() {
                            tap = 1;
                          });
                          _PlayAnimation();
                          return tap;



                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child:Center(child:  Text(

                                  AppLocalizations.of(context)
                                      .tr("Get started"),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),)
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 26.0,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),


              SizedBox(height: 50,),
              tap == 0
                  ? Visibility(child: new LoginAnimation(animationController: sanimationController.view), visible: false,)
                  : Visibility(child: new LoginAnimation(animationController: sanimationController.view), visible: true,)
            ],
          ),
        ),
      ),
    );


  }
}


class SlideTile extends StatelessWidget {
  final imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          clipper: BackgroundClipper(),
          child: Container(
            height: size.height * 0.8,
            color: Color.fromRGBO(255, 234, 228, 1),
          ),
        ),
        ClipPath(
          clipper: ImageClipper(),
          child:
          // Container(
          //   color: Colors.white,
          //   child: new Carousel(
          //     // boxFit: BoxFit.cover,
          //     autoplay: true,
          //     animationDuration: Duration(milliseconds: 300),
          //     dotSize: 0.0,
          //     dotSpacing: 16.0,
          //     dotBgColor: Colors.transparent,
          //     showIndicator: false,
          //     overlayShadow: false,
          //     images: [
          //       // AssetImage('assets/img/girl.png'),
          //       Image.asset("assets/img/SliderLogin2.png",height:size.height * 0.4,width: size.width,),
          //       Image.asset('assets/img/SliderLogin3.png',height: size.height * 0.4,width: size.width),
          //       Image.asset("assets/img/SliderLogin4.png",height: size.height * 0.4,width: size.width,),
          //     ],
          //   ),
          // ),

          Container(
            child:
            // new Carousel(
            //   // boxFit: BoxFit.cover,
            //   autoplay: true,
            //   animationDuration: Duration(milliseconds: 300),
            //   // dotSize: 0.0,
            //   // dotSpacing: 16.0,
            //   // dotBgColor: Colors.transparent,
            //   showIndicator: true,
            //   overlayShadow: false,
            //   images: [
            //     Image.asset(
            //       imagePath,
            //       height: size.height * 0.65,
            //       width: size.width,
            //       fit: BoxFit.cover,
            //     ),
            //   ],
            // ),

            Image.asset(
              imagePath,
              height: size.height * 0.65,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.98);
    var firstCtrlPoint = Offset(size.width * 0.45, size.height + 10);
    var firstEndPoint = Offset(size.width * 0.8, size.height * 0.813);
    path.quadraticBezierTo(firstCtrlPoint.dx, firstCtrlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width * 0.8, size.height * 0.815);

    var secondCtrlPoint = Offset(size.width * 0.81, size.height * 0.84);
    var secondEndPoint = Offset(size.width, size.height * 0.98);
    path.quadraticBezierTo(secondCtrlPoint.dx, secondCtrlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.7);
    var firstCtrlPoint = Offset(size.width * 0.25, size.height * 0.9);
    var firstEndPoint = Offset(size.width * 0.8, size.height);
    path.quadraticBezierTo(firstCtrlPoint.dx, firstCtrlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width * 0.8, size.height);

    var secondCtrlPoint = Offset(size.width * 0.95, size.height * 0.87);
    var secondEndPoint = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(secondCtrlPoint.dx, secondCtrlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


class SliderModel {
  String imageAssetPath;

  SliderModel({this.imageAssetPath});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();

  SliderModel sliderModel = new SliderModel();
  sliderModel.setImageAssetPath("assets/img/bg1.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  sliderModel.setImageAssetPath('assets/img/SliderLogin3.png');
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  sliderModel.setImageAssetPath("assets/img/SliderLogin4.png");
  slides.add(sliderModel);

  return slides;
}