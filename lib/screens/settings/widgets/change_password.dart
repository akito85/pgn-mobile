import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/dashboard/dashboard.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:encrypt/encrypt.dart' as encrypt;

class ChangePassword extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final iv = encrypt.IV.fromUtf8('ujfjL9XWfH0ZoAzi');
  final encrypter = encrypt.Encrypter(encrypt.AES(
      encrypt.Key.fromUtf8('zNsW4kAl4t4PTrtC'),
      mode: encrypt.AESMode.cbc));
  TextEditingController oldPassCtrl = new TextEditingController();
  TextEditingController newPassCtrl = new TextEditingController();
  TextEditingController newValidatePassCtrl = new TextEditingController();
  TextEditingController textAlertCtrl = new TextEditingController();
  String _password;
  bool btnSave = true;
  bool visible = false;
  bool _obscure = true;
  bool textPassVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Change Password',
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
                // width: 295,
                child: TextFormField(
                  obscureText: _obscure,
                  controller: oldPassCtrl,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        size: 20.0,
                      ),
                      onPressed: () {
                        setState(() => _obscure = !_obscure);
                      },
                    ),
                    labelText: 'Existing Password',
                  ),
                  onSaved: (value) => _password = value,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: TextFormField(
                  controller: newPassCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        size: 20.0,
                      ),
                      onPressed: () {
                        setState(() => _obscure = !_obscure);
                      },
                    ),
                    labelText: 'New Password',
                  ),
                  onSaved: (value) => _password = value,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                // width: 295,
                child: TextFormField(
                  onEditingComplete: () {
                    if (newValidatePassCtrl.text != newPassCtrl.text) {
                      setState(() {
                        textPassVisible = true;
                        textAlertCtrl.text = "Password baru tidak sesuai !";
                      });
                    } else {
                      setState(() {
                        textPassVisible = false;
                      });
                    }
                  },
                  controller: newValidatePassCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        size: 20.0,
                      ),
                      onPressed: () {
                        setState(() => _obscure = !_obscure);
                      },
                    ),
                    labelText: 'Re-type new password',
                  ),
                  onSaved: (value) => _password = value,
                ),
              ),
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: textPassVisible,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Text(
                    textAlertCtrl.text,
                    style: TextStyle(color: Color(0xFFEA4B4B), fontSize: 12),
                  ),
                ),
              ),
              Visibility(
                visible: btnSave,
                child: Container(
                    height: 45.0,
                    margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Color(0xFF427CEF),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (oldPassCtrl.text == "") {
                          setState(() {
                            textPassVisible = true;
                            textAlertCtrl.text =
                                "Password lama tidak boleh kosong!";
                          });
                        } else if (newPassCtrl.text == "") {
                          setState(() {
                            textPassVisible = true;
                            textAlertCtrl.text =
                                "Password baru tidak boleh kosong!";
                          });
                        } else if (newValidatePassCtrl.text == "") {
                          setState(() {
                            textPassVisible = true;
                            textAlertCtrl.text =
                                "Validasi password tidak boleh kosong!";
                          });
                        } else {
                          final encryptedOldPass =
                              encrypter.encrypt(oldPassCtrl.text, iv: iv);
                          final encryptedValidatePass = encrypter
                              .encrypt(newValidatePassCtrl.text, iv: iv);
                          print('Pass sekarang: ${encryptedOldPass.base64}');
                          print('Pas validate ${encryptedValidatePass.base64}');
                          textPassVisible = false;
                          setState(() {
                            btnSave = false;
                            visible = true;
                          });
                          changePassword(context, encryptedOldPass.base64,
                              encryptedValidatePass.base64);
                        }
                      },
                    )),
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
        ));
  }

  Future<ChangePassword> changePassword(
      BuildContext context, String oldPassword, String validatePass) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    var responseChangePass = await http.post(
        '${UrlCons.mainProdUrl}change-password',
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {'old_password': oldPassword, 'new_password': validatePass});
    print('STATUS ${responseChangePass.body}');
    if (responseChangePass.contentLength == 0) {
      setState(() {
        btnSave = true;
        visible = false;
      });
      _allertSucces(context, 'Success, Your password has been changed');
    } else {
      setState(() {
        btnSave = true;
        visible = false;
      });
      _allertSucces(context, 'Failed, Your password not match!');
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              },
            )
          ],
        ),
      );
    },
  );
}
