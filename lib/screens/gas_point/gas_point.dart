import 'package:flutter/material.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class GasPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Center(
            child: Text(
              '0',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              'Gas Point',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Color(0xFF9B9B9B)),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/404-01.png',
              height: 300.0,
              width: 350.0,
            ),
          ),
          Center(
            child: Text(
              Translations.of(context).text('error_sorry'),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'The Data you requested is',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Center(
            child: Text(
              'currently unavailable',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
