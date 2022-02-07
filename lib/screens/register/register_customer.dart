import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/login/login_screen.dart';
import 'package:pgn_mobile/screens/otp/otp_register.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/language.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterCustomer extends StatefulWidget {
  @override
  RegistCustState createState() => RegistCustState();
}

class RegistCustState extends State<RegisterCustomer> {
  bool _obscure = true;
  TextEditingController phoneNumb = new TextEditingController();
  TextEditingController idCust = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController emailCust = new TextEditingController();
  bool statBtnEmail = true;
  bool statBtnPhoneNumb = false;
  bool visible = false;
  bool btnVisible = true;
  final iv = encrypt.IV.fromUtf8('ujfjL9XWfH0ZoAzi');
  final encrypter = encrypt.Encrypter(encrypt.AES(
      encrypt.Key.fromUtf8('zNsW4kAl4t4PTrtC'),
      mode: encrypt.AESMode.cbc));

  @override
  void initState() {
    super.initState();

    deviceID();
  }

  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<Language>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Registration',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Image.asset(
              'assets/logo_head.png',
              height: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 20),
            child: Center(
                child: Text(
              Translations.of(context).text('ff_guest_home_tv_register_new'),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF427CEF)),
            )),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      statBtnEmail = true;
                      statBtnPhoneNumb = false;
                      phoneNumb.text = '';
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: statBtnEmail == true
                            ? Color(0xFF427CEF)
                            : Color(0xFFF4F4F4)),
                    child: Text(
                      'Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: statBtnEmail == true
                              ? Colors.white
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      statBtnEmail = false;
                      statBtnPhoneNumb = true;
                      emailCust.text = '';
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: statBtnPhoneNumb == true
                            ? Color(0xFF427CEF)
                            : Color(0xFFF4F4F4)),
                    child: Text(
                      Translations.of(context)
                          .text('ff_change_number_et_hint_phone_number'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: statBtnPhoneNumb == true
                              ? Colors.white
                              : Colors.grey),
                    ),
                  ),
                ),
              )
            ],
          ),
          statBtnEmail == true
              ? Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                  child: TextFormField(
                    controller: emailCust,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 35.0,
                        child: TextFormField(
                          enabled: false,
                          initialValue: '+62',
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
                            controller: phoneNumb,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '82212345678',
                              labelText: 'Phone Number',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
            // width: 295,
            child: TextFormField(
              obscureText: _obscure,
              controller: password,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    size: 20.0,
                  ),
                  onPressed: () {
                    setState(() => _obscure = !_obscure);
                  },
                ),
                labelText: 'Password',
              ),
              onSaved: (value) => password.text = value,
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            color: Color(0xFFD3D3D3),
            child: Container(
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10),
              // width: 295,
              child: Text(
                _lang.registDesc,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Visibility(
              maintainAnimation: true,
              maintainState: true,
              visible: visible,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 30.0),
                      child: CircularProgressIndicator())
                ],
              )),
          Visibility(
            visible: btnVisible,
            child: Container(
              height: 50.0,
              margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF427CEF),
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  _lang.register,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (phoneNumb.text == '' && password.text == '') {
                    showToast(
                      Translations.of(context).text('field_input_allert'),
                    );
                  } else {
                    setState(() {
                      visible = true;
                      btnVisible = false;
                    });
                    final encrypted = encrypter.encrypt(password.text, iv: iv);
                    if (emailCust.text.isNotEmpty) {
                      //print('MASUK EMAIL');
                      postRegisterNewCustEmail(context, encrypted.base64);
                    } else {
                      //print('MASUK NUMB');
                      postRegisterNewCustNumber(context, encrypted.base64);
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void postRegisterNewCustEmail(BuildContext context, String password) async {
    final storageCache = FlutterSecureStorage();
    String devicesId = await storageCache.read(key: 'devices_id');
    var responseTokenBarrer =
        await http.post('${UrlCons.mainProdUrl}authentication', body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'client_credentials'
    });
    AuthSalesRegit _auth =
        AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));
    var body = json.encode({
      // "request_code": requestCode,
      // "customer_id": idCust,
      "email": emailCust.text,
      "password": password,
      // "code": codeotp,
    });

    var responseSentOTPRegisResidential =
        await http.post('${UrlCons.mainProdUrl}users/registrations',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${_auth.accessToken}',
              'X-Pgn-Device-Id': devicesId,
            },
            body: body);
    PostDataRegisterPGNUser postOTPRegisterResidential =
        PostDataRegisterPGNUser.fromJson(
            json.decode(responseSentOTPRegisResidential.body));
    if (responseSentOTPRegisResidential.statusCode == 200) {
      setState(() {
        visible = false;
        btnVisible = true;
      });
      registerNewUserAlert(context, 'Silahkan masuk ke halaman login');
    } else {
      setState(() {
        visible = false;
        btnVisible = true;
      });
      registerNewUserAlert(context, postOTPRegisterResidential.message);
    }
  }

  Future<PostRegisterResidential> postRegisterNewCustNumber(
      BuildContext context, String password) async {
    // final _provRegResidential = Provider.of<RegistResidential>(context);

    final storageCache = FlutterSecureStorage();
    String devicesId = await storageCache.read(key: 'devices_id');

    var responseTokenBarrer =
        await http.post('${UrlCons.mainProdUrl}authentication', body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'client_credentials'
    });
    //print('AccessTokens ${responseTokenBarrer.body}');

    AuthSalesRegit _auth =
        AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));
    var bodySentTrans5;
    if (emailCust.text.isNotEmpty) {
      bodySentTrans5 = json.encode({
        // "customer_id": "${idCust.text}",
        "email": emailCust.text,
        "password": "$password",
        "transaction_type_id": 5,
      });
    } else {
      bodySentTrans5 = json.encode({
        // "customer_id": "${idCust.text}",
        "mobile_phone": "62${phoneNumb.text}",
        "password": "$password",
        "transaction_type_id": 5,
      });
    }

    var responseSentOTPRegisResidential =
        await http.post('${UrlCons.mainProdUrl}otp',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${_auth.accessToken}',
              'X-Pgn-Device-Id': devicesId,
            },
            body: bodySentTrans5);
    //print(responseSentOTPRegisResidential.body);
    //print('HASIL OTP NUMB : ${responseSentOTPRegisResidential.body}');
    RegisteraUserPGN postOTPRegisterResidential = RegisteraUserPGN.fromJson(
        json.decode(responseSentOTPRegisResidential.body));

    if (responseSentOTPRegisResidential.statusCode == 200) {
      setState(() {
        visible = false;
        btnVisible = true;
      });
      if (postOTPRegisterResidential.dataRegistUserPGN.otpTransId == '5') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPRegisterForm(
                      numberPhone: '62${phoneNumb.text}',
                      idCust: idCust.text,
                      pass: password,
                      requestCode: postOTPRegisterResidential
                          .dataRegistUserPGN.requestCode,
                      accessToken: _auth.accessToken,
                    )));
      } else {
        setState(() {
          visible = false;
          btnVisible = true;
        });
        successAlert(context, postOTPRegisterResidential.message);
      }
    } else {
      setState(() {
        visible = false;
        btnVisible = true;
      });
      successAlert(context, postOTPRegisterResidential.message);
    }
    // return PostRegisterResidential.fromJson(json.decode(responseRegisResidential.body));
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
