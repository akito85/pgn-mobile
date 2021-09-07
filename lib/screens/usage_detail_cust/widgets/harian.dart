import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/spbg_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/screens/usage_detail_cust/widgets/harian_detail.dart';
import 'package:pgn_mobile/models/detail_usage_model.dart';
import 'package:date_format/date_format.dart';

class Harian extends StatefulWidget {
  final String title, idCust;
  Harian({this.title, this.idCust});
  @override
  HarianTabDetailState createState() => HarianTabDetailState(title, idCust);
}

class HarianTabDetailState extends State<Harian> with TickerProviderStateMixin {
  final String title, idCust;
  DataSpbg data;
  HarianTabDetailState(this.title, this.idCust);
  TabController _tabController;
  String groupID;

  List<LinearSales> inputDataChart(List<UsageDetailChar> data) {
    final myFakeDesktopData = [
      LinearSales(0, 0),
    ];
    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      myFakeDesktopData.add(LinearSales(
          int.parse(formatDate(todayDate, [dd])), itemData.usage.value));
    });

    return myFakeDesktopData;
  }

  List<LinearSalesDateTime> inputDataChartDate(List<UsageDetailChar> data) {
    final myFakeDesktopData = List<LinearSalesDateTime>();

    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      myFakeDesktopData
          .add(LinearSalesDateTime(todayDate, itemData.usage.value));
    });

    return myFakeDesktopData;
  }

  List<charts.Series<LinearSales, int>> _createSampleData(
      List<UsageDetailChar> data) {
    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: inputDataChart(data),
      ),
    ];
  }

  List<charts.Series<LinearSalesDateTime, DateTime>> _createSampleData17(
      List<UsageDetailChar> data) {
    return [
      charts.Series<LinearSalesDateTime, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSalesDateTime sales, _) => sales.year,
        measureFn: (LinearSalesDateTime sales, _) => sales.sales,
        data: inputDataChartDate(data),
      ),
    ];
  }

  dynamic storageCache = new FlutterSecureStorage();
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 2);
    getTitleCust();
    super.initState();
  }

  void getTitleCust() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   groupID = prefs.getString('usergroup_id') ?? "";
    // });
    String titleCusts = await storageCache.read(key: 'usergroup_id') ?? "";
    setState(() {
      groupID = titleCusts;
    });
  }

  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int month2 = currentMonth - 1;
    int month3 = currentMonth - 2;
    String month3S, month2S, currentMonthS;
    String y = "10";
    String sNull = "0";
    if (currentMonth == 2) {
      int currentYears = DateTime.now().year - 1;
      // int y1 = 12;
      // int y2 = 01;
      currentMonthS = '02';
      String cal2 = '${currentYears + 1}01';
      String cal1 = '${currentYears}12';
      month2S = cal2;
      month3S = cal1;
    } else if (currentMonth == 1) {
      int currentYears = DateTime.now().year - 1;
      int y1 = 12;
      int y2 = 11;
      String cal2 = '$currentYears$y1';
      String cal1 = '$currentYears$y2';
      currentMonthS = '01';
      month2S = cal2;
      month3S = cal1;
    } else {
      currentYear = DateTime.now().year;

      if (currentMonth < 10) {
        currentMonthS = '0$currentMonth';
        print('MASUK SINI KAH : $currentMonthS');
      } else {
        currentMonthS = currentMonth.toString();
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
        '${currentYear.toString()}${currentMonthS.toString()}10';
    String dateformatCurrent2 = '${month2S.toString()}10';

    String dateformatCurrent3 = '${month3S.toString()}10';

    String formatDate =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent));
    String formatDate2 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent2));
    String formatDate3 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent3));
    print('INI FORMAT DATE : $formatDate');
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                height: 45,
                margin: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/icon_default_pelanggan.png'),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 18.0, left: 15, right: 20, bottom: 10),
                  child: Text(
                    title,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, left: 5, right: 5),
          height: 400,
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
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.white,
                          indicatorColor: Colors.black,
                          unselectedLabelColor: Color(0xFF427CEF),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF4578EF),
                          ),
                          tabs: [
                            Tab(
                                child: Text(
                                    '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent3))}')),
                            Tab(
                                child: Text(
                                    '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent2))}')),
                            Tab(
                                child: Text(
                                    '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent))}')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildContent(context, formatDate3),
                  _buildContent(context, formatDate2),
                  _buildContent(context, formatDate),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, String title) {
    return Container(
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 140,
                      margin: EdgeInsets.only(left: 14.0, top: 18.0),
                      child: Text(
                        'Energi (MMBtu)',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 289,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                  child: _buildCharContent(
                      context, fetchGetChar(context, title, idCust), title),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildCharContent(BuildContext context,
      Future<ChartUsageDetail> getChartUsageDetail, String period) {
    return FutureBuilder<ChartUsageDetail>(
        future: getChartUsageDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Column(
              children: <Widget>[
                LinearProgressIndicator(),
              ],
            );
          if (snapshot.data.message != null)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
                SizedBox(height: 20),
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
                itemCount: 1,
                itemBuilder: (context, i) {
                  return i < 1
                      ? _buildRow(snapshot.data.data)
                      : SizedBox(
                          height: 10.0,
                        );
                },
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: painting.Color(0xFF4578EF),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
                        child: Text(
                          Translations.of(context)
                              .text('f_gu_legend_volume_daily'),
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        )),
                  ),
                  InkWell(
                    child: Container(
                      height: 30,
                      width: 80,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue),
                      child: Text(
                        Translations.of(context)
                            .text('f_customer_gas_usage_detail_bt_detail'),
                        style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      print('ini titlenyaaa : $title');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HarianDetailCustChart(
                                  title: title, period: period)));
                    },
                  )
                ],
              ),
            ],
          );
        });
  }

  Widget _buildRow(List<UsageDetailChar> data) {
    return Container(
      height: 212,
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: SimpleLineCharts(_createSampleData17(data)),
      ),
    );
  }
}

/////////////////////
class SimpleLineCharts extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  SimpleLineCharts(this.seriesList, {this.animate = true});
  @override
  SimpleLineChart createState() => SimpleLineChart(seriesList);
}

class SimpleLineChart extends State<SimpleLineCharts> {
  final List<charts.Series> seriesList;
  final bool animate;
  String valueText = '0';
  String titleText;
  Widget _timeSeriesChart;
  SimpleLineChart(this.seriesList, {this.animate = true});

  @override
  void initState() {
    super.initState();
    setState(() {
      _timeSeriesChart = charts.TimeSeriesChart(
        seriesList,
        defaultRenderer: new charts.LineRendererConfig(
            includeArea: true,
            stacked: true,
            includePoints: true,
            radiusPx: 4.0),
        animate: false,
        domainAxis: new charts.EndPointsTimeAxisSpec(
          tickProviderSpec: charts.DayTickProviderSpec(increments: [5]),
        ),
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec:
                new charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
        dateTimeFactory: new charts.LocalDateTimeFactory(),
        selectionModels: [
          charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model) {
                setState(
                  () {
                    valueText =
                        '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}';
                    titleText =
                        '${model.selectedSeries[0].domainFn(model.selectedDatum[0].index)}';
                  },
                );
              })
        ],
      );
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 180,
          child: _timeSeriesChart,
        ),
        SizedBox(height: 5),
        titleText != null
            ? Text(
                'Energy(${DateFormat("MMM d").format(DateTime.parse(titleText))}) : $valueText' ??
                    '-',
                style: TextStyle(
                    color: painting.Color(0xFFFF972F),
                    fontWeight: FontWeight.bold),
              )
            : Container(),
      ],
    );
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class LinearSalesDateTime {
  final DateTime year;
  final int sales;

  LinearSalesDateTime(this.year, this.sales);
}

Future<ChartUsageDetail> fetchGetChar(
    BuildContext context, String title, String custID) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String lang = prefs.getString('lang');
  // String accessToken = prefs.getString('access_token');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseUsageChar = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-chart/$title',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );

  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}
