import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/screens/usage_detail_cust/widgets/perjam.dart';
import 'package:pgn_mobile/screens/usage_detail_cust/widgets/bulanan.dart';
import 'package:pgn_mobile/screens/usage_detail_cust/widgets/harian.dart';

import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class UsageDetailCust extends StatefulWidget {
  final String title, idCust;
  UsageDetailCust({this.title, this.idCust});
  @override
  UsageTabDetailState createState() => UsageTabDetailState(title, idCust);
}

class UsageTabDetailState extends State<UsageDetailCust>
    with TickerProviderStateMixin {
  Widget appBarTitle = new Text(
    "Usage Detail",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  TabController _tabController;
  final String title, idCust;
  UsageTabDetailState(this.title, this.idCust);
  String titleCust;
  dynamic storageCache = new FlutterSecureStorage();
  @override
  void initState() {
    getTitleCust();
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  void getTitleCust() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String titleCusts = await storageCache.read(key: 'user_name_cust') ?? "";
    setState(() {
      titleCust = titleCusts;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                          'a_internal_gas_usage_detail_tab_title_hourly_list'),
                    ),
                    Tab(
                      text: Translations.of(context).text(
                          'a_internal_gas_usage_detail_tab_title_daily_chart'),
                    ),
                    Tab(
                      text: Translations.of(context).text(
                          'a_internal_gas_usage_detail_tab_title_monthly_chart'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Perjam(title: titleCust ?? title, idCust: idCust ?? " "),
            Harian(title: title ?? titleCust, idCust: idCust ?? " "),
            BulananCustDetail(titleCust ?? title, idCust),
          ],
        ),
      ),
    );
  }
}
