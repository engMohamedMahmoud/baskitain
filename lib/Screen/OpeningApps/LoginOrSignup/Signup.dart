import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:baskitian/Screen/BottomNavigationBar/BottomNavigationBar.dart';
import '../../../constants.dart';
import 'Login.dart';
import 'Otp.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;
  var tap = 0;

  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String conformPassword;
  File _image;
  List items = [];

  String code;
  /// Set AnimationController to initState
  @override
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


  /// Dispose animationController
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
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
    mediaQueryData.size.height;
    mediaQueryData.size.width;

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: Stack(
          children: <Widget>[

            Container(
              /// Set Background image in layout
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/img/backgroundgirl.jpeg"),
                fit: BoxFit.cover,
              )),
              child: Container(
                /// Set gradient color in image
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       Color.fromRGBO(0, 0, 0, 0.2),
                //       Color.fromRGBO(0, 0, 0, 0.5)
                //     ],
                //     begin: FractionalOffset.topCenter,
                //     end: FractionalOffset.bottomCenter,
                //   ),
                // ),

                /// Set component layout
                child: ListView(
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[


                        Column(
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.topCenter,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 20),
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
                                      ),padding: EdgeInsets.only(left: 25,right: 25,top: 10),),
                                      Spacer(),
                                      Padding(padding: EdgeInsets.only(left: 25,right: 20,top: 25),child: InkWell(child: new Icon(Icons.close,color: myPt0,size: 30,), onTap: (){
                                        // Navigator.of(context).pushReplacement(
                                        //     PageRouteBuilder(pageBuilder: (_, __, ___) => cart()));

                                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                                            pageBuilder: (_, __, ___) => new bottomNavigationBar()));

                                      },),)
                                    ],
                                  ),

                                  // Container(alignment: (AppLocalizations.of(context).locale.languageCode == 'ar')?Alignment.topRight: Alignment.topLeft,padding: EdgeInsets.only(left: 10, right: 10),child: Text(
                                  //   AppLocalizations.of(context)
                                  //       .tr("Phone Number Verification"),
                                  //   style: TextStyle(
                                  //       fontSize: 20.0,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontFamily: "San"),
                                  // ),),

                                  SizedBox(height: 20,),
                                  Container(alignment: (AppLocalizations.of(context).locale.languageCode == 'ar')?Alignment.topRight: Alignment.topLeft,padding: EdgeInsets.only(left: 25, right: 25),child: Text(
                                    AppLocalizations.of(context)
                                        .tr("signUp"),
                                    style: TextStyle(
                                        color: myPt0,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "San"),
                                  ),),


                                  // SizedBox(height: 180,),
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
                                                        backgroundColor: myPt0,
                                                        child: _image != null
                                                            ? ClipRRect(
                                                          borderRadius: BorderRadius.circular(50),
                                                          child: Image.file(
                                                            _image,
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit.fill,
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
                                            SizedBox(height: 20),
                                            buildPasswordFormField(),
                                            SizedBox(height: 20,),
                                            buildConfirmPasswordFormField(),
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
                                                      if (response.statusCode == 200){
                                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                                        prefs.setString('token',jsonData["token"]);
                                                        prefs.setString('_id', jsonData["data"]["_id"]);
                                                        prefs.setString('FirstName', jsonData["data"]["FirstName"]);
                                                        prefs.setString('LastName', jsonData["data"]["LastName"]);
                                                        prefs.setString('Email', jsonData["data"]["Email"]);
                                                        prefs.setString('Number', jsonData["data"]["Number"]);
                                                        prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);

                                                        stopLoading();
                                                        Toast.show(res.body,context,backgroundColor:Colors.green, textColor: Colors.white);
                                                        code = "1234";
                                                        Navigator.of(context).pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (BuildContext context) =>
                                                                new Otp(code,phoneNumber)));
                                                      } else{

                                                        stopLoading();
                                                        Toast.show(res.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                                        code = "1234";
                                                        Navigator.of(context).pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (BuildContext context) =>
                                                                new Otp(code,phoneNumber)));
                                                      }
                                                    }catch(err){
                                                      print(err);
                                                      stopLoading();
                                                      code = "1234";
                                                      Navigator.of(context).pushReplacement(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (BuildContext context) =>
                                                              new Otp(code,phoneNumber)));
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
                                                          code = "1234";
                                                          Navigator.of(context).pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (BuildContext context) =>
                                                                  new Otp(code,phoneNumber)));
                                                        } else{


                                                          Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                                          stopLoading();
                                                          code = "1234";
                                                          Navigator.of(context).pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (BuildContext context) =>
                                                                  new Otp(code,phoneNumber)));


                                                        }
                                                      }catch(err){
                                                        stopLoading();
                                                        code = "1234";
                                                        Navigator.of(context).pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (BuildContext context) =>
                                                                new Otp(code,phoneNumber)));




                                                      }
                                                    }
                                                  }
                                                }


                                              },
                                              child: Text(
                                                AppLocalizations.of(context).tr("signUp"),
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

                                  Padding(padding: EdgeInsets.only(top: 10.0)),
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
                                                new loginScreen()));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .tr('notHaveLogin'),
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

/// textfromfield custom class
class textFromField extends StatelessWidget {
  bool password;
  String email;
  IconData icon;
  TextInputType inputType;

  textFromField({this.email, this.icon, this.inputType, this.password});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            obscureText: password,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: email,
                icon: Icon(
                  icon,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
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
          AppLocalizations.of(context).tr('signUp'),
          style: TextStyle(
              color: Colors.white,
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

