import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/calculator/widgets/cal_boiler.dart';
import 'package:pgn_mobile/screens/calculator/widgets/cal_conversi.dart';
import 'package:pgn_mobile/screens/calculator/widgets/cal_listrik.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/language.dart';

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<Language>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('Energy Calculator'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 18, right: 15, top: 15),
            child: Text(
              'Energy Type to Calculate',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18, right: 15, top: 5),
            child: Text(
              'Please choose which categories you would like to calculate',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF5C727D),
                  fontSize: 12),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, left: 5, right: 5),
            height: 830,
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: TabBar(
                            labelColor: Colors.white,
                            indicatorColor: Colors.black,
                            unselectedLabelColor: Color(0xFF427CEF),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF4578EF),
                            ),
                            tabs: <Widget>[
                              Tab(
                                text: Translations.of(context)
                                    .text('f_calculator_conversion_tv_title'),
                              ),
                              Tab(text: 'Boiler'),
                              Tab(
                                text: Translations.of(context)
                                    .text('f_calculator_electricity_tv_title'),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    CalConversion('context', context),
                    CalBoiler(),
                    CalListrict()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
