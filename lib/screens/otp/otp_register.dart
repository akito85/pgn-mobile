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
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/painting.dart' as painting;

class OTPRegisterForm extends StatefulWidget {
  final String numberPhone, idCust, pass, requestCode, accessToken;
  OTPRegisterForm(
      {this.idCust,
      this.numberPhone,
      this.pass,
      this.requestCode,
      this.accessToken});
  @override
  OTPRegisterFormState createState() =>
      OTPRegisterFormState(numberPhone, idCust, pass, requestCode, accessToken);
}

class OTPRegisterFormState extends State<OTPRegisterForm> {
  final String numberPhone, idCust, pass, requestCode, accessToken;
  OTPRegisterFormState(this.numberPhone, this.idCust, this.pass,
      this.requestCode, this.accessToken);
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
    // String numberPhones = await storageCache.read(key: 'user_mobile_otp') ?? "";
    setState(() {
      // numberPhone = numberPhones;
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
    // final _lang = Provider.of<Language>(context);
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
              '${Translations.of(context).text('ff_otp_tv_instruction_desc')} (+$newNumber)',
              style: TextStyle(fontSize: 18),
            ),
          ),
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
                    Translations.of(context).text('ff_otp_bt_change_number'),
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
                    print('INI PIN NYA ${otpCtrl.text}');
                    postOtpForm(context, otpCtrl.text);
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
    // final storageCache = FlutterSecureStorage();

    // String accessToken = await storageCache.read(key: 'access_token');
    print('ACCESS TOKEN : $accessToken');
    String devicesId = await storageCache.read(key: 'devices_id');
    var bodySentTrans5 = json.encode({
      "customer_id": idCust,
      "mobile_phone": numberPhone,
      "password": pass,
      "transaction_type_id": 5,
    });

    var responseSentOTPRegisResidential =
        await http.post('${UrlCons.mainProdUrl}otp',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
              'X-Pgn-Device-Id': devicesId,
            },
            body: bodySentTrans5);
    print('HASIL RESEND : ${responseSentOTPRegisResidential.body}');
    if (responseSentOTPRegisResidential.statusCode == 200) {
      showToast('Resend Succed !');
    }
  }

  Future<Otp> postOtpForm(BuildContext context, String codeotp) async {
    final storageCache = FlutterSecureStorage();

    // String accessToken = await storageCache.read(key: 'access_token');
    // print('ACCESS TOKEN : $accessToken');
    String devicesId = await storageCache.read(key: 'devices_id');

    var body = json.encode({
      "request_code": requestCode,
      "customer_id": idCust,
      "mobile_phone": numberPhone,
      "password": pass,
      "code": codeotp,
    });
    var responseSentOTPRegisResidential =
        await http.post('${UrlCons.mainProdUrl}users/registrations',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
              'X-Pgn-Device-Id': devicesId,
            },
            body: body);
    // print('HASIL OTP : ${responseSentOTPRegisResidential.body}');
    // print('RE CODE : $requestCode');
    // print('Dev id : $devicesId');
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
}

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
  );
}

Future<bool> registerNewUserAlert(BuildContext context, String message) {
  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: painting.TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: painting.TextStyle(
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
          style: painting.TextStyle(
              // color: painting.Color.fromRGBO(255, 255, 255, 0),
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
        onPressed: () async {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        },
        color: Colors.green,
        child: Text(
          "OK",
          style: painting.TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )
    ],
  ).show();
}
