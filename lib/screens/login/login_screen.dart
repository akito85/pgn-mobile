import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/url_cons.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pgn_mobile/screens/forget_password/forget_password.dart';
import 'package:device_info/device_info.dart';
import 'package:pgn_mobile/services/user_credientials.dart';
import 'package:pgn_mobile/services/language.dart';
import 'package:pgn_mobile/models/cust_profile_model.dart' as customer;
import 'dart:io' show Platform;
import 'package:pgn_mobile/services/applications.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui' as ui;

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String password;
  bool _obscurePass = true;
  bool visible = false;
  bool btnVisible = true;
  String numbPhone = '';

  final iv = encrypt.IV.fromUtf8('ujfjL9XWfH0ZoAzi');
  final encrypter = encrypt.Encrypter(encrypt.AES(
      encrypt.Key.fromUtf8('zNsW4kAl4t4PTrtC'),
      mode: encrypt.AESMode.cbc));
  final _firebaseMessaging = FirebaseMessaging();
  String fcmToken;
  SpecificLocalizationDelegate _localeOverrideDelegate;
  final storageCache = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    deviceID();
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    applic.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  Future<String> _getFCMTokenDailyUsage(
      String userGroupID, String areaID) async {
    String fcmTokens;
    //on for testing firebase
    // _firebaseMessaging.subscribeToTopic('tester_popup');
    ///////////////////////////////////////////
    _firebaseMessaging.subscribeToTopic('daily_usage');
    _firebaseMessaging.subscribeToTopic('daily_payment');
    _firebaseMessaging.subscribeToTopic('monthly_invoice');
    _firebaseMessaging.subscribeToTopic('promosi_${userGroupID}_$areaID');
    await _firebaseMessaging.getToken().then((token) {
      setState(() {
        fcmTokens = token;
      });
      fcmTokens = token;
      return token;
    });
    return fcmTokens;
  }

  Future<String> _getFCMToken() async {
    String fcmTokens;
    await _firebaseMessaging.getToken().then((token) {
      setState(() {
        fcmTokens = token;
      });
      fcmTokens = token;
      return token;
    });
    return fcmTokens;
  }

  Widget build(BuildContext context) {
    final _lang = Provider.of<Language>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg-image-01@2x.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 30.0),
                height: 120,
                child: Image.asset('assets/icon_launch.png'),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
              ),
              margin: EdgeInsets.only(top: 180),
              elevation: 5,
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 15.0),
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/logo_head.png'),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 15),
                      child: Text('Welcome to PGN Mobile' ?? '',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF427CEF),
                          ))),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Text(
                        'Check your activities, contract, financial solutions and profile.' ??
                            '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500]),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
                    child: Material(
                      elevation: 8,
                      shadowColor: Colors.grey[50],
                      borderRadius: BorderRadius.circular(15),
                      child: TextField(
                        onTap: () {
                          setState(() {
                            _lang.btnForgotPass;
                          });
                        },
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: 'Email / Full Number',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.grey[50], width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
                    child: Material(
                      elevation: 8,
                      shadowColor: Colors.grey[50],
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _obscurePass,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() => _obscurePass = !_obscurePass);
                            },
                          ),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.grey[50], width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      deviceID();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                    },
                    child: Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(right: 30, top: 10),
                        child: Text(
                          _lang.btnForgotPass ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF427CEF),
                          ),
                        )),
                  ),
                  Visibility(
                    visible: btnVisible,
                    child: Container(
                        height: 50.0,
                        margin: EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: Color(0xFF427CEF),
                        ),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            password = 'corp.PGN';
                            final encrypted = encrypter
                                .encrypt(passwordController.text, iv: iv);
                            print('PASSWORD : ${encrypted.base64}');
                            setState(() {
                              visible = true;
                              btnVisible = false;
                            });

                            fetchPost(context, encrypted.base64,
                                usernameController.text);
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
                              margin: EdgeInsets.only(top: 15, bottom: 30),
                              child: CircularProgressIndicator())
                        ],
                      )),
                  // InkWell(
                  //   onTap: () {
                  //     // deviceID();
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => ForgetPassword()));
                  //   },
                  //   child: Container(
                  //       alignment: Alignment.center,
                  //       margin: EdgeInsets.only(top: 35),
                  //       child: Text(
                  //         'Terms & Conditions' ?? '',
                  //         style: TextStyle(
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w500,
                  //           color: Color(0xFF427CEF),
                  //         ),
                  //       )),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<AuthSales> fetchPost(
      BuildContext context, String password, String username) async {
    String deviceId = await storageCache.read(key: 'devices_id');
    String usernames = '';
    print('MASUK SINI USERNAMEs ${username[0]}');
    if (username[0] == '0') {
      print('MASUK SINI USERNAME');
      usernames = '62${username.substring(1)}';
      print('INI USERNYA : $usernames');
    } else {
      print('MASUK SINI USERNAMEs');
      usernames = username;
    }
    var responseTokenBarrer =
        await http.post('${UrlCons.mainProdUrl}authentication', headers: {
      'X-Pgn-Device-Id': deviceId
      // 'X-Pgn-Device-Id': "jnskdoandsoando"
    }, body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'password',
      'username': usernames,
      'password': password
    });
    print('HASIL LOGIN ${responseTokenBarrer.body}');
    if (responseTokenBarrer.statusCode == 401) {
      setState(() {
        visible = false;
        btnVisible = true;
      });
      successAlert(context, "The user credentials were incorrect.");
    } else if (responseTokenBarrer.statusCode == 504) {
      setState(() {
        visible = false;
        btnVisible = true;
      });
      successAlert(context, "Gagal menghubungi server");
    } else if (responseTokenBarrer.statusCode == 200) {
      AuthSales _auth =
          AuthSales.fromJson(json.decode(responseTokenBarrer.body));
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        fcmToken = await _getFCMToken();
      });

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        numbPhone = _auth.user.userMobilePhone;
      });
      await storageCache.write(key: 'auth_status', value: 'Login');
      await storageCache.write(key: 'user_name_login', value: username);
      await storageCache.write(key: 'user_name', value: _auth.user.userName);
      await storageCache.write(key: 'pass_login', value: password);
      await storageCache.write(
          key: 'next_action', value: _auth.verificationStatus.nextAction);
      await storageCache.write(
          key: 'next_otp_type_id',
          value: _auth.verificationStatus.nextOtpTypeId);
      await storageCache.write(
          key: 'request_code', value: _auth.verificationStatus.requestCode);
      await storageCache.write(key: 'access_token', value: _auth.accessToken);
      if (_auth.products != null) {
        await storageCache.write(
            key: 'products',
            value: _auth.products.length != 0 ? _auth.products[0].name : '-');
      }

      if (_auth.user.userType == 2 && _auth.user.userGroupId == "11") {
        // print('1. MASUK KE SINI ${_auth.customer.custName}');

        await storageCache.write(
            key: 'lang', value: ui.window.locale.languageCode);
        await storageCache.write(key: 'token_type', value: _auth.tokenType);
        await storageCache.write(
            key: 'user_mobile_otp', value: _auth.user.userMobilePhone);

        await storageCache.write(
            key: 'next_action', value: _auth.verificationStatus.nextAction);
        await storageCache.write(
            key: 'next_otp_type_id',
            value: _auth.verificationStatus.nextOtpTypeId);
        await storageCache.write(
            key: 'request_code', value: _auth.verificationStatus.requestCode);

        await storageCache.write(
            key: 'customer_id', value: _auth.customer.custId);
        await storageCache.write(
            key: 'user_name_cust', value: _auth.customer.custName);
        await storageCache.write(key: 'user_id', value: _auth.user.userID);

        await storageCache.write(
            key: 'user_email', value: _auth.user.userEmail);
        await storageCache.write(
            key: 'user_type', value: _auth.user.userType.toString());
        await storageCache.write(
            key: 'usergroup_id', value: _auth.user.userGroupId);
        await storageCache.write(
            key: 'customer_groupId', value: _auth.customer.groupId.toString());

        setState(() {
          Provider.of<UserCred>(context).userCred(
              accessToken: _auth.accessToken,
              tokenType: _auth.tokenType,
              verStatusNextAction: _auth.verificationStatus.nextAction,
              verStatusOtpTypeId: _auth.verificationStatus.nextOtpTypeId,
              verStatusRequestCode: _auth.verificationStatus.requestCode,
              custId: _auth.customer.custId ?? "",
              custName: _auth.customer.custName ?? "",
              userName: _auth.user.userName,
              userId: _auth.user.userID,
              userEmail: _auth.user.userEmail,
              userType: _auth.user.userType.toString(),
              userGroupId: _auth.user.userGroupId,
              customerGroupId: _auth.customer.groupId.toString());
        });
        if (_auth.user.userGroupId == "11" || _auth.user.userGroupId == "3") {
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            fcmToken = await _getFCMTokenDailyUsage(
                _auth.user.userGroupId, _auth.customer.custAreaId ?? "0");

            int userType = _auth.user.userType;
            int userGroup = int.parse(_auth.user.userGroupId);
            int areaId = _auth.customer.custAreaId ?? 0;
            var body = json.encode({
              'fcm_token': fcmToken,
              'language': ui.window.locale.languageCode,
              'customer_id': _auth.customer.custId ?? 0,
              'user_type_id': userType,
              'user_group_id': userGroup,
              'area_id': areaId.toString(),
              'new_customer_group_id': 1,
              'new_customer_segment_id': 1,
            });
            final responseFCM = await http.post(
                'http://192.168.105.184/pgn-mobile-api/v2/firebase_manager/store_fcm_token',
                // 'http://pgn-mobile-api.noxus.co.id/v2/firebase_manager/store_fcm_token',
                headers: {'Content-Type': 'application/json'},
                body: body);
          });
        } else {
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            fcmToken = await _getFCMToken();
          });
        }
        // } else if (_auth.user.userType == 2 && _auth.user.userGroupId != "11") {
      } else if (_auth.user.userGroupId != "11") {
        if (_auth.user.userGroupId == "17" ||
            _auth.user.userGroupId == "18" ||
            _auth.user.userGroupId == "9" ||
            _auth.user.userGroupId == "10" ||
            _auth.user.userGroupId == "3") {
          if (_auth.user.userType == 2 && _auth.customerId != null) {
            // print('2. MASUK KE SINI ${_auth.customer.custName}');
            await storageCache.write(
                key: 'user_name_cust', value: _auth.customer.custName);
            await storageCache.write(
                key: 'customer_groupId',
                value: _auth.customer.groupId.toString() ?? '');
            await storageCache.write(
                key: 'user_mobile_otp', value: _auth.user.userMobilePhone);
            await storageCache.write(
                key: 'next_action', value: _auth.verificationStatus.nextAction);
            await storageCache.write(
                key: 'next_otp_type_id',
                value: _auth.verificationStatus.nextOtpTypeId);
            await storageCache.write(
                key: 'request_code',
                value: _auth.verificationStatus.requestCode);

            SchedulerBinding.instance.addPostFrameCallback((_) async {
              fcmToken = await _getFCMTokenDailyUsage(
                  _auth.user.userGroupId, _auth.customer.custAreaId ?? "0");

              int userType = _auth.user.userType;
              int userGroup = int.parse(_auth.user.userGroupId);
              int areaId = _auth.customer.custAreaId ?? 0;
              var body = json.encode({
                'fcm_token': fcmToken,
                'language': ui.window.locale.languageCode,
                'customer_id': _auth.customer.custId ?? 0,
                'user_type_id': userType,
                'user_group_id': userGroup,
                'area_id': areaId.toString(),
                'new_customer_group_id': 1,
                'new_customer_segment_id': 1,
              });
              final responseFCM = await http.post(
                  'http://192.168.105.184/pgn-mobile-api/v2/firebase_manager/store_fcm_token',
                  // 'http://pgn-mobile-api.noxus.co.id/v2/firebase_manager/store_fcm_token',
                  headers: {'Content-Type': 'application/json'},
                  body: body);
            });
          } else if (_auth.user.userType == 2 && _auth.customerId == null) {
            await storageCache.write(
                key: 'user_name_cust', value: _auth.user.userName);
            await storageCache.write(
                key: 'user_mobile_otp', value: _auth.user.userMobilePhone);
            await storageCache.write(key: 'customer_groupId', value: '-');
            // prefs.setString('user_name_cust', _auth.user.userName);
          } else if (_auth.user.userType == 1) {
            await storageCache.write(
                key: 'user_name_cust', value: _auth.user.userName);
            await storageCache.write(
                key: 'user_mobile_otp', value: _auth.user.userMobilePhone);
            await storageCache.write(key: 'customer_groupId', value: '-');
            // prefs.setString('user_name_cust', _auth.user.userName);
          }
        } else {
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            fcmToken = await _getFCMToken();
          });
        }
        await storageCache.write(key: 'access_token', value: _auth.accessToken);
        await storageCache.write(
            key: 'lang', value: ui.window.locale.languageCode);
        await storageCache.write(key: 'token_type', value: _auth.tokenType);
        await storageCache.write(
            key: 'user_mobile_otp', value: _auth.user.userMobilePhone);

        await storageCache.write(
            key: 'next_action', value: _auth.verificationStatus.nextAction);
        await storageCache.write(
            key: 'next_otp_type_id',
            value: _auth.verificationStatus.nextOtpTypeId);
        await storageCache.write(
            key: 'request_code', value: _auth.verificationStatus.requestCode);

        await storageCache.write(key: 'user_id', value: _auth.user.userID);
        await storageCache.write(
            key: 'user_email', value: _auth.user.userEmail);
        await storageCache.write(
            key: 'user_type', value: _auth.user.userType.toString());
        await storageCache.write(
            key: 'usergroup_id', value: _auth.user.userGroupId);
        setState(() {
          if (_auth.user.userType == 2 && _auth.customerId == null) {
            print('MASUK 1');
            Provider.of<UserCred>(context).userCred(
              customerGroupId: '0',
              accessToken: _auth.accessToken,
              tokenType: _auth.tokenType,
              verStatusNextAction: _auth.verificationStatus.nextAction,
              verStatusOtpTypeId: _auth.verificationStatus.nextOtpTypeId,
              verStatusRequestCode: _auth.verificationStatus.requestCode,
              userName: _auth.user.userName,
              userId: _auth.user.userID,
              userEmail: _auth.user.userEmail,
              userType: _auth.user.userType.toString(),
              userGroupId: _auth.user.userGroupId,
            );
          } else if (_auth.user.userType == 2) {
            print('MASUK 2');

            Provider.of<UserCred>(context).userCred(
                accessToken: _auth.accessToken,
                tokenType: _auth.tokenType,
                verStatusNextAction: _auth.verificationStatus.nextAction,
                verStatusOtpTypeId: _auth.verificationStatus.nextOtpTypeId,
                verStatusRequestCode: _auth.verificationStatus.requestCode,
                custId: _auth.customer.custId ?? "",
                custName: _auth.customer.custName ?? "",
                customerGroupId: _auth.customer.groupId.toString() ?? " ",
                userName: _auth.user.userName,
                userId: _auth.user.userID,
                userEmail: _auth.user.userEmail,
                userType: _auth.user.userType.toString(),
                userGroupId: _auth.user.userGroupId);
          } else {
            print('MASUK 3');
            Provider.of<UserCred>(context).userCred(
                accessToken: _auth.accessToken,
                tokenType: _auth.tokenType,
                verStatusNextAction: _auth.verificationStatus.nextAction,
                verStatusOtpTypeId: _auth.verificationStatus.nextOtpTypeId,
                verStatusRequestCode: _auth.verificationStatus.requestCode,
                userName: _auth.user.userName,
                userId: _auth.user.userID,
                userEmail: _auth.user.userEmail,
                userType: _auth.user.userType.toString(),
                userGroupId: _auth.user.userGroupId);
          }
        });
      } else {
        // print('3. MASUK KE SINI ${_auth.customer.custName}');
        await storageCache.write(key: 'user_id', value: _auth.user.userID);

        await storageCache.write(
            key: 'user_mobile_otp', value: _auth.user.userMobilePhone);
        await storageCache.write(key: 'access_token', value: _auth.accessToken);
        await storageCache.write(
            key: 'lang', value: ui.window.locale.languageCode);
        await storageCache.write(key: 'token_type', value: _auth.tokenType);

        await storageCache.write(
            key: 'next_action', value: _auth.verificationStatus.nextAction);
        await storageCache.write(
            key: 'next_otp_type_id',
            value: _auth.verificationStatus.nextOtpTypeId);
        await storageCache.write(
            key: 'request_code', value: _auth.verificationStatus.requestCode);

        await storageCache.write(
            key: 'user_name_cust', value: _auth.user.userName);
        await storageCache.write(key: 'user_id', value: _auth.user.userID);
        await storageCache.write(
            key: 'user_email_cust', value: _auth.user.userEmail);

        await storageCache.write(
            key: 'user_type', value: _auth.user.userType.toString());
        await storageCache.write(
            key: 'usergroup_id', value: _auth.user.userGroupId);
        // await storageCache.write(
        //     key: 'customerGroupId', value: _auth.customer.groupId.toString());
        await storageCache.write(
            key: 'customer_groupId', value: _auth.customer.groupId.toString());
        setState(() {
          Provider.of<UserCred>(context).userCred(
              accessToken: _auth.accessToken,
              tokenType: _auth.tokenType,
              verStatusNextAction: _auth.verificationStatus.nextAction,
              verStatusOtpTypeId: _auth.verificationStatus.nextOtpTypeId,
              verStatusRequestCode: _auth.verificationStatus.requestCode,
              userName: _auth.user.userName,
              userId: _auth.user.userID,
              userEmail: _auth.user.userEmail,
              customerGroupId: _auth.customer.groupId.toString(),
              userType: _auth.user.userType.toString(),
              userGroupId: _auth.user.userGroupId);
        });
      }

      if (responseTokenBarrer.statusCode == 200) {
        setState(() {
          visible = false;
          btnVisible = true;
        });

        String accessToken = await storageCache.read(key: 'access_token');

        if (_auth.verificationStatus.message ==
                'Anda pernah login melalui device ini' ||
            usernames.contains('@')) {
          await storageCache.write(key: 'auth_status', value: 'Login');
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          await storageCache.write(key: 'auth_status', value: 'Logout');
          Navigator.pushReplacementNamed(
            context,
            '/otp',
            arguments: numbPhone,
          );
        }
      } else {}
      return AuthSales.fromJson(json.decode(responseTokenBarrer.body));
    }
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

  Future<customer.Customer> getCustomerProfile(BuildContext context) async {
    String accessToken = await storageCache.read(key: 'access_token');
    print('Access TOKEN GetCustLogin : $accessToken');
    var responseCustomer = await http.get('${UrlCons.mainProdUrl}customers/me',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    customer.Customer _customer =
        customer.Customer.fromJson(json.decode(responseCustomer.body));
    await storageCache.write(key: 'customer_id', value: _customer.data.custId);
    await storageCache.write(key: 'customer_name', value: _customer.data.name);

    // harus di on kan
    Provider.of<UserCred>(context).userCred(
      custId: _customer.data.custId,
      custName: _customer.data.name,
    );
    return _customer;
  }
}

Future<List<String>> deviceID() async {
  String identifier;
  String deviceName;
  String deviceVersion;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  final storageCache = new FlutterSecureStorage();
  if (Platform.isAndroid) {
    var build = await deviceInfoPlugin.androidInfo;
    deviceName = build.model;
    deviceVersion = build.version.toString();
    identifier = build.androidId;
    await storageCache.write(key: 'devices_name', value: deviceName);
    await storageCache.write(key: 'devices_version', value: deviceVersion);
    await storageCache.write(key: 'devices_id', value: identifier);
  } else if (Platform.isIOS) {
    var data = await deviceInfoPlugin.iosInfo;
    deviceName = data.name;
    deviceVersion = data.systemVersion;
    identifier = data.identifierForVendor;
    await storageCache.write(key: 'devices_name', value: deviceName);
    await storageCache.write(key: 'devices_version', value: deviceVersion);
    await storageCache.write(key: 'devices_id', value: identifier);
  }
  return [identifier];
}
