import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/spbg_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/harian_detail_chart.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/models/detail_usage_model.dart';
import 'package:charts_flutter/src/text_element.dart' as element;
import 'dart:math';
import 'package:charts_flutter/src/text_style.dart' as style;

class HarianTabDetail extends StatefulWidget {
  final String title, idCust;
  HarianTabDetail({this.title, this.idCust});
  @override
  HarianTabDetailState createState() => HarianTabDetailState(title, idCust);
}

class HarianTabDetailState extends State<HarianTabDetail>
    with TickerProviderStateMixin {
  final String title, idCust;
  DataSpbg data;
  HarianTabDetailState(this.title, this.idCust);
  TabController _tabController;

  List<LinearSales> inputDataChart(List<UsageDetailChar> data) {
    final myFakeDesktopData = List<LinearSales>();
    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);

      myFakeDesktopData.add(LinearSales(todayDate, itemData.usage.value));
    });

    return myFakeDesktopData;
  }

  List<Series<LinearSales, DateTime>> _createSampleData(
      List<UsageDetailChar> data) {
    return [
      Series<LinearSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => MaterialPalette.indigo.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: inputDataChart(data),
      ),
    ];
  }

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 2);
    super.initState();
  }

  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int month2 = currentMonth - 1;
    int month3 = currentMonth - 2;

    String sNull = "0";
    String month3S, month2S, currentMonthS;
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
    // print('Date Format 3: $dateformatCurrent3');
    // print('Date Format 2: $dateformatCurrent2');
    // print('Date Format 1: $dateformatCurrent');

    // print("Format Monthnya: $formatDate");
    // print("Format Monthnya2: $formatDate2");
    // print("Format Monthnya3: $formatDate3");
    return ListView(
      children: <Widget>[
        Material(
          child: Container(
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
                      style: painting.TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, left: 5, right: 5),
          height: 400,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: TabBar(
                          indicatorPadding:
                              EdgeInsets.only(left: 15, right: 15),
                          controller: _tabController,
                          labelColor: Colors.white,
                          indicatorColor: Colors.black,
                          unselectedLabelColor: painting.Color(0xFF427CEF),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: painting.Color(0xFF4578EF),
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
    return Card(
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
                    'Energy (MMBtu)',
                    style: painting.TextStyle(
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
      ),
    );
  }

  Widget _buildCharContent(BuildContext context,
      Future<ChartUsageDetail> getChartUsageDetail, String period) {
    return FutureBuilder<ChartUsageDetail>(
        future: getChartUsageDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Column(
              children: <Widget>[LinearProgressIndicator()],
            );
          if (snapshot.data.message != null)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    snapshot.data.message,
                    style: painting.TextStyle(fontSize: 18),
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
                          style: painting.TextStyle(
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
                        style: painting.TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HarianDetailChart(
                            idCust: idCust,
                            period: period,
                            titleApbar: Translations.of(context)
                                .text('title_bar_gu_daily_list'),
                          ),
                        ),
                      );
                    },
                  ),
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
        child: SimpleLineCharts(_createSampleData(data)),
      ),
    );
  }
}

class SimpleLineCharts extends StatefulWidget {
  final List<Series> seriesList;
  final bool animate;
  static String pointerValue;
  SimpleLineCharts(this.seriesList, {this.animate = true});
  @override
  SimpleLineChart createState() => SimpleLineChart(seriesList);
}

class SimpleLineChart extends State<SimpleLineCharts> {
  final List<Series> seriesList;
  final bool animate;
  static String pointerValue;
  String valueText = "0.0";
  String titleText;
  Widget _timeSeriesChart;
  SimpleLineChart(this.seriesList, {this.animate = true});

  @override
  void initState() {
    super.initState();
    setState(() {
      _timeSeriesChart = TimeSeriesChart(
        seriesList,
        defaultRenderer: new LineRendererConfig(
            includeArea: false,
            stacked: false,
            includePoints: true,
            radiusPx: 4.0),
        animate: animate,
        domainAxis: new EndPointsTimeAxisSpec(
          tickProviderSpec: DayTickProviderSpec(increments: [5]),
        ),
        primaryMeasureAxis: new NumericAxisSpec(
            tickProviderSpec:
                new BasicNumericTickProviderSpec(desiredTickCount: 3)),
        dateTimeFactory: new LocalDateTimeFactory(),
        behaviors: [
          LinePointHighlighter(
              symbolRenderer: CustomCircleSymbolRenderer(text: valueText)),
          SelectNearest(eventTrigger: SelectionTrigger.tapAndDrag)
        ],
        selectionModels: [
          SelectionModelConfig(
            type: SelectionModelType.info,
            changedListener: (SelectionModel model) {
              setState(
                () {
                  valueText =
                      '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}';
                  titleText =
                      '${model.selectedSeries[0].domainFn(model.selectedDatum[0].index)}';
                },
              );
            },
          ),
          //
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
                style: painting.TextStyle(
                    color: painting.Color(0xFFFF972F),
                    fontWeight: FontWeight.bold),
              )
            : Container(),
      ],
    );
  }
}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  String text;
  CustomCircleSymbolRenderer({this.text});
  @override
  CustomCircleSymbolRenderer.paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: Color.transparent);
    var textStyle = style.TextStyle();
    // textStyle.color = Color.yellow;
    textStyle.fontSize = 15;
    canvas.drawText(
        element.TextElement(SimpleLineChart.pointerValue, style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round());
  }
}

class LinearSales {
  final DateTime year;
  final int sales;

  LinearSales(this.year, this.sales);
}

Future<ChartUsageDetail> fetchGetChar(
    BuildContext context, String title, String custID) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString('access_token');
  // String lang = prefs.getString('lang');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');

  var responseUsageChar = await http.get(
      '${UrlCons.mainProdUrl}customers/$custID/gas-usages/daily-chart/$title',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang,
      });

  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}
