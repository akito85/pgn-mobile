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
    super.initState();
    getPeriod();
  }

  String periodSelected;
  List<String> listPeriod = [];
  String hintPeriod = DateFormat("MMMM yyyy").format(DateTime.now()).toString();
  void getPeriod() {
    final now = DateTime.now();
    final sixMonthAgo = now.subtract(Duration(days: 400));
    final sixMonthFromNow = DateTime(sixMonthAgo.year, sixMonthAgo.month + 6);
    DateTime date = sixMonthAgo;
    hintPeriod = now.toString();

    while (date.isBefore(sixMonthFromNow)) {
      listPeriod.add(date.toString());
      date = DateTime(date.year, date.month + 1);
    }
  }

  Widget build(BuildContext context) {
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
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, top: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: painting.Color(0xFF427CEF), width: 2)),
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 8),
                child: DropdownButton(
                    hint: Text(
                        DateFormat("MMMM yyyy")
                            .format(DateTime.now())
                            .toString(),
                        style: painting.TextStyle(
                            color: painting.Color(0xFF455055),
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down_circle_rounded,
                        color: painting.Color(0xFF427CEF)),
                    isExpanded: true,
                    underline: SizedBox(),
                    style: painting.TextStyle(
                        color: painting.Color(0xFF455055),
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                    value: periodSelected,
                    onChanged: (newValue) {
                      print('SELECTEDs $newValue');
                      setState(() {
                        periodSelected = newValue;
                      });

                      print('SELECTED $periodSelected');
                    },
                    items: listPeriod.map((valueItem) {
                      DateTime date = DateTime.parse(valueItem);
                      return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                              DateFormat("MMMM yyyy").format(date).toString()));
                    }).toList()))),
        Container(
          margin: EdgeInsets.only(top: 30, left: 5, right: 5),
          height: 350,
          child: _buildContent(
              context, periodSelected != null ? periodSelected : hintPeriod),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, String period) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8,
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            height: 320,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 14.0, top: 14.0, right: 14.0, bottom: 5),
              child: _buildCharContent(
                  context, fetchGetChar(context, period, idCust), period),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 30),
                  child: Text(
                    DateFormat("MMMM yyyy")
                        .format(DateTime.parse(period))
                        .toString(),
                    textAlign: TextAlign.left,
                    style: painting.TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: painting.Color(0xFF4578EF),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    snapshot.data.message,
                    textAlign: TextAlign.center,
                    style: painting.TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 140,
                      margin: EdgeInsets.only(left: 0.0, top: 18.0, bottom: 18),
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
            roundEndCaps: true,
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
    BuildContext context, String period, String custID) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');

  DateTime date = DateTime.parse(period);
  String periodDate = DateFormat("yyyyMM").format(date).toString();

  var responseUsageChar = await http.get(
      '${UrlCons.mainProdUrl}customers/$custID/gas-usages/daily-chart/$periodDate',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang,
      });
  print('ACCESS TOKEN : $accessToken');
  print(
      'URL :${UrlCons.mainProdUrl}customers/$custID/gas-usages/daily-chart/$periodDate ');
  print('HASIL USAGE : ${responseUsageChar.body}');
  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}
