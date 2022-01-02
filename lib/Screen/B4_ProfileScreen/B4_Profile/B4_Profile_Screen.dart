import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/AcountUIComponent/AboutApps.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/AcountUIComponent/CallCenter.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/AcountUIComponent/CreditCardSetting.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/AcountUIComponent/Message.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/AcountUIComponent/MyOrders.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/AcountUIComponent/Notification.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/AcountUIComponent/SettingAcount.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/AcountUIComponent/languageSetting.dart';
import 'package:baskitian/Screen/BottomNavigationBar/BottomNavigationBar.dart';
import '../../../constants.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/AcountUIComponent/ChangePassword.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class profil extends StatefulWidget {
  @override
  _profilState createState() => _profilState();
}

/// Custom Font
var _txt = TextStyle(
  color: Colors.black,
  fontFamily: "Sans",
);

/// Get _txt and custom value of Variable for Name User
var _txtName = _txt.copyWith(fontWeight: FontWeight.bold, fontSize: 17.0,color: Colors.grey);

/// Get _txt and custom value of Variable for Edit text
var _txtEdit = _txt.copyWith(color: mygreen1, fontSize: 15.0,fontWeight: FontWeight.w700,decoration: TextDecoration.underline,);

/// Get _txt and custom value of Variable for Category Text
var _txtCategory = _txt.copyWith(color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.w700,);

class _profilState extends State<profil> {

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
    /// Declare MediaQueryData
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    /// To Sett PhotoProfile,Name and Edit Profile
    var _profile = Padding(
      padding: EdgeInsets.only(
        top: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(

                  color: Colors.white,
                    border: Border.all(color: Colors.white, width: 2.5),
                    shape: BoxShape.circle,
                    // image: DecorationImage(
                    //     image: AssetImage("assets/img/womanface.jpg"))
                ),
                child:
                // _image != null? Image.file(
                //   _image,
                //   width: 100,
                //   height: 100,
                //   fit: BoxFit.fitHeight,
                // ): Image.asset(cashImage),

                CircleAvatar(
                  radius: 55,
                  backgroundColor: myPt0,

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
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  AppLocalizations.of(context).tr('name'),
                  style: _txtName,
                ),
              ),
              // InkWell(
              //   onTap: null,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 0.0),
              //     child: Text(
              //       AppLocalizations.of(context).tr('editProfile'),
              //       style: _txtEdit,
              //     ),
              //   ),
              // ),
            ],
          ),
          Container(),
        ],
      ),
    );

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              /// Setting Header Banner
              // Container(
              //   height: 150.0,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage("assets/img/headerProfile.png"),
              //           fit: BoxFit.cover)),
              // ),

              /// Calling _profile variable
              _profile,
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Column(
                  /// Setting Category List
                  children: <Widget>[
                    /// Call category class
                    category(
                      txt: AppLocalizations.of(context).tr('notification'),
                      padding: 35.0,
                      image: "assets/icon/notification.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new notification()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      txt: AppLocalizations.of(context).tr('payments'),
                      padding: 35.0,
                      image: "assets/icon/creditAcount.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                new creditCardSetting()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      txt: AppLocalizations.of(context).tr('message'),
                      padding: 26.0,
                      image: "assets/icon/chat.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new chat()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      txt: AppLocalizations.of(context).tr('myOrders'),
                      padding: 23.0,
                      image: "assets/icon/truck.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new order()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      txt: AppLocalizations.of(context).tr('editProfile'),
                      padding: 30.0,
                      image: "assets/icon/setting.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new settingAcount()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      txt: AppLocalizations.of(context).tr('ChangePassword'),
                      padding: 30.0,
                      image: "assets/icon/rest.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new ChangePassword()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      txt: AppLocalizations.of(context).tr('callCenter'),
                      padding: 30.0,
                      image: "assets/icon/callcenter.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new callCenter()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      txt: AppLocalizations.of(context).tr('language'),
                      padding: 30.0,
                      image: "assets/icon/language.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                new languageSetting()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      padding: 38.0,
                      txt: AppLocalizations.of(context).tr('aboutApps'),
                      image: "assets/icon/aboutapp.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new aboutApps()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      padding: 38.0,
                      txt: AppLocalizations.of(context).tr('logout'),
                      image: "assets/icon/logout.png",
                      tap: () {
                        showDialog(
                            context: context,
                            builder: (_) => NetworkGiffyDialog(
                              image: Image.asset(
                                "assets/gif/earth.gif",
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                  AppLocalizations.of(context).tr('logout'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Gotik",
                                      fontSize: 20.0,
                                      color: myPt0,
                                      fontWeight: FontWeight.w600)),
                              description: Text(
                                AppLocalizations.of(context).tr('Do you want to logout ?'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w300,
                                    color: mygreen2),
                              ),
                              onOkButtonPressed: () {
                                Navigator.of(context).pushReplacement(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => new bottomNavigationBar()));
                              },
                            ));
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20.0)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt, image;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: Image.asset(
                    image,
                    color: myPt0,
                    height: 25.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    txt,
                    style: _txtCategory,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
