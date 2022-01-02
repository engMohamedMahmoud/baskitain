import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shimmer/shimmer.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';

import '../../../constants.dart';

class aboutApps extends StatefulWidget {
  @override
  _aboutAppsState createState() => _aboutAppsState();
}

class _aboutAppsState extends State<aboutApps> {
  @override
  bool imageLoad = true;

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        imageLoad = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;

    var data = EasyLocalizationProvider.of(context).data;

    var _grid = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///
            ///
            /// check the condition if image data from server firebase loaded or no
            /// if image true (image still downloading from server)
            /// Card to set card loading animation
            ///
            ///
          ],
        ),
      ),
    );

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).tr('aboutApps'),
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: Colors.grey,
                fontFamily: "Gotik"),
          ),
          iconTheme: IconThemeData(
            color: Color(0xFF6991C7),
          ),
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[

            Container(
                    /// Set Background image in layout
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: AssetImage("assets/img/backgroundgirl.jpeg"),
                    //       fit: BoxFit.cover,
                    //     )),
              width: mediaQueryData.size.width,
                    child: Container(
                      /// Set component layout
                      child: ListView(
                        children: <Widget>[
                          Stack(
                            // alignment: AlignmentDirectional.topStart,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    // alignment: AlignmentDirectional.topStart,
                                    child: imageLoad?
                                    Shimmer.fromColors(child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 20,
                                          width: mediaQueryData.size.width,
                                          color: Colors.black12,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 300,
                                          width: mediaQueryData.size.width,
                                          decoration: BoxDecoration(
                                            // image: DecorationImage(
                                            //     fit: BoxFit.cover,
                                            //     image: AssetImage(
                                            //         "assets/img/SliderLogin2.png")),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            color: Colors.grey,
                                          ),
                                          // child: Image.asset("assets/img/SliderLogin2.png",fit: BoxFit.cover
                                          //   ,height: 300,width: mediaQueryData.size.width,),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 10,
                                              bottom: 10),
                                          height: 200,

                                          width: mediaQueryData.size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            border:
                                            Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 10,
                                              bottom: 10),
                                          height: 200,
                                          width: mediaQueryData.size.width,

                                          decoration: BoxDecoration(
                                            border:
                                            Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                          ),
                                          child: Align(
                                            alignment:
                                            (AppLocalizations.of(context)
                                                .locale
                                                .languageCode ==
                                                'ar')
                                                ? Alignment.topRight
                                                : Alignment.topLeft,
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment: (AppLocalizations
                                                      .of(context)
                                                      .locale
                                                      .languageCode ==
                                                      'ar')
                                                      ? Alignment.topRight
                                                      : Alignment.topLeft,
                                                  child: Container(
                                                    height: 20,
                                                    width: 200.0,
                                                    color: Colors.black12,
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 10,
                                                ),

                                                Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 200.0,
                                                        color: Colors.black12,
                                                      ),
                                                      Spacer(),
                                                      Flexible(
                                                        child: Container(
                                                          height: 40,
                                                          width: mediaQueryData.size.width,
                                                          color: Colors.black12,
                                                        ),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 200,
                                                        color: Colors.black12,
                                                      ),
                                                      Spacer(),
                                                      Flexible(
                                                        child: Container(
                                                          height: 20,
                                                          width: 200,
                                                          color: Colors.black12,
                                                        ),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 200.0,
                                                        color: Colors.black12,
                                                      ),
                                                      Spacer(),
                                                      Flexible(
                                                        child: Container(
                                                          height: 20,
                                                          width: 200.0,
                                                          color: Colors.black12,
                                                        ),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                // Align(
                                                //   alignment: (AppLocalizations.of(context)
                                                //       .locale
                                                //       .languageCode ==
                                                //       'ar')
                                                //       ? Alignment.topRight
                                                //       : Alignment.topLeft,
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         "${AppLocalizations.of(context)
                                                //             .tr("email")}:",
                                                //         style: TextStyle(
                                                //             color: myPt0,
                                                //             fontSize: 18.0,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //       Spacer(),
                                                //       Text(
                                                //         "moh.elarousi@gmail.com",
                                                //         style: TextStyle(
                                                //             color: Colors.grey,
                                                //             fontSize: 18.0,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                // Align(
                                                //   alignment: (AppLocalizations.of(context)
                                                //       .locale
                                                //       .languageCode ==
                                                //       'ar')
                                                //       ? Alignment.topRight
                                                //       : Alignment.topLeft,
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         "${AppLocalizations.of(context)
                                                //             .tr("handphone")}:",
                                                //         style: TextStyle(
                                                //             color: myPt0,
                                                //             fontSize: 20.0,
                                                //             fontWeight: FontWeight.bold,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //       Spacer(),
                                                //       Text(
                                                //         "01099143706",
                                                //         style: TextStyle(
                                                //             color: Colors.grey,
                                                //             fontSize: 18.0,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                // Align(
                                                //   alignment: (AppLocalizations.of(context)
                                                //       .locale
                                                //       .languageCode ==
                                                //       'ar')
                                                //       ? Alignment.topRight
                                                //       : Alignment.topLeft,
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         "${AppLocalizations.of(context)
                                                //             .tr("address")}:",
                                                //         style: TextStyle(
                                                //             color: myPt0,
                                                //             fontSize: 20.0,
                                                //             fontWeight: FontWeight.bold,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //       Spacer(),
                                                //       Text(
                                                //         " Al Mahalah Al Kubra (Part 2), El Mahalla El Kubra, Gharbia Governorate",
                                                //         style: TextStyle(
                                                //             color: Colors.grey,
                                                //             fontSize: 18.0,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 100,
                                        ),
                                      ],
                                    ),baseColor: Colors.black38,
                                      highlightColor: Colors.white,):
                                    Column(
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                              (AppLocalizations.of(context)
                                                          .locale
                                                          .languageCode ==
                                                      'ar')
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .tr("titleWelcome"),
                                            style: TextStyle(
                                                color: myPt0,
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "San"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 300,
                                          width: mediaQueryData.size.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/img/SliderLogin2.png")),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            color: Colors.redAccent,
                                          ),
                                          // child: Image.asset("assets/img/SliderLogin2.png",fit: BoxFit.cover
                                          //   ,height: 300,width: mediaQueryData.size.width,),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 10,
                                              bottom: 10),
                                          width: mediaQueryData.size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                          ),
                                          child: Text(
                                            "Welcome to Souq.com – the Middle East’s online marketplace.\nWe connect people and products – opening up a world of possibility.\n From bracelets and backpacks to tablets and toy cars – we give you access to everything you need and want. Our range is unparalleled, and our prices unbeatable.Driven by smart technology, everything we do is designed to put the power directly in your hands – giving you the freedom to shop however, whenever and wherever you like.\nWe’re trusted by millions, because we don’t just deliver to your doorstep, we were born here. With Souq.com you’ll always be getting a good deal – with exceptional service that makes your shopping experience as easy and seamless as possible.\nThis is Souq.com – the power is in your hands.",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 10,
                                              bottom: 10),
                                          width: mediaQueryData.size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                          ),
                                          child: Align(
                                            alignment:
                                                (AppLocalizations.of(context)
                                                            .locale
                                                            .languageCode ==
                                                        'ar')
                                                    ? Alignment.topRight
                                                    : Alignment.topLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Align(
                                                  alignment: (AppLocalizations
                                                                  .of(context)
                                                              .locale
                                                              .languageCode ==
                                                          'ar')
                                                      ? Alignment.topRight
                                                      : Alignment.topLeft,
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .tr("Contact Details"),
                                                    style: TextStyle(
                                                        color: myPt0,
                                                        fontSize: 20.0,
                                                        fontFamily: "San"),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 10,
                                                ),

                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${AppLocalizations.of(context).tr("email")}:",
                                                        style: TextStyle(
                                                            color: myPt0,
                                                            fontSize: 18.0,
                                                            fontFamily: "San"),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          "moh.elarousi@gmail.com",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 18.0,
                                                              fontFamily:
                                                                  "San"),
                                                        ),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${AppLocalizations.of(context).tr("phone")}:",
                                                        style: TextStyle(
                                                            color: myPt0,
                                                            fontSize: 18.0,
                                                            fontFamily: "San"),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          "01099143706",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 18.0,
                                                              fontFamily:
                                                                  "San"),
                                                        ),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${AppLocalizations.of(context).tr("address")}:",
                                                        style: TextStyle(
                                                            color: myPt0,
                                                            fontSize: 18.0,
                                                            fontFamily: "San"),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          "Al Mahalah Al Kubra (Part 2), El Mahalla El Kubra, Gharbia Governorate",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 18.0,
                                                              fontFamily:
                                                                  "San"),
                                                        ),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                // Align(
                                                //   alignment: (AppLocalizations.of(context)
                                                //       .locale
                                                //       .languageCode ==
                                                //       'ar')
                                                //       ? Alignment.topRight
                                                //       : Alignment.topLeft,
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         "${AppLocalizations.of(context)
                                                //             .tr("email")}:",
                                                //         style: TextStyle(
                                                //             color: myPt0,
                                                //             fontSize: 18.0,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //       Spacer(),
                                                //       Text(
                                                //         "moh.elarousi@gmail.com",
                                                //         style: TextStyle(
                                                //             color: Colors.grey,
                                                //             fontSize: 18.0,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                // Align(
                                                //   alignment: (AppLocalizations.of(context)
                                                //       .locale
                                                //       .languageCode ==
                                                //       'ar')
                                                //       ? Alignment.topRight
                                                //       : Alignment.topLeft,
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         "${AppLocalizations.of(context)
                                                //             .tr("handphone")}:",
                                                //         style: TextStyle(
                                                //             color: myPt0,
                                                //             fontSize: 20.0,
                                                //             fontWeight: FontWeight.bold,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //       Spacer(),
                                                //       Text(
                                                //         "01099143706",
                                                //         style: TextStyle(
                                                //             color: Colors.grey,
                                                //             fontSize: 18.0,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                // Align(
                                                //   alignment: (AppLocalizations.of(context)
                                                //       .locale
                                                //       .languageCode ==
                                                //       'ar')
                                                //       ? Alignment.topRight
                                                //       : Alignment.topLeft,
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         "${AppLocalizations.of(context)
                                                //             .tr("address")}:",
                                                //         style: TextStyle(
                                                //             color: myPt0,
                                                //             fontSize: 20.0,
                                                //             fontWeight: FontWeight.bold,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //       Spacer(),
                                                //       Text(
                                                //         " Al Mahalah Al Kubra (Part 2), El Mahalla El Kubra, Gharbia Governorate",
                                                //         style: TextStyle(
                                                //             color: Colors.grey,
                                                //             fontSize: 18.0,
                                                //             fontFamily: "San"),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 100,
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

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return version;
  }
}
