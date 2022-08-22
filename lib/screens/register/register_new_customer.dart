import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/register/register_businessTab.dart';

import 'package:pgn_mobile/screens/register/register_residentials.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistNewCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Customer Selection',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              'Sign up for a complate solution on natural gas utilization',
              style: TextStyle(
                fontSize: 19.0,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          InkWell(
            onTap: () {
              registerDialog(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => RegisterResidentials(),
              //   ),
              // );
            },
            child: Container(
              margin: EdgeInsets.only(right: 25.0, left: 25.0, top: 20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ic_new_customer_residential.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'REGISTER AS',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 275,
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Residential & Small Medium Enterprise Customer',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              registerDialog(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => RegisterBusinesTab(),
              //   ),
              // );
            },
            child: Container(
              margin: EdgeInsets.only(right: 25.0, left: 25.0, top: 20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ic_new_customer_business.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'REGISTER AS',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 275,
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Business and Industrial Customer',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> registerDialog(BuildContext context) {
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
            'Registrasi berlangganan gas saat ini hanya bisa melalui website PGN Online di alamat : https://online.pgn.co.id/register/',
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
          color: Colors.grey,
          child: Text(
            "Close",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          width: 130,
          onPressed: () {
            Navigator.pop(context);
            _launchURL();
          },
          color: Colors.green,
          child: Text(
            "Continue",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }
}

_launchURL() async {
  if (await canLaunch('https://online.pgn.co.id/register/')) {
    await launch('https://online.pgn.co.id/register/');
  } else {
    throw 'Could not launch https://online.pgn.co.id/register/';
  }
}
