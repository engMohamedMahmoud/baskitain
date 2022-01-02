import 'dart:async';
import 'dart:io';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:baskitian/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_pin_picker/map_pin_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../default_button.dart';
import 'map_details_delivery_address.dart';



const String apiKEY = "AIzaSyCtIK7Q4J7IkgUk-EqHaGxjJXg_4tWoM-I";

class MapPage extends StatefulWidget {

  final double lat;
  final double long;

  const MapPage({Key key, this.lat, this.long}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState(lat, long);
}

class _MapPageState extends State<MapPage> {
  Address address;
  var textController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  MapPickerController mapPickerController = MapPickerController();
  GoogleMapController newGoogleMapController;
  CameraPosition cameraPosition;
  String city;
  String state;
  String street;
  String _result = '---';
  List<String> add1;
  double userLat;
  double userLong;
  _MapPageState(userLat, userLong);






  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();

  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cameraPosition = CameraPosition(
        target: LatLng(prefs.getDouble('lat'), prefs.getDouble('long')),
        zoom: 14.4746,
      );
    });
  }



  @override
  Widget build(BuildContext context) {



    // if (cameraPosition.target == null)
    //   return Container(
    //     alignment: Alignment.center,
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );

    var data = EasyLocalizationProvider.of(context).data;

    return
      EasyLocalizationProvider(
        data: data,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              AppLocalizations.of(context).tr("Map"),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: myPt0,
            centerTitle: true,
          ),

          body: (cameraPosition.target != null)? Stack(
            children: [
              MapPicker(
                // pass icon widget
                iconWidget: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 50,
                ),
                //add map picker controller
                mapPickerController: mapPickerController,

                child: GoogleMap(
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  // hide location button
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  //  camera position
                  initialCameraPosition: cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    newGoogleMapController = controller;
                  },
                  onCameraMoveStarted: () {
                    // notify map is moving
                    mapPickerController.mapMoving();
                  },
                  onCameraMove: (cameraPosition) {
                    this.cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () async {
                    // notify map stopped moving
                    mapPickerController.mapFinishedMoving();
                    //get address name from camera position
                    List<Address> addresses = await Geocoder.local
                        .findAddressesFromCoordinates(Coordinates(
                        cameraPosition.target.latitude,
                        cameraPosition.target.longitude));

                    userLat = addresses.first.coordinates.latitude;
                    userLong = addresses.first.coordinates.longitude;


                    // update the ui with the address
                    textController.text =
                    '${addresses.first?.addressLine.split(',')[0] ?? ''}, ${addresses.first?.addressLine.split(',')[2] ?? ''}';
                    cityController.text =
                        addresses.first?.addressLine.split(',')[2] ?? '';
                    streetController.text =
                        addresses.first?.addressLine.split(',')[0] ?? '';
                    city = cityController.text;
                    street = streetController.text;

                    List<String> add = addresses.first?.addressLine.split(',');
                    state = add[add.length - 2];
                    add1 = add;


                  },
                ),
              )
            ],
          ) :
          Shimmer.fromColors(
              baseColor: Colors.black38,
              highlightColor: Colors.white,
              child: Container(
                  padding: EdgeInsets.only(bottom: 10, top: 10, right: 30, left: 30),
                  color: Colors.white,
                  height: 170,
                  child: Column(children: [

                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black12,
                      ),
                    ),
                  ])

                // icon: Icon(Icons.directions_boat),
              )
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: (cameraPosition.target != null)? Container(
                padding: EdgeInsets.only(bottom: 10, top: 10, right: 30, left: 30),
                color: Colors.white,
                height: 170,
                child: Column(children: [
                  Center(
                      // alignment: data.locale.languageCode == 'en'
                      //     ? Alignment.topLeft
                      //     : Alignment.topRight,
                      child: Text(
                          AppLocalizations.of(context)
                              .tr("Delivery Location"),
                          style: TextStyle(color: Colors.blueGrey))),
                  SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    controller: textController,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  DefaultButton(
                    text: AppLocalizations.of(context).tr("Delivery here"),
                    press: () async {

                      if (add1.length != 0){
                        final navigator = Navigator.of(context);

                        await navigator.push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MyLocationDetailsPage(
                                  details: add1,
                                  lat: userLat,
                                  long: userLong,

                                ),
                          ),
                        );

                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(
                        //         builder:
                        //             (BuildContext context) =>
                        //         new MapDetailsScreen(addreessDetails: add1,
                        //           street: streetController.text,
                        //           lat: userLat,
                        //           long: userLong,
                        //           city: city,)));

                      }


                    },
                  )
                ])

              // icon: Icon(Icons.directions_boat),
            ) :
            Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.white,
                child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10, right: 30, left: 30),
                    color: Colors.white,
                    height: 100,
                    child: Column(children: [
                      Center(
                        // alignment: data.locale.languageCode == 'en'
                        //     ? Alignment.topLeft
                        //     : Alignment.topRight,
                          child: Center(
                            child: Container(
                              height: 20,
                              width: 200,
                              color: Colors.black12,
                            ),
                          )
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Container(
                          height: 20,
                          width: 200,
                          color: Colors.black12,
                        ),
                      ),
                      SizedBox(height: 10),
                       Center(
                        child: Container(
                          height: 20,
                          width: 200,
                          color: Colors.black12,
                        ),
                      ),
                    ])

                  // icon: Icon(Icons.directions_boat),
                )
            ),
          ),
        ),
      );

  }

  String codeDialogName;
  String name;
  TextEditingController _textFieldController = TextEditingController();

  String codeDialogPhone;
  String phone;
  TextEditingController _textFieldControllerPhone = TextEditingController();

  String codeDialogFlatNumber;
  String flatNumber;
  TextEditingController _textFieldControllerFlatNumber =
  TextEditingController();

  String codeDialogBuildingName;
  String buildingName;
  TextEditingController _textFieldControllerBuildingName =
  TextEditingController();

  String codeDialogCity;
  String codeDialogStreet;

  Future<void> _displayTextInputDialog1(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          // elevation: 16,
          child: Container(
            height: 500.0,
            // margin: EdgeInsets.all(50),
            child: ListView(
              children: <Widget>[
                // SizedBox(height: 20),
                Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                        AppLocalizations.of(context)
                            .tr("Address Details"),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
                SizedBox(height: 20),
                Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      controller: cityController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .tr("Enter City Name"),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder(),

                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        //Change this value to custom as you like
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      controller: streetController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .tr("Enter Street"),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder(),

                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        //Change this value to custom as you like
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          buildingName = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      controller: _textFieldControllerBuildingName,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .tr("Enter Building Name"),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder(),

                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        //Change this value to custom as you like
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          flatNumber = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      controller: _textFieldControllerFlatNumber,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .tr("Enter Flat Number"),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder(),

                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        //Change this value to custom as you like
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .tr("Enter your user Name"),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder(),

                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        //Change this value to custom as you like
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      controller: _textFieldControllerPhone,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .tr("Enter your phone number"),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder(),

                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        //Change this value to custom as you like
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(15),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                  AppLocalizations.of(context).tr("Cancel")),
                              color: Colors.blue,
                              textColor: Colors.white,
                            )),
                        Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(15),
                              onPressed: () {
                                setState(() {
                                  codeDialogName = name;
                                  codeDialogPhone = phone;
                                  codeDialogFlatNumber = flatNumber;
                                  codeDialogBuildingName = buildingName;
                                  codeDialogCity = city;
                                  codeDialogStreet = street;
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                  AppLocalizations.of(context).tr("Ok")),
                              color: Colors.blue,
                              textColor: Colors.white,
                            )),
                      ],
                    ),
                  )
                ]),
              ],
            ),
          ),
        );
      },
    );
  }


}
