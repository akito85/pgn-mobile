import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/register/register_businessTab.dart';

import 'package:pgn_mobile/screens/register/register_residentials.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterResidentials(),
                ),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterBusinesTab(),
                ),
              );
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
}
