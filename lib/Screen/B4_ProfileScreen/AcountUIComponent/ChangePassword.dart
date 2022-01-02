import 'package:flutter/material.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import '../../../constants.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);

  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formKey = GlobalKey<FormState>();
  var tap = 0;
  String currentPassword;
  String password;
  String conformPassword;

  /// Current Password Validation
  String validateCurrentPassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context).tr("Current password");
    } else {
      if (!regex.hasMatch(value))
        return AppLocalizations.of(context).tr("password is not valid");
      else
        return null;
    }
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

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).tr('ChangePassword'),
            style: TextStyle(
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5,
                letterSpacing: 1.2,
                color: Colors.grey),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: myPt0),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top:  40.0)),
              Center(child: Text(
                AppLocalizations.of(context)
                    .tr("You can change your current password"),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "San"),
              ),),
              Padding(padding: EdgeInsets.all(25),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildCurrentPasswordFormField(),
                        SizedBox(height: 20),
                        buildPasswordFormField(),
                        SizedBox(height: 20,),
                        buildConfirmPasswordFormField(),


                        SizedBox(height:40),

                        ArgonButton(
                          height: 50,
                          roundLoadingShape: true,
                          width: MediaQuery.of(context).size.width * 0.9,
                          onTap: (startLoading, stopLoading, btnState) async {

                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              final String apiUrl = "$url/User/ResetPassword/";

                              final response = await http.post(Uri.parse(apiUrl), body: {

                                "Password":currentPassword,
                                "NewPassword":password,
                                "Number": "+201099143706",
                                "Language": AppLocalizations.of(context).locale.languageCode.toUpperCase()
                              });

                              var jsonData = json.decode(response.body);

                              try{
                                if (response.statusCode == 200){
                                  stopLoading();
                                  Toast.show(response.body,context,backgroundColor:Colors.green, textColor: myPt0);

                                } else{

                                  stopLoading();
                                  Toast.show(response.body,context,backgroundColor:Colors.red, textColor: myPt0);


                                }
                              }catch(err){
                                stopLoading();
                                Toast.show(response.body,context,backgroundColor:Colors.red, textColor: myPt0);

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
                                    colors: <Color>[myPt0, myPt0])),
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



              SizedBox(
                height: 70.0,
              )
            ],
          ),
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
  TextFormField buildCurrentPasswordFormField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(fontSize: 20, color: myPt0),
      onSaved: (newValue) => currentPassword = newValue,
      onChanged: (value) {

        currentPassword = value;
      },

      validator: validateCurrentPassword,


      decoration: InputDecoration(
        hintText:  AppLocalizations.of(context)
            .tr("Current password"),
        hintStyle: TextStyle(fontSize: 20.0, color:Colors.grey),
        labelText: AppLocalizations.of(context)
            .tr("Current password"),
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

class cardName extends StatelessWidget {
  String title, flag;
  cardName({this.title, this.flag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Container(
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: myPt0,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.pink.withOpacity(0.3),
                  blurRadius: 10.0,
                  spreadRadius: 0.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 15.0),
          child: Row(children: <Widget>[
            Image.asset(
              flag,
              fit: BoxFit.cover,
              height: 65.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: "Lobster",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.3),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
