import 'dart:convert';
import 'dart:io';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:baskitian/Screen/B3_CartScreen/CartUIComponent/Payment.dart';
import 'package:toast/toast.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:baskitian/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../default_button.dart';
// import 'package:flutter_offline/flutter_offline.dart';


class MyLocationDetailsPage extends StatefulWidget {
  final List<String> details;
  final double lat;
  final double long;
  const MyLocationDetailsPage({Key key, @required this.details, this.lat, this.long}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(details, lat, long);
}

class _MyHomePageState extends State<MyLocationDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  double lat, long;

  String userId;
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

  String codeDialogFloorNumber;
  String floorNumber;
  TextEditingController _textFieldControllerFloorNumber =
  TextEditingController();

  String codeDialogBuildingName;
  String buildingName;
  TextEditingController _textFieldControllerBuildingName =
  TextEditingController();

  String city;
  String codeDialogCity;
  TextEditingController cityController = TextEditingController();

  String street;
  String codeDialogStreet;
  TextEditingController streetController = TextEditingController();

  String state;
  String codeDialogState;
  TextEditingController stateController = TextEditingController();

  String country;
  String codeDialogCountry;
  TextEditingController countryController = TextEditingController();

  final List<String> details;

  _MyHomePageState(this.details, this.lat, this.long);


  String validateStreet(String value) {


    if (value.length == 0) {
      return AppLocalizations.of(context)
          .tr("Enter Street");
    }
    return null;
  }

  String valideFloor(String value) {


    if (value.length == 0) {
      return AppLocalizations.of(context)
          .tr("Enter Floor Name");
    }
    return null;
  }

  String valideFlat(String value) {


    if (value.length == 0) {
      return AppLocalizations.of(context)
          .tr("Enter Flat Number");
    }
    return null;
  }

  String valideBulding(String value) {


    if (value.length == 0) {
      return AppLocalizations.of(context)
          .tr("Enter Building Name");
    }
    return null;
  }




  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('_id');
  }
  @override
  void initState() {
    // TODO: implement initState

    getData();
    countryController.text = details[details.length - 1];
    stateController.text = details[details.length - 2];
    cityController.text = details[details.length - 3];
    streetController.text = details[0];


    super.initState();

  }

  String validateMobile(String value) {
    // let re = /(\+201)[0-9]{9}$/;
    //(201)[0-9]{9}
    String patttern = r'(^(01)[0-9]{9}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return AppLocalizations.of(context)
          .tr("Please enter mobile number");
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context)
          .tr("Please enter valid mobile number");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: Icon(Icons.arrow_back)),
          elevation: 0.0,
          title: Text(
            AppLocalizations.of(context).tr('deliveryAppBar'),
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                color: Colors.black54,
                fontFamily: "Gotik"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xFF6991C7)),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding:
              const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).tr('deliveryLocation'),
                    style: TextStyle(
                        color: myPt0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "San"),
                  ),

                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        country = value;
                      });
                    },
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: countryController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .tr("Enter Country Name"),
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
                  SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        state = value;
                      });
                    },
                    enabled: false,

                    keyboardType: TextInputType.text,
                    controller: stateController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .tr("Enter State Name"),
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
                  SizedBox(height: (20)),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        city = value;
                      });
                    },
                    enabled: false,
                    maxLength: 100,
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
                  SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {

                        street = value;
                      });
                    },
                    validator: validateStreet,
                    maxLength: 100,
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
                  SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        buildingName = value;
                      });
                    },
                    maxLength: 5,
                    validator: valideBulding,
                    keyboardType: TextInputType.number,
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
                  SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        floorNumber = value;
                      });
                    },
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    controller: _textFieldControllerFloorNumber,
                    validator: valideFloor,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .tr("Enter Floor Name"),
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
                  SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        flatNumber = value;
                      });
                    },
                    maxLength: 5,
                    validator: valideFlat,
                    keyboardType: TextInputType.text,
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
                  // SizedBox(height: getProportionateScreenHeight(20)),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                    validator: validateMobile,
                    maxLength: 11,
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

                  SizedBox(height: 40),

                  DefaultButton(
                    text: AppLocalizations.of(context).tr("Pay"),
                    press: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        codeDialogPhone = "+2$phone";
                        codeDialogFlatNumber = flatNumber;
                        codeDialogBuildingName = buildingName;
                        codeDialogFloorNumber = floorNumber;
                        codeDialogCity = city;
                        codeDialogStreet = street;
                        codeDialogCountry = country;
                        codeDialogState = state;


                        // final navigator = Navigator.of(context);
                        //
                        // await navigator.push(
                        //   MaterialPageRoute(
                        //     builder: (context) => payment(
                        //         city: cityController.text,
                        //         street: streetController.text,
                        //         building:
                        //         _textFieldControllerBuildingName.text,
                        //         floor: _textFieldControllerFloorNumber.text,
                        //         flatNumber:
                        //         _textFieldControllerFlatNumber.text,
                        //         phone:
                        //         "+2${_textFieldControllerPhone.text}",
                        //         lat:  lat,
                        //         long: long
                        //     ),
                        //   ),
                        // );

                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(
                        //         builder:
                        //             (BuildContext context) =>
                        //         new PaymentScreen(
                        //             city: cityController.text,
                        //             street: streetController.text,
                        //             building:
                        //             _textFieldControllerBuildingName.text,
                        //             floor: _textFieldControllerFloorNumber.text,
                        //             flatNumber:
                        //             _textFieldControllerFlatNumber.text,
                        //             phone:
                        //             "+2${_textFieldControllerPhone.text}",
                        //             lat:  lat,
                        //             long: long
                        //         )));


                      }
                    },
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );




  }

}
