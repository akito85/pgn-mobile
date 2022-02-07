import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/detail_usage_smartmeter.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/otp/otp_register.dart';
import 'package:pgn_mobile/screens/smartmeter_mng/smarmeter_mng_chart.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'dart:convert';

class SmartmeterMng extends StatefulWidget {
  @override
  SmartmeterMngState createState() => SmartmeterMngState();
}

class SmartmeterMngState extends State<SmartmeterMng> {
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
          'Smartmeter',
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
                'Smartmeter Search',
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
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    String title = '$currentYear$currentMonth';
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseUsageChar = await http.get(
      '${UrlCons.mainProdUrl}customers/$custID/gas-usages/smart-meter-chart/$title',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang,
      },
    );
    //print('RETURN DATA SMART METER ${responseUsageChar.body}');
    ChartUsageDetailSmartmeter _getSmartmeter =
        ChartUsageDetailSmartmeter.fromJson(
            json.decode(responseUsageChar.body));
    //print('RETURN DATA MODEL ${_getSmartmeter.data.length}');
    // //print('TIPENYA : ${_customerInvoice.data[0].type}');
    if (responseUsageChar.statusCode != 200) {
      setState(() {
        visible = false;
        btnClick = true;
      });
      successAlert(context, _getSmartmeter.message);
    } else if (responseUsageChar.statusCode == 200) {
      setState(() {
        visible = false;
        btnClick = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsageDetailMngRTPK(idCust: custID),
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
