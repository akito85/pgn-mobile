import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/screens/settings/widgets/change_password.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/services/applications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Settings extends StatefulWidget {
  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Settings> {
  SpecificLocalizationDelegate _localeOverrideDelegate;
  bool langSwitch = true;
  bool visible = false;
  String currentLang;
  Color indLangSelected = Color(0xFF9B9B9B);
  Color enLangSelected = Color(0xFF9B9B9B);
  final storageCache = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getLang();
    _localeOverrideDelegate = SpecificLocalizationDelegate(null);

    applic.onLocaleChanged = onLocaleChange;
    if (currentLang == 'id') {
      indLangSelected = Color(0xFF9B9B9B);
      enLangSelected = Color(0xFF73C670);
    } else {
      enLangSelected = Color(0xFF9B9B9B);
      indLangSelected = Color(0xFF73C670);
    }
  }

  getLang() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLang = await storageCache.read(key: 'lang');
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[300],
        primaryColorDark: Colors.blue[800],
        accentColor: Colors.blue[600],
        appBarTheme: AppBarTheme(
          elevation: 5.0,
        ),
        cardTheme: CardTheme(
          elevation: 3.0,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: true,
            title: Text(
              Translations.of(context).text('title_bar_setting'),
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Text(
                    Translations.of(context).text('f_setting_switch_language'),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 35.0,
                          decoration: BoxDecoration(
                            color: indLangSelected,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                bottomLeft: Radius.circular(25.0)),
                          ),
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 9, left: 15.0, right: 15.0),
                              child: Text(
                                'ENG',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () {
                              visible = true;

                              setState(() {
                                indLangSelected = Color(0xFF73C670);
                                enLangSelected = Color(0xFF9B9B9B);
                                changeLang(context, 'en_', 'en');
                                applic.onLocaleChanged(new Locale('en', ''));
                                visible = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 35.0,
                          decoration: BoxDecoration(
                            color: enLangSelected,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)),
                          ),
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 9, left: 15.0, right: 15.0),
                              child: Text(
                                'IND',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () {
                              visible = true;
                              setState(() {
                                enLangSelected = Color(0xFF73C670);
                                indLangSelected = Color(0xFF9B9B9B);
                                changeLang(context, 'id_', 'id');
                                applic.onLocaleChanged(new Locale('id', ''));

                                visible = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider(color: Colors.black),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  Translations.of(context)
                      .text('title_bar_setting_change_password'),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePassword()));
              },
            ),
            Divider(
              color: Colors.black,
            ),
            InkWell(
              onTap: () {
                _signingOff(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  Translations.of(context).text('f_setting_logout'),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Divider(color: Colors.black),
            Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: visible,
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: CircularProgressIndicator()))
                  ],
                )),
          ],
        ),
      ),
      supportedLocales: applic.supportedLocales(),
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }

  void changeINA(String language) {
    applic.onLocaleChanged(new Locale(language, ''));
  }
}

Future<String> _getFCMToken() async {
  final _firebaseMessaging = FirebaseMessaging();
  String fcmTokens;
  await _firebaseMessaging.getToken().then((token) {
    fcmTokens = token;
    return token;
  });
  return fcmTokens;
}

void changeLang(BuildContext context, String title, String lang) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
    final storageCache = FlutterSecureStorage();
  String fcmToken = await _getFCMToken();

  await storageCache.write(key: 'lang', value: lang);
  // prefs.setString('lang', lang);
  var body = json.encode({
    'fcm_token': fcmToken,
    'language': title,
  });
  final responseChangeLang = await http.post(
      'http://192.168.105.184/pgn-mobile-api/v2/firebase_manager/update_fcm_token_language',
      headers: {'Content-Type': 'application/json'},
      body: body);
}

void _signingOff(BuildContext context) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString('user_id', "kosong");
  // prefs.setString('access_token', "kosong");

  final storageCache = FlutterSecureStorage();
  await storageCache.write(key: 'user_id', value: 'kosong');
  await storageCache.write(key: 'access_token', value: 'kosong');
  // storageCache.deleteAll();
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (Route<dynamic> route) => false,
  );
}
