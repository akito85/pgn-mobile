import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:pgn_mobile/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pgn_mobile/screens/dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _startTime() async {
    var _duration = new Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String userID = prefs.getString('user_id');
    final storageCache = FlutterSecureStorage();
    String userID = await storageCache.read(key: 'user_id');
    if (userID == "kosong") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } else if (userID == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    }
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
