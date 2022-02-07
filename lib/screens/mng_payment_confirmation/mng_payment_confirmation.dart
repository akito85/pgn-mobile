import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/payment_confirmation_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/mng_payment_confirmation/mng_payment_confirmation_detail.dart';
import 'package:pgn_mobile/screens/otp/otp_register.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'dart:convert';

class MngPaymentConf extends StatefulWidget {
  @override
  MngPaymentConfState createState() => MngPaymentConfState();
}

class MngPaymentConfState extends State<MngPaymentConf> {
  TextEditingController _searchQuery = TextEditingController();
  bool visible = false;
  bool btnClick = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          Translations.of(context).text('pc_tab_title'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 40.0, left: 15.0),
              child: Text(
                'Payment Search',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff427CEF),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 10.0, left: 15.0),
                child: Text(
                  Translations.of(context).text('f_household_invoice_form_tv'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Image.asset(
              'assets/search.png',
              height: 200.0,
              width: 200.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 75.0, right: 75.0),
            child: Material(
              elevation: 8,
              shadowColor: Colors.grey[50],
              borderRadius: BorderRadius.circular(15),
              child: TextField(
                controller: _searchQuery,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: Translations.of(context)
                      .text('f_household_invoice_form_et'),
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey[50], width: 2.0),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: btnClick,
            child: Container(
              height: 50.0,
              margin: EdgeInsets.fromLTRB(75.0, 25.0, 75.0, 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xff427CEF),
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  Translations.of(context).text('f_household_invoice_form_bt'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    visible = true;
                    btnClick = false;
                  });
                  if (_searchQuery.text.isNotEmpty) {
                    getCustomerPayment(context, _searchQuery.text);
                  } else {
                    showToast(
                        Translations.of(context).text('field_input_allert'));
                    setState(() {
                      visible = false;
                      btnClick = true;
                    });
                  }
                },
              ),
            ),
          ),
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: visible,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 30.0),
                      child: CircularProgressIndicator())
                ],
              )),
        ],
      ),
    );
  }

  void getCustomerPayment(BuildContext context, String custID) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseCustomerPayment = await http
        .get('${UrlCons.mainProdUrl}customers/$custID/payment', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });
    //print('RETURN BODY : ${responseCustomerPayment.body}');
    MngPaymentModel _customerPayment =
        MngPaymentModel.fromJson(json.decode(responseCustomerPayment.body));
    // //print('TIPENYA : ${_customerInvoice.data[0].type}');
    if (responseCustomerPayment.statusCode != 200) {
      setState(() {
        visible = false;
        btnClick = true;
      });
      successAlert(context, _customerPayment.message);
    } else if (responseCustomerPayment.statusCode == 200) {
      setState(() {
        visible = false;
        btnClick = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerPaymentConfirmation(
              mngPaymentModel: _customerPayment, idCust: custID),
        ),
      );
    }
  }

  Future<bool> successAlert(BuildContext context, String message) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
    );
    return Alert(
      context: context,
      style: alertStyle,
      title: "Information !",
      content: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            '$message' ?? '',
            style: TextStyle(
                color: Color(0xFF707070),
                fontSize: 17,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10)
        ],
      ),
      buttons: [
        DialogButton(
          width: 130,
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.green,
          child: Text(
            "OK",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }
}
