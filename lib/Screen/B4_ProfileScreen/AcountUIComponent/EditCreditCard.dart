// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
// import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
// import 'package:flutter_credit_card/credit_card_form.dart';
// import 'package:flutter_credit_card/credit_card_model.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import '../../../constants.dart';
//
// class EditCreditCardDetails extends StatefulWidget {
//   EditCreditCardDetails({Key key}) : super(key: key);
//
//   _EditCreditCardDetailsState createState() => _EditCreditCardDetailsState();
// }
//
// class _EditCreditCardDetailsState extends State<EditCreditCardDetails> {
//
//
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var data = EasyLocalizationProvider.of(context).data;
//     return EasyLocalizationProvider(
//
//       data: data,
//       child: Scaffold(
//           resizeToAvoidBottomInset: true,
//           appBar: AppBar(
//             title: Text(
//               AppLocalizations.of(context).tr('editDetail'),
//               style: TextStyle(
//                   fontFamily: "Gotik",
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18.5,
//                   letterSpacing: 1.2,
//                   color: Colors.grey),
//             ),
//             centerTitle: true,
//             iconTheme: IconThemeData(color: myPt0),
//             elevation: 0.0,
//           ),
//           body: SafeArea(
//             child: Column(
//               children: <Widget>[
//                 CreditCardWidget(
//                   cardNumber: cardNumber,
//                   expiryDate: expiryDate,
//                   cardHolderName: cardHolderName,
//                   cvvCode: cvvCode,
//                   showBackView: isCvvFocused,
//                   obscureCardNumber: true,
//                   obscureCardCvv: true,
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         CreditCardForm(
//                           formKey: formKey,
//                           obscureCvv: true,
//                           obscureNumber: true,
//                           cardNumberDecoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Number',
//                             hintText: 'XXXX XXXX XXXX XXXX',
//                           ),
//                           expiryDateDecoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Expired Date',
//                             hintText: 'XX/XX',
//                           ),
//                           cvvCodeDecoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'CVV',
//                             hintText: 'XXX',
//                           ),
//                           cardHolderDecoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Card Holder',
//                           ),
//                           onCreditCardModelChange: onCreditCardModelChange,
//                         ),
//                         RaisedButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Container(
//                             margin: const EdgeInsets.all(8),
//                             child: const Text(
//                               'Validate' ,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'halter',
//                                 fontSize: 14,
//                                 package: 'flutter_credit_card',
//                               ),
//                             ),
//                           ),
//                           color: const Color(0xff1b447b),
//                           onPressed: () {
//                             if (formKey.currentState.validate()) {
//                               print('valid!');
//                             } else {
//                               print('invalid!');
//                             }
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),),
//     );
//   }
//
//
//
//   void onCreditCardModelChange(CreditCardModel creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//       print(isCvvFocused);
//     });
//
//     if(cardNumber.isNotEmpty && expiryDate.isNotEmpty && cardHolderName.isNotEmpty && cvvCode.isNotEmpty ) {
//       print("add check logical or directly  navigate to next page");
//     }
//   }
//
//
//
//
//
//
// }
//
