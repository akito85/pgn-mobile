import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/per_jam_tab_detail.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/bulanan_tab_detail.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/harian_tab_detail.dart';

import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class UsageTabDetail extends StatefulWidget {
  final String title, idCust;
  UsageTabDetail({this.title, this.idCust});
  @override
  UsageTabDetailState createState() => UsageTabDetailState(title, idCust);
}

class UsageTabDetailState extends State<UsageTabDetail>
    with TickerProviderStateMixin {
  Widget appBarTitle = new Text(
    "Detail Pemakaian",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  TabController _tabController;
  final String title, idCust;
  UsageTabDetailState(this.title, this.idCust);

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Usage Detail',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      width: 380,
                      child: TabBar(
                        indicatorColor: Color(0xff427CEF),
                        controller: _tabController,
                        labelColor: Colors.white,
                        unselectedLabelColor: Color(0xff427CEF),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF4578EF),
                        ),
                        tabs: <Widget>[
                          Tab(
                            text: Translations.of(context).text(
                                    'a_internal_gas_usage_detail_tab_title_hourly_list') ??
                                "",
                          ),
                          Tab(
                            text: Translations.of(context).text(
                                    'a_internal_gas_usage_detail_tab_title_daily_chart') ??
                                "",
                          ),
                          Tab(
                            text: Translations.of(context).text(
                                    'a_internal_gas_usage_detail_tab_title_monthly_chart') ??
                                "",
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
                    controller: _tabController,
                    children: <Widget>[
                      PerJamTabDetail(title: title, idCust: idCust),
                      HarianTabDetail(title: title, idCust: idCust),
                      BulananTabDetail(title, idCust),
                    ],
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
