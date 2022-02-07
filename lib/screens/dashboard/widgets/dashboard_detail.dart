import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/models/dashboard_chart_model.dart';

class DashboardDetail extends StatefulWidget {
  final String title;
  final String cur;
  DashboardDetail({this.title, this.cur});
  @override
  DashDetailState createState() => DashDetailState(title, cur);
}

class DashDetailState extends State<DashboardDetail>
    with SingleTickerProviderStateMixin {
  String title, cur;
  DashDetailState(this.title, this.cur);
  TabController _tabController;
  var prevMonth1, prevMonth2, prevMonth3;
  var currentDate = new DateTime.now();
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 2);
    super.initState();
  }

  Widget build(BuildContext context) {
    prevMonth1 = currentDate.month - 1;
    prevMonth2 = new DateTime(currentDate.month - 2);
    prevMonth3 = new DateTime(currentDate.month - 3);
    //print('prevMonth1: ${currentDate.month - 1}');
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month - 1;
    int month2 = currentMonth - 1;
    int month3 = currentMonth - 2;
    String y = "10";
    String sNull = "0";
    String month3S, month2S, currentMonthS;
    if (DateTime.now().day >= 5) {
      currentMonth = DateTime.now().month - 1;
      month2 = currentMonth - 1;
      month3 = currentMonth - 2;
    } else {
      currentMonth = DateTime.now().month - 2;
      month2 = currentMonth - 1;
      month3 = currentMonth - 2;
    }

    if (currentMonth == 2) {
      int currentYears = DateTime.now().year - 1;

      String y1 = "12";
      int y2 = 11;

      String cal2 = '$currentYears$y1';
      String cal1 = '$currentYears$y2';
      currentMonthS = '01';
      month2S = cal2;
      month3S = cal1;
    } else if (currentMonth == 3) {
      int currentYears = DateTime.now().year - 1;

      String y1 = "01";
      int y2 = 12;

      String cal2 = '$currentYear$y1';
      String cal1 = '$currentYears$y2';
      currentMonthS = '02';
      month2S = cal2;
      month3S = cal1;
    } else if (currentMonth == 1) {
      int currentYears = DateTime.now().year - 1;

      int y1 = 11;
      int y2 = 10;
      String cal2 = '$currentYears$y1';
      String cal1 = '$currentYears$y2';
      currentMonthS = '12';
      month2S = cal2;
      month3S = cal1;
    } else {
      currentYear = DateTime.now().year;
      if (currentMonth < 10) {
        currentMonthS = '0$currentMonth$y';
      } else {
        currentMonthS = '$currentMonth$y';
      }
      if (month2 < 10) {
        month2S = '$currentYear$sNull$month2';
      } else {
        month2S = '$currentYear$month2';
      }

      if (month3 < 10) {
        month3S = '$currentYear$sNull$month3';
      } else {
        month3S = '$currentYear$month3';
      }
    }
    String dateformatCurrent =
        '${currentYear.toString()}${currentMonthS.toString()}';
    String dateformatCurrent2 = '${month2S.toString()}10';

    String dateformatCurrent3 = '${month3S.toString()}10';

    String formatDate =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent));
    String formatDate2 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent2));
    String formatDate3 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent3));

    // //print(' DATE FORMAT TITLE CURRENT : $dateformatCurrent');
    // //print(' DATE FORMAT TITLE 2 : $dateformatCurrent2');
    // //print(' DATE FORMAT TITLE paling kiri : $dateformatCurrent3');
    // //print(' DATE FORMAT API CURRENT : $formatDate');
    // //print(' DATE FORMAT API 2 : $formatDate2');
    // //print(' DATE FORMAT API paling kiri : $formatDate3');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Omset Area',
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
                        tabs: [
                          Tab(
                              child: Text(
                            '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent3))}',
                            style: TextStyle(fontSize: 16),
                          )),
                          Tab(
                              child: Text(
                            '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent2))}',
                            style: TextStyle(fontSize: 16),
                          )),
                          Tab(
                              child: Text(
                            '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent))}',
                            style: TextStyle(fontSize: 16),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildContent(context, formatDate3, cur),
                  _buildContent(context, formatDate2, cur),
                  _buildContent(context, formatDate, cur),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, String title, cur) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
          child: _buildCharContent(context, fetchGetChar(context, title, cur)),
        )
      ],
    );
  }

  Widget _buildCharContent(BuildContext context, Future<UsdArea> getChartArea) {
    return FutureBuilder<UsdArea>(
        future: getChartArea,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          if (snapshot.data.message != null)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 150),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                    snapshot.data.message,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          return Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.data.length + 1,
                itemBuilder: (context, i) {
                  return i < snapshot.data.data.length
                      ? _buildRow(snapshot.data.data[i])
                      : SizedBox(
                          height: 10.0,
                        );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Container(
                    margin: EdgeInsets.only(right: 15.0, bottom: 20),
                    child: Text('Omset($title)'),
                  )
                ],
              ),
            ],
          );
        });
  }

  Widget _buildRow(UsdAreaData data) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: new LinearPercentIndicator(
        padding: EdgeInsets.only(left: 15, right: 15),
        animation: true,
        animationDuration: 1000,
        lineHeight: 30.0,
        percent: double.parse(data.percentage) / 100,
        center: Container(
          alignment: Alignment.centerRight,
          child: Text('${data.name} - (${data.percentage}%)'),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Color(0xff427CEF),
      ),
    );
  }
}

Future<UsdArea> fetchGetChar(
    BuildContext context, String title, String cur) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  var responseCharArea = await http.get(
      '${UrlCons.mainProdUrl}summary/omset-area?period=$title$cur',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });

  UsdArea _getCharArea = UsdArea.fromJson(json.decode(responseCharArea.body));

  return _getCharArea;
}
