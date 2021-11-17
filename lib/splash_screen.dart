import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/screens/dashboard/dashboard.dart';
import 'dart:async';
import 'package:pgn_mobile/screens/login/login_revamp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storageCache = FlutterSecureStorage();
  _startTime() async {
    var _duration = new Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  Future<String> getAuth() async {
    dynamic authStatus = await storageCache.read(key: 'auth_status');
    return authStatus;
  }

  void navigationPage() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      await storageCache.deleteAll();

      prefs.setBool('first_run', false);
    }

    String userID = await getAuth();

    if (userID == "Login") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
          // builder: (context) => Dashboard(),
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginRevamp(),
        ),
      );
    }
    // if (userID == "Logout") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Login(),

    //     ),
    //   );
    // } else if (userID == null) {
    //   Navigator.pushReplacementNamed(context, '/login');
    // } else {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Dashboard(),
    //     ),
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();
    _startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/bg-image-01@2x.png')),
            ),
          ),
          Center(
            child: Container(
              height: 200,
              child: Image.asset('assets/icon_launch.png'),
            ),
          ),
        ],
      ),
    );
  }
}
