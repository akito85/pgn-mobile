import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';

import 'package:pgn_mobile/services/register_residential.dart';
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
  final iv = encrypt.IV.fromUtf8('ujfjL9XWfH0ZoAzi');
  final encrypter = encrypt.Encrypter(encrypt.AES(
      encrypt.Key.fromUtf8('zNsW4kAl4t4PTrtC'),
      mode: encrypt.AESMode.cbc));

  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<Language>(context);
    return Scaffold(
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
          Container(
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
            child: TextFormField(
              controller: idCust,
              decoration: InputDecoration(
                labelText: _lang.idPelanggan,
              ),
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
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
          Container(
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
                final encrypted = encrypter.encrypt(password.text, iv: iv);
                postRegisterNewCust(context, encrypted.base64);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<PostRegisterResidential> postRegisterNewCust(
      BuildContext context, String password) async {
    final _provRegResidential = Provider.of<RegistResidential>(context);
    var responseTokenBarrer =
        await http.post('${UrlCons.mainProdUrl}authentication', body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'client_credentials'
    });
    print('AccessTokens ${responseTokenBarrer.body}');
    AuthSalesRegit _auth =
        AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));
    var body = json.encode({
      "request_code": " ",
      "customer_id": "${idCust.text}",
      "mobile_phone": "62${phoneNumb.text}",
      "password": "$password",
      "code": " ",
    });
    var responseRegisResidential =
        await http.post('${UrlCons.mainProdUrl}users/registrations',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${_auth.accessToken}'
            },
            body: body);
    print(responseRegisResidential.body);
    // if (responseRegisResidential.statusCode == 200) {
    PostRegisterResidential postRegisterResidential =
        PostRegisterResidential.fromJson(
            json.decode(responseRegisResidential.body));
    successAlert(context, postRegisterResidential.message);
    // }
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
