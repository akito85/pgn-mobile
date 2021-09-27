import 'package:flutter/material.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/services/applications.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/language.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pgn_mobile/models/auth_model.dart';

class ForgetPassword extends StatefulWidget {
  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController inaCtrl = new TextEditingController();
  TextEditingController phoneNumberCtrl = new TextEditingController();
  String titleBar, titleButton, titleContent;
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    applic.supportedLocales();
    const TranslationsDelegate();
  }

  onLocaleChange(Locale locale) {
    setState(() {
      applic.supportedLocales();
      const TranslationsDelegate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<Language>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: new Text(
          _lang.forgotPass,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: new Text(
              _lang.forgotPassDesc,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[600]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 35.0,
                  child: TextFormField(
                    // controller: inaCtrl,
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      labelText: 'INA',
                    ),
                    initialValue: '+62',
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: phoneNumberCtrl,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: '82212345678',
                          hintStyle: TextStyle(color: Colors.grey)),
                      onTap: () {
                        setState(() {
                          titleBar = Translations.of(context)
                              .text('title_bar_forgot_password');
                          titleButton = Translations.of(context)
                              .text('ff_forgot_password_bt_send');
                          titleContent = Translations.of(context)
                              .text('ff_forgot_password_tv_instruction_desc');
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 55.0,
              margin: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xFF427CEF),
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                child: new Text(
                  _lang.send,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  fetchPost(context);
                },
              )),
        ],
      ),
    );
  }

  void fetchPost(BuildContext context) async {

    var body = json.encode({'mobile_phone': "62${phoneNumberCtrl.text}"});
    var responseTokenBarrer =
        await http.post('${UrlCons.mainProdUrl}authentication', body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'client_credentials',
    });
    AuthCredClient returnAuthCred =
        AuthCredClient.fromJson(json.decode(responseTokenBarrer.body));
    var responseResetPassword =
        await http.post('${UrlCons.mainProdUrl}users/reset-passwords',
            headers: {
              'Authorization': 'Bearer ${returnAuthCred.accessToken}',
              'Content-Type': 'application/json',
            },
            body: body);
    ResetPass returnResetPass =
        ResetPass.fromJson(json.decode(responseResetPassword.body));
    if (returnResetPass.message == "pgn.phone_number_not_found") {
      _allertSucces(context, 'Phone number not found');
    } else {
      _allertSucces(context, returnResetPass.message);
    }
  }
}

Widget _allertSucces(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color(0xFF427CEF),
                ),
                alignment: Alignment.center,
                height: 40,
                width: 100,
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
         
              },
            )
          ],
        ),
      );
    },
  );
}
