import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/language.dart';
import 'package:pgn_mobile/models/change_password.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ChangeNumb extends StatefulWidget {
  @override
  ChangeNumbState createState() => ChangeNumbState();
}

class ChangeNumbState extends State<ChangeNumb> {
  TextEditingController initialLoc = TextEditingController();
  TextEditingController phoneNumbCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<Language>(context);
    initialLoc.text = '+62';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          _lang.changeNumb,
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
                _lang.changeNumbDesc,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.justify,
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
                  Container(
                    width: 295,
                    child: TextFormField(
                      controller: phoneNumbCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: _lang.phonNumb,
                        fillColor: Color(0xFF427CEF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 45.0,
              margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xFF427CEF),
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  _lang.change,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<ChangePhoneNumb> chagePhoneNumb(
    BuildContext context, String phoneNumb) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  var responseChangeNumb =
      await http.post('${UrlCons.prodRelyonUrl}otp', headers: {
    'Authorization': 'Bearer $accessToken'
  }, body: {
    'transaction_type_id': 4,
  });
}
