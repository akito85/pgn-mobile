import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';

import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/otp/otp_reset_numb.dart';
import 'dart:async';

import 'package:pgn_mobile/services/language.dart';
import 'package:provider/provider.dart';

class LoginChangeNumb extends StatefulWidget {
  @override
  ChangeNumbState createState() => ChangeNumbState();
}

class ChangeNumbState extends State<LoginChangeNumb> {
  TextEditingController initialLoc = TextEditingController();
  TextEditingController phoneNumbCtrl = TextEditingController();
  bool btnChange = true;
  bool visible = false;

  Widget build(BuildContext context) {
    final _lang = Provider.of<Language>(context);
    initialLoc.text = '+62';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          _lang.titleChangeNumb,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
              child: Text(
                _lang.descChangeNumb,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 35.0,
                    child: TextField(
                      enabled: false,
                      controller: initialLoc,
                      decoration: InputDecoration(
                        labelText: 'INA',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Expanded(
                    child: Container(
                      // width: 295,
                      child: TextFormField(
                        controller: phoneNumbCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: _lang.hintChangeNumb,
                          fillColor: Color(0xFF427CEF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: btnChange,
              child: Container(
                height: 45.0,
                margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xFF427CEF),
                ),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text(
                    _lang.btnChangeNumb,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      btnChange = false;
                      visible = true;
                    });
                    chagePhoneNumb(context);
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
                        margin: EdgeInsets.only(top: 20, bottom: 30),
                        child: CircularProgressIndicator())
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void chagePhoneNumb(BuildContext context) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String devicesId = await storageCache.read(key: 'devices_id');
    var body = json.encode({
      "mobile_phone": "62${phoneNumbCtrl.text}",
      'transaction_type_id': 1,
    });
    var responseChangeNumb = await http.post('${UrlCons.mainProdUrl}otp',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'X-Pgn-Device-Id': devicesId,
        },
        body: body);
    RegisteraUserPGN postOTPChangePass = RegisteraUserPGN.fromJson(
      json.decode(responseChangeNumb.body),
    );
    if (responseChangeNumb.statusCode == 200) {
      setState(() {
        btnChange = true;
        visible = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPResetNumb(
              numberPhone: '62${phoneNumbCtrl.text}',
              requestCode: postOTPChangePass.dataRegistUserPGN.requestCode,
            ),
          ));
    } else {
      setState(() {
        btnChange = true;
        visible = false;
      });
      showToast(postOTPChangePass.message);
    }
  }
}