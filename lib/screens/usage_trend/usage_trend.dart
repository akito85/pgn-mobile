import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/usage_trend/widgets/harian.dart';
import 'package:pgn_mobile/screens/usage_trend/widgets/sales.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

import 'package:flutter/rendering.dart';

class UsageTrend extends StatelessWidget {
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('title_bar_gus_detail'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  height: 50,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: 380,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    indicatorColor: Color(0xff427CEF),
                    indicatorWeight: 1,
                    indicatorPadding: EdgeInsets.only(left: 15, right: 15),
                    labelColor: Colors.white,
                    unselectedLabelColor: Color(0xff427CEF),
                    indicator: ShapeDecoration(
                        color: Color(0xff427CEF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                              color: Color(0xff427CEF),
                            ))),
                    tabs: <Widget>[
                      Tab(
                          text: Translations.of(context)
                              .text('a_detail_summary_tab_title_daily')),
                      Tab(
                        text: Translations.of(context)
                            .text('a_detail_summary_tab_title_sales'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/new_backgound.jpeg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TabBarView(
                children: <Widget>[Harian(), Sales()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
