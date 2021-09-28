import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/models/otp_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/dashboard/dashboard.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/language.dart';

class OTPForm extends StatefulWidget {
  @override
  OTPFormState createState() => OTPFormState();
}

class OTPFormState extends State<OTPForm> {
  String numberPhone;
  String newNumber;
  bool visible = false;
  bool btnVisible = true;
  TextEditingController otpCtrl = new TextEditingController();
  final storageCache = new FlutterSecureStorage();
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 600;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  Timer _timer;
  startTimeout([int milliseconds]) {
    var duration = interval;
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getCred();
    startTimeout();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void getCred() async {
    String numberPhones = await storageCache.read(key: 'user_mobile_otp') ?? "";
    setState(() {
      numberPhone = numberPhones;
      newNumber = numberPhone;
      print('USRER TYPE GET AUTH : $numberPhone');
      for (int i = 0; i < 8; i++) {
        newNumber = replaceCharAt(newNumber, i, "*");
        print("PHONE_NUMBER_LOOP:$newNumber");
      }
    });
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<Language>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[550],
        title: Text(
          Translations.of(context).text('title_bar_otp') ?? '',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15, 25, 15, 20),
            child: Text(
              '${_lang.descVer} (+$newNumber)',
              style: TextStyle(fontSize: 18),
            ),
          ),
          // Container(
          //   child: TextField(
          //     controller: otpCtrl,
          //     keyboardType: TextInputType.number,
          //   ),
          // ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.underline,
                outlineBorderRadius: 15,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  otpCtrl.text = pin;
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  otpCtrl.text = pin;
                  print("Completed: " + pin);
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Translations.of(context).text('ff_otp_tv_code_expiration'),
                  ),
                  Text(timerText),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(25.0, 55.0, 0.0, 10.0),
                  child: Text(
                    _lang.verUbahNo,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF427CEF),
                    ),
                  )),
              Expanded(
                child: InkWell(
                  onTap: () {
                    postResendOtp(context);
                  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(5.0, 55.0, 25.0, 10.0),
                      child: Text(
                        _lang.kirimUlangNo,
                        style: TextStyle(
                          color: Color(0xFF427CEF),
                          fontSize: 12.0,
                        ),
                      )),
                ),
              ),
            ],
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
          Visibility(
            visible: btnVisible,
            child: Container(
              height: 50.0,
              margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Color(0xFF427CEF),
              ),
              child: MaterialButton(
                // color: color: Color(0xFF427CEF),,
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  _lang.konfirmasi ?? '',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  print('INI PIN NYA ${otpCtrl.text}');
                  setState(() {
                    visible = true;
                    btnVisible = false;
                  });
                  postOtpForm(context, otpCtrl.text);

                  // Navigator.pop(context);
                  // Navigator.pushReplacementNamed(context, '/dashboard');
                },
              ),
            ),
          ),

          Container(
              height: 50.0,
              margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.grey[400],
              ),
              child: MaterialButton(
                // color: color: Color(0xFF427CEF),,
                minWidth: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bypass Otp',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Tombol ini hanya ada di beta untuk keperluan testing !',
                      style: TextStyle(color: Colors.black, fontSize: 11),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              )),
        ],
      ),
    );
  }

  Future<AuthSales> postResendOtp(BuildContext context) async {
    final storageCache = FlutterSecureStorage();

    String accessToken = await storageCache.read(key: 'access_token');
    print('ACCESS TOKEN : $accessToken');
    String devicesId = await storageCache.read(key: 'devices_id');
    String userName = await storageCache.read(key: 'user_name_login');
    String pass = await storageCache.read(key: 'pass_login');

    var responseTokenBarrer =
        await http.post('${UrlCons.mainProdUrl}authentication', headers: {
      'X-Pgn-Device-Id': devicesId
      // 'X-Pgn-Device-Id': "jnskdoandsoando"
    }, body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'password',
      'username': userName,
      'password': pass
    });
    print('HASIL RESEND : ${responseTokenBarrer.body}');
    if (responseTokenBarrer.statusCode == 200) {
      showToast('Resend Succed !');
    }
  }

  Future<Otp> postOtpForm(BuildContext context, String codeotp) async {
    final storageCache = FlutterSecureStorage();

    String accessToken = await storageCache.read(key: 'access_token');
    print('ACCESS TOKEN : $accessToken');
    String devicesId = await storageCache.read(key: 'devices_id');
    String requestCode = await storageCache.read(key: 'request_code');
    String nextOtpTypeId = await storageCache.read(key: 'next_otp_type_id');

    var responseOtpForm =
        await http.post('${UrlCons.mainProdUrl}users/devices', headers: {
      'Authorization': 'Bearer $accessToken',
      // 'Content-Type': 'application/json',
      'X-Pgn-Device-Id': '$devicesId'

      // 'X-Pgn-Device-Id': 'jnskdoandsoando'
    }, body: {
      'transaction_type_id ': '$nextOtpTypeId',
      'code': '$codeotp',
      'request_code': '$requestCode'
    });
    // print('HASIL OTP : ${responseOtpForm.body}');
    // print('RE CODE : $requestCode');
    // print('Dev id : $devicesId');
    // print('Next OTP : $nextOtpTypeId');
    setState(() {
      visible = false;
      btnVisible = true;
    });
    Otp _otp = Otp.fromJson(json.decode(responseOtpForm.body));
    if (_otp.status == true) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else if (_otp.status == 'Device is registered successfully') {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      accessTokenAlert(context, _otp.message);
    }
    return Otp.fromJson(json.decode(responseOtpForm.body));
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
  );
}
