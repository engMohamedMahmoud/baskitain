import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:baskitian/Model/CartItemData.dart';
import 'package:baskitian/Screen/B3_CartScreen/CartUIComponent/Map.dart';
import 'package:baskitian/Screen/OpeningApps/LoginOrSignup/Login.dart';
import 'package:baskitian/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  final List<cartItem> items = new List();
  LatLng center;
  String token;
  double lat = 0.0;
  double long = 0.0;
  Position currentLocation;

  @override
  void initState() {
    super.initState();
    setState(() {
      items.add(
        cartItem(
          img: "assets/imgItem/flashsale3.jpg",
          id: 1,
          title: "Samsung Galaxy Note 9 8GB RAM",
          desc: "Internal 1 TB",
          price: "\$ 950",
        ),
      );
    });
  }

  /// Declare price and value for chart
  int value = 1;
  int pay = 950;

  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF6991C7)),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context).tr('cart'),
              style: TextStyle(
                  fontFamily: "Gotik",
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
          ),

          ///
          ///
          /// Checking item value of cart
          ///
          ///
          body: items.length > 0
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, position) {
                    ///
                    /// Widget for list view slide delete
                    ///
                    return Slidable(
                      // delegate: new SlidableDrawerDelegate(),
                      actionExtentRatio: 0.25,
                      // actions: <Widget>[
                      //   new IconSlideAction(
                      //     caption: AppLocalizations.of(context)
                      //         .tr('cartArchiveText'),
                      //     color: Colors.blue,
                      //     icon: Icons.archive,
                      //     onTap: () {
                      //       ///
                      //       /// SnackBar show if cart Archive
                      //       ///
                      //       Scaffold.of(context).showSnackBar(SnackBar(
                      //         content: Text(AppLocalizations.of(context)
                      //             .tr('cartArchice')),
                      //         duration: Duration(seconds: 2),
                      //         backgroundColor: Colors.blue,
                      //       ));
                      //     },
                      //   ),
                      // ],
                      actionPane: new IconSlideAction(
                        caption:
                            AppLocalizations.of(context).tr('cartArchiveText'),
                        color: Colors.blue,
                        icon: Icons.archive,
                        onTap: () {
                          ///
                          /// SnackBar show if cart Archive
                          ///
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                AppLocalizations.of(context).tr('cartArchice')),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.blue,
                          ));
                        },
                      ),
                      secondaryActions: <Widget>[
                        new IconSlideAction(
                          key: Key(items[position].id.toString()),
                          caption:
                              AppLocalizations.of(context).tr('cartDelete'),
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            setState(() {
                              items.removeAt(position);
                            });

                            ///
                            /// SnackBar show if cart delet
                            ///
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .tr('cartDeleted')),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.redAccent,
                            ));
                          },
                        ),
                      ],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 1.0, left: 13.0, right: 13.0),

                        /// Background Constructor for card
                        child: Container(
                          height: 220.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.1),
                                blurRadius: 3.5,
                                spreadRadius: 0.4,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.all(10.0),

                                      /// Image item
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12
                                                        .withOpacity(0.1),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.1)
                                              ]),
                                          child: Image.asset(
                                            '${items[position].img}',
                                            height: 130.0,
                                            width: 120.0,
                                            fit: BoxFit.cover,
                                          ))),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25.0, left: 10.0, right: 5.0),
                                      child: Column(
                                        /// Text Information Item
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${items[position].title}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Sans",
                                              color: Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0)),
                                          Text(
                                            '${items[position].desc}',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0)),
                                          Text('${items[position].price}'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 0.0),
                                            child: Container(
                                              width: 112.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  border: Border.all(
                                                      color: Colors.black12
                                                          .withOpacity(0.1))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  /// Decrease of value item
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        value = value - 1;
                                                        pay = 950 * value;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              right: BorderSide(
                                                                  color: Colors
                                                                      .black12
                                                                      .withOpacity(
                                                                          0.1)))),
                                                      child: Center(
                                                          child: Text("-")),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18.0),
                                                    child:
                                                        Text(value.toString()),
                                                  ),

                                                  /// Increasing value of item
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        value = value + 1;
                                                        pay = 950 * value;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 30.0,
                                                      width: 28.0,
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              left: BorderSide(
                                                                  color: Colors
                                                                      .black12
                                                                      .withOpacity(
                                                                          0.1)))),
                                                      child: Center(
                                                          child: Text("+")),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 8.0)),
                              Divider(
                                height: 2.0,
                                color: Colors.black12,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 9.0, left: 10.0, right: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),

                                      /// Total price of item buy
                                      child: Text(
                                        AppLocalizations.of(context)
                                                .tr('cartTotal') +
                                            "\$" +
                                            pay.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.5,
                                            fontFamily: "Sans"),
                                      ),
                                    ),
                                    ArgonButton(
                                      height: 40.0,
                                      width: 120.0,
                                      roundLoadingShape: true,
                                      onTap: (startLoading, stopLoading,
                                          btnState) async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        startLoading();

                                        if(prefs.getString('_id') != null){
                                          if (prefs.getDouble('lat') != null && prefs.getDouble('long') != null) {
                                            print("Lat : ${prefs.getDouble('lat')}");
                                            print("Lat : ${prefs.getDouble('long')}");
                                            stopLoading();

                                            final navigator = Navigator.of(context);
                                            await navigator.push(
                                              MaterialPageRoute(
                                                builder: (context) => MapPage(
                                                  lat: prefs.getDouble('lat'),long: prefs.getDouble('long'),
                                                ),
                                              ),
                                            );

                                          }
                                          else {
                                            currentLocation = await locateUser();
                                            center = LatLng(currentLocation.latitude, currentLocation.longitude);

                                            prefs.setDouble('lat', currentLocation.latitude);
                                            prefs.setDouble('long', currentLocation.longitude);

                                            print("Lat : ${prefs.getDouble('lat')}");
                                            print("Lat : ${prefs.getDouble('long')}");
                                            if (prefs.getDouble('lat') != null && prefs.getDouble('long') != null) {
                                              stopLoading();
                                              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new loginScreen()));

                                              final navigator = Navigator.of(context);
                                              await navigator.push(
                                                MaterialPageRoute(
                                                  builder: (context) => MapPage(
                                                    lat: prefs.getDouble('lat'),long: prefs.getDouble('long'),
                                                  ),
                                                ),
                                              );
                                              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new MapPage(lat: prefs.getDouble('lat'),long: prefs.getDouble('long'),)));
                                            }
                                          }
                                        }else{
                                          if (prefs.getDouble('lat') != null && prefs.getDouble('long') != null) {
                                            print("Lat : ${prefs.getDouble('lat')}");
                                            print("Lat : ${prefs.getDouble('long')}");
                                            stopLoading();

                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new loginScreen()));

                                          }
                                          else {
                                            currentLocation = await locateUser();
                                            center = LatLng(currentLocation.latitude, currentLocation.longitude);

                                            prefs.setDouble('lat', currentLocation.latitude);
                                            prefs.setDouble('long', currentLocation.longitude);

                                            print("Lat : ${prefs.getDouble('lat')}");
                                            print("Lat : ${prefs.getDouble('long')}");
                                            if (prefs.getDouble('lat') != null && prefs.getDouble('long') != null) {
                                              stopLoading();
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new loginScreen()));

                                            }
                                          }
                                        }



                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Container(
                                          height: 40.0,
                                          width: 120.0,
                                          decoration: BoxDecoration(
                                            color: myPt0,
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .tr('cartPay'),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Sans",
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                      loader: Container(
                                        padding: EdgeInsets.all(10),
                                        child: SpinKitRotatingCircle(
                                          color: Colors.white,
                                          // size: loaderWidth ,
                                        ),
                                      ),
                                      borderRadius: 5.0,
                                      color: myPt0,
                                    ),

                                    // InkWell(
                                    //   onTap: () {
                                    //     // if user login
                                    //     // Navigator.of(context).push(
                                    //     //     PageRouteBuilder(
                                    //     //         pageBuilder: (_, __, ___) =>
                                    //     //             delivery()));
                                    //
                                    //
                                    //
                                    //
                                    //
                                    //     //if user need to login
                                    //     Navigator.of(context).pushReplacement(
                                    //         MaterialPageRoute(builder: (BuildContext context) => new loginScreen()));
                                    //   },
                                    //   child: Padding(
                                    //     padding:
                                    //         const EdgeInsets.only(right: 10.0),
                                    //     child: Container(
                                    //       height: 40.0,
                                    //       width: 120.0,
                                    //       decoration: BoxDecoration(
                                    //         color: Color(0xFFA3BDED),
                                    //       ),
                                    //       child: Center(
                                    //         child: Text(
                                    //           AppLocalizations.of(context)
                                    //               .tr('cartPay'),
                                    //           style: TextStyle(
                                    //               color: Colors.white,
                                    //               fontFamily: "Sans",
                                    //               fontWeight: FontWeight.w600),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    //
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.vertical,
                )
              : noItemCart()),
    );
  }
}

///
///
/// If no item cart this class showing
///
class noItemCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              "assets/imgIllustration/IlustrasiCart.png",
              height: 300.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              AppLocalizations.of(context).tr('cartNoItem'),
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.5,
                  color: Colors.black26.withOpacity(0.2),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}
