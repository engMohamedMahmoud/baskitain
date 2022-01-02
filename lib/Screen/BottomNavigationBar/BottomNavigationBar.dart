import 'package:baskitian/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:baskitian/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:baskitian/Screen/B1_HomeScreen/B1_Home/B1_Home_Screen.dart';
import 'package:baskitian/Screen/B2_BrandScreen/BrandUIComponent/BrandLayout.dart';
import 'package:baskitian/Screen/B3_CartScreen/B3_Cart/B3_Cart_Screen.dart';
import 'package:baskitian/Screen/B4_ProfileScreen/B4_Profile/B4_Profile_Screen.dart';
import 'package:baskitian/constants.dart';

class bottomNavigationBar extends StatefulWidget {
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int currentIndex = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new Menu();
      case 1:
        return new brand();
      case 2:
        return new cart();
      case 3:
        return new profil();
        break;
      default:
        return Menu();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: callPage(currentIndex),

        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                textTheme: Theme.of(context).textTheme.copyWith(
                    caption:
                        TextStyle(color: Colors.black26.withOpacity(0.15)))),
            child:


            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              fixedColor: myPt0,
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 23.0,
                    ),
                    title: Text(AppLocalizations.of(context).tr('home'), style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shop),
                    title: Text(
                      AppLocalizations.of(context).tr('brand'),
                      style:
                          TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    title: Text(
                      AppLocalizations.of(context).tr('cart'),
                      style:
                          TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 24.0,
                    ),
                    title: Text(
                      AppLocalizations.of(context).tr('account'),
                      style:
                          TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
                    )),
              ],
            )),
      ),
    );
  }


}
