import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/models/otp_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/language.dart';

class OTPForm extends StatefulWidget {
  OTPForm({this.userTypes});
  final String userTypes;
  @override
  OTPFormState createState() => OTPFormState(userTypes);
}

class OTPFormState extends State<OTPForm> {
  OTPFormState(this.userTypes);
  String userTypes;
  TextEditingController otpCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<Language>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _lang.verifikasi,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(_lang.descVer),
          ),
          Container(
            child: TextField(
              controller: otpCtrl,
              keyboardType: TextInputType.number,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(5.0, 7.0, 0.0, 15.0),
                  child: Text(
                    _lang.verUbahNo,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )),
              Expanded(
                child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 7.0, 25.0, 15.0),
                    child: Text(
                      _lang.kirimUlangNo,
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    )),
              ),
            ],
          ),
          Container(
              height: 50.0,
              margin: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Theme.of(context).primaryColor,
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  _lang.konfirmasi,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              )),
        ],
      ),
    );
  }

  Future<Otp> postOtpForm(BuildContext context, String codeotp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    String devicesId = prefs.getString('devices_id');
    String requestCode = prefs.getString('request_code');
    String nextOtpTypeId = prefs.getString('next_otp_type_id');

    var responseOtpForm =
        await http.post('${UrlCons.mainProdUrl}users/devices', headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'X-Pgn-Device-Id': '$devicesId'
    }, body: {
      'transaction_type_id ': '$nextOtpTypeId',
      'code': '$codeotp',
      'request_code': '$requestCode'
    });
    Otp _otp = Otp.fromJson(json.decode(responseOtpForm.body));
    if (_otp.status == 'true') {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {}
    return Otp.fromJson(json.decode(responseOtpForm.body));
  }
}
