import 'package:flutter/material.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:baskitian/constants.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class settingAcount extends StatefulWidget {
  @override
  _settingAcountState createState() => _settingAcountState();
}

class _settingAcountState extends State<settingAcount> {
  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    fontFamily: "Gotik",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black38,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String conformPassword;
  File _image;
  String cashImage;

  /// Set AnimationController to initState
  @override
  void initState() {
    if ((cashImage == null || cashImage == '') && (_image == null || _image.path.length == 0)){
      cashImage = "assets/img/womanface.jpg";
    }
    super.initState();
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
  /// LastName Validation
  String validateLastName(String value) {

    if (value.isEmpty) {
      return  AppLocalizations.of(context).tr("lastName");
    } else if (value.length > 30){
      return  AppLocalizations.of(context).tr("Length must be 30 chars or less than 30");
    }
  }
  /// FirstName Validation
  String validateFirstName(String value) {

    if (value.isEmpty) {
      return  AppLocalizations.of(context).tr("firstName");
    } else if (value.length > 30){
      return  AppLocalizations.of(context).tr("Length must be 30 chars or less than 30");
    }

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

  /// Camera
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  /// Gallery
  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
      print("img: ${_image.path}");
    });
  }

  /// Show Picker
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(AppLocalizations.of(context).tr("Photo Library")),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(AppLocalizations.of(context).tr("Camera")),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).tr('editProfile'),
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                color: Colors.grey,
                fontFamily: "Gotik"),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: myPt0),
          elevation: 0.0,
          backgroundColor: Colors.white30,
        ),
        body: SingleChildScrollView(
          child: Container(child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.all(25),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [


                      SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          fit: StackFit.expand,
                          overflow: Overflow.visible,
                          children: [
                            // CircleAvatar(
                            //   backgroundImage: AssetImage("assets/images/Profile Image.png"),
                            // ),
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: myPt0,

                              child: _image != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                                  : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: CircleAvatar(
                                  radius: 55,
                                  // backgroundColor: Color(0xffFDCF09),
                                  child: _image != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child:
                                    Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                      : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(50)),
                                    width: 100,
                                    height: 100,
                                    child: Image.asset(cashImage),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      buildFirstNameFormField(),
                      SizedBox(height: 20,),
                      buildLastNameFormField(),
                      SizedBox(height: 20,),
                      buildPhoneFormField(),
                      SizedBox(height: 20,),
                      buildEmailFormField(),
                      SizedBox(height: 40),

                      ArgonButton(
                        height: 50,
                        roundLoadingShape: true,
                        width: MediaQuery.of(context).size.width * 0.9,
                        onTap: (startLoading, stopLoading, btnState) async {

                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();


                            if (_image != null){
                              var request =  http.MultipartRequest(
                                  'POST', Uri.parse("$url/User/Register/")

                              );
                              //Header....

                              request.fields['FirstName'] = firstName;
                              request.fields["LastName"]= lastName;
                              request.fields["Password"] = password;
                              request.fields["Email"] = email;
                              request.fields["Number"]= phoneNumber;
                              request.fields["Language"]= AppLocalizations.of(context).locale.languageCode.toUpperCase();
                              request.fields['ProfilePicture '] = _image.toString();
                              request.files.add(await http.MultipartFile.fromPath(
                                  'ProfilePicture',
                                  _image.path
                              )
                              );
                              var response = await request.send();
                              final res = await http.Response.fromStream(response);
                              print(res.body);

                              var jsonData = json.decode(res.body);
                              try{
                                if (res.statusCode == 200){
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('token',jsonData["token"]);
                                  prefs.setString('_id', jsonData["data"]["_id"]);
                                  prefs.setString('FirstName', jsonData["data"]["FirstName"]);
                                  prefs.setString('LastName', jsonData["data"]["LastName"]);
                                  prefs.setString('Email', jsonData["data"]["Email"]);
                                  prefs.setString('Number', jsonData["data"]["Number"]);
                                  prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);


                                  Toast.show(res.body,context,backgroundColor:Colors.green, textColor: Colors.white);

                                } else{

                                  stopLoading();
                                  Toast.show(res.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                }
                              }catch(err){
                                print(err);
                                stopLoading();
                                Toast.show(res.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                              }
                            }
                            else{

                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                // createUser();

                                print("$url/User/Register");
                                final String apiUrl = "$url/User/Register/";

                                final response = await http.post(Uri.parse(apiUrl), body: {
                                  'FirstName': firstName,
                                  "LastName":lastName, "Password":password,
                                  "Email":email,
                                  "Number": phoneNumber,
                                  "Language": AppLocalizations.of(context).locale.languageCode.toUpperCase()
                                });

                                var jsonData = json.decode(response.body);

                                try{
                                  if (response.statusCode == 200){
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString('token', jsonData["token"]);
                                    prefs.setString('_id', jsonData["data"]["_id"]);
                                    prefs.setString('FirstName', jsonData["data"]["FirstName"]);
                                    prefs.setString('LastName', jsonData["data"]["LastName"]);
                                    prefs.setString('Email', jsonData["data"]["Email"]);
                                    prefs.setString('Number', jsonData["data"]["Number"]);

                                    stopLoading();
                                    Toast.show(response.body,context,backgroundColor:Colors.green, textColor: Colors.white);
                                  } else{

                                    stopLoading();
                                    Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);



                                  }
                                }catch(err){
                                  stopLoading();
                                  Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);




                                }
                              }
                            }
                          }


                        },
                        child: Text(
                          AppLocalizations.of(context).tr("editProfile"),
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
                            color: Colors.white,
                            // size: loaderWidth ,
                          ),
                        ),
                        borderRadius: 5.0,
                        color: myPt0,
                      ),
                      SizedBox(height: 40),
                    ],
                  )
              ),),
          ])

              // Column(
              //   children: <Widget>[
              //     setting(
              //       head: AppLocalizations.of(context).tr('account'),
              //       sub1: AppLocalizations.of(context).tr('address'),
              //       sub2: AppLocalizations.of(context).tr('telephone'),
              //       sub3: AppLocalizations.of(context).tr('email'),
              //     ),
              //     setting(
              //       head: AppLocalizations.of(context).tr('setting'),
              //       sub1: AppLocalizations.of(context).tr('orderNotification'),
              //       sub2: AppLocalizations.of(context).tr('discountNotification'),
              //       sub3: AppLocalizations.of(context).tr('creditCard'),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(top: 5.0),
              //       child: Container(
              //         height: 50.0,
              //         width: 1000.0,
              //         color: Colors.white,
              //         child: Padding(
              //           padding: const EdgeInsets.only(
              //               top: 13.0, left: 20.0, bottom: 15.0),
              //           child: Text(
              //             AppLocalizations.of(context).tr('logout'),
              //             style: _txtCustomHead,
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              ),
        ),
      ),
    );
  }



  TextFormField buildEmailFormField() {
    return TextFormField(
      initialValue: "moh.elarousi@gmail.com",

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
          borderSide: BorderSide(color: Colors.grey,width: 2.0),
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

  TextFormField buildFirstNameFormField() {
    return TextFormField(

      initialValue: "Mohamed",
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20, color: myPt0),
      onSaved: (newValue) {
        firstName = newValue;
      },
      onChanged: (value) {
        firstName = value;
      },
      validator: validateFirstName,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)
            .tr('firstName'),
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
        labelText: AppLocalizations.of(context)
            .tr('firstName'),
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
            Icons.person,
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

  TextFormField buildLastNameFormField() {
    return TextFormField(

      initialValue: "Elarousi",
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20, color: myPt0),
      onSaved: (newValue) {
        lastName = "$newValue";
      },
      onChanged: (value) {
        lastName = "$value";
      },
      validator: validateLastName,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)
            .tr('lastName'),
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
        labelText: AppLocalizations.of(context)
            .tr('lastName'),
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
            Icons.person,
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

  TextFormField buildPhoneFormField() {
    return TextFormField(

      initialValue: "01099143706",
      keyboardType: TextInputType.phone,
      style: TextStyle(fontSize: 20, color: myPt0),
      onSaved: (newValue) {
        phoneNumber = newValue;
      },
      onChanged: (value) {
        phoneNumber = value;
      },
      validator: validateMobile,
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

class setting extends StatelessWidget {
  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    fontFamily: "Gotik",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black38,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  String head, sub1, sub2, sub3;

  setting({this.head, this.sub1, this.sub2, this.sub3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        height: 235.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                child: Text(
                  head,
                  style: _txtCustomHead,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        sub1,
                        style: _txtCustomSub,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black38,
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        sub2,
                        style: _txtCustomSub,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black38,
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        sub3,
                        style: _txtCustomSub,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black38,
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}
