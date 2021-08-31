import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/register/register_customer.dart';
import 'package:pgn_mobile/screens/register/register_new_customer.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment(-.2, 0),
                  image: AssetImage('assets/bg_welcome_image.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 170.0,
            child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Welcome, PGN Mobile',
                  style: TextStyle(color: Colors.white, fontSize: 34.0),
                )),
          ),
          Positioned(
            bottom: 120.0,
            child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Already a PGN Customer?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w200),
                )),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  height: 50,
                  width: 160,
                  child: RaisedButton(
                    elevation: 0.0,
                    color: Colors.white,
                    child: Text(
                      'YES',
                      style: TextStyle(color: Colors.blue[300]),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterCustomer()));
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                    ),
                    height: 50,
                    child: RaisedButton(
                      elevation: 0.0,
                      color: Colors.white,
                      child: Text(
                        'NO',
                        style: TextStyle(color: Colors.blue[300]),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistNewCustomer()));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
