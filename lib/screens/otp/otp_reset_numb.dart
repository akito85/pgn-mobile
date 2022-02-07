import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/models/otp_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart' as otp;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/painting.dart' as painting;

class OTPResetNumb extends StatefulWidget {
  final String numberPhone, requestCode;
  OTPResetNumb({
    this.numberPhone,
    this.requestCode,
  });
  @override
  OTPChangeNumbState createState() =>
      OTPChangeNumbState(numberPhone, requestCode);
}

class OTPChangeNumbState extends State<OTPResetNumb> {
  final String numberPhone, requestCode;
  OTPChangeNumbState(this.numberPhone, this.requestCode);
  String newNumber;
  bool visible = false;
  bool btnVisible = true;
  TextEditingController otpCtrl = new TextEditingController();
  // StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
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
        //print(timer.tick);
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
    // String numberPhones = await storageCache.read(key: 'user_mobile_otp') ?? "";
    setState(() {
      // numberPhone = numberPhones;
      newNumber = numberPhone;
      //print('USRER TYPE GET AUTH : $numberPhone');
      for (int i = 0; i < 8; i++) {
        newNumber = replaceCharAt(newNumber, i, "*");
        //print("PHONE_NUMBER_LOOP:$newNumber");
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
    // final _lang = Provider.of<Language>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF427CEF),
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
              '${Translations.of(context).text('ff_otp_tv_instruction_desc')} (+$newNumber)',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: otp.PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                animationType: otp.AnimationType.fade,
                // validator: (v) {
                //   if (v.length < 3) {
                //     return "I'm from validator";
                //   } else {
                //     return null;
                //   }
                // },
                pinTheme: otp.PinTheme(
                  shape: otp.PinCodeFieldShape.underline,
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  disabledColor: Colors.white,
                  selectedFillColor: Colors.white,
                  selectedColor: Colors.white,
                  activeFillColor: Color(0xFF427CEF),
                  // activeFillColor: hasError ? Colors.orange : Colors.white,
                ),
                cursorColor: Colors.black,
                textStyle: TextStyle(fontSize: 20, height: 1.6),
                backgroundColor: Colors.white,
                enableActiveFill: true,
                // errorAnimationController: errorController,
                controller: otpCtrl,
                keyboardType: TextInputType.number,
                onCompleted: (v) {
                  //print("Completed");
                },
                onChanged: (value) {
                  //print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  //print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
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
                    '',
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
                        Translations.of(context).text('ff_otp_bt_resend'),
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
                    Translations.of(context).text('ff_otp_bt_confirmation'),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    //print('INI PIN NYA ${otpCtrl.text}');
                    postOtpForm(context, currentText);
                    setState(() {
                      visible = true;
                      btnVisible = false;
                    });
                    // Navigator.pop(context);
                    // Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                )),
          ),
        ],
      ),
    );
  }

  Future<AuthSales> postResendOtp(BuildContext context) async {
    final storageCache = FlutterSecureStorage();

    String accessToken = await storageCache.read(key: 'access_token');
    String devicesId = await storageCache.read(key: 'devices_id');
    var bodySentTrans5 = json.encode({
      "mobile_phone": numberPhone,
      "transaction_type_id": 1,
    });

    var responseSentOTPRegisResidential =
        await http.post('${UrlCons.mainProdUrl}otp',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
              'X-Pgn-Device-Id': devicesId,
            },
            body: bodySentTrans5);
    //print('HASIL RESEND : ${responseSentOTPRegisResidential.body}');
    if (responseSentOTPRegisResidential.statusCode == 200) {
      showToast('Resend Succed !');
    }
  }

  Future<Otp> postOtpForm(BuildContext context, String codeotp) async {
    final storageCache = FlutterSecureStorage();

    String accessToken = await storageCache.read(key: 'access_token');
    // //print('ACCESS TOKEN : $accessToken');
    String devicesId = await storageCache.read(key: 'devices_id');

    var body = json.encode({
      "request_code": requestCode,
      "mobile_phone": numberPhone,
      "code": codeotp,
    });
    var responseSentOTPRegisResidential =
        await http.post('${UrlCons.mainProdUrl}users/phones',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
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
      await storageCache.write(key: 'auth_status', value: 'Login');
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() {
        visible = false;
        btnVisible = true;
      });
      showToast(postOTPRegisterResidential.message);
    }
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
  );
}
