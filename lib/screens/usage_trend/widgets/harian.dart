import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/models/monthly_usage_trend_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:charts_flutter/src/text_element.dart' as element;
import 'dart:math';
import 'package:flutter/painting.dart' as painting;
import 'package:charts_flutter/src/text_style.dart' as style;

class Harian extends StatelessWidget {
  List<LinearSales> datanyaYangDiInput(List<UsageTrendChar> data) {
    final myFakeDesktopData = List<LinearSales>();

    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);

      myFakeDesktopData.add(LinearSales(todayDate, itemData.usage.value));
    });

    return myFakeDesktopData;
  }

  List<charts.Series<LinearSales, DateTime>> _createSampleData(
      List<UsageTrendChar> data) {
    return [
      charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: datanyaYangDiInput(data),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 5.0, top: 10),
          padding:
              EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
          child: Text(
            Translations.of(context).text('f_gus_daily_usage_summary_title'),
            style: painting.TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w300,
                fontSize: 20.0),
          ),
        ),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
            child: Column(
              children: <Widget>[
                _buildContent(context, getCustomerContract(context)),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 15.0),
                      decoration: new BoxDecoration(
                        color: Colors.blue[800],
                        shape: BoxShape.circle,
                      ),
                      child: Text('    '),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(5.0, 7.0, 0.0, 15.0),
                          child: Text(
                            Translations.of(context)
                                .text('f_gu_legend_volume_daily'),
                            style: painting.TextStyle(
                              fontSize: 10.0,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ))
      ],
    );
  }

  Widget _buildContent(
      BuildContext context, Future<MonthlyUsageTrend> getTrendHarian) {
    return FutureBuilder<MonthlyUsageTrend>(
      future: getTrendHarian,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[
              LinearProgressIndicator(),
              SizedBox(
                height: 310,
              )
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
                    margin: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(
                      Translations.of(context)
                          .text('f_gus_legend_volume_mmscfd'),
                      style: painting.TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0, top: 10.0),
                  child: Text(
                    '${snapshot.data.meta.startDate.displayStart ?? ""} - ${snapshot.data.meta.endDate.displayEnd}',
                    style: painting.TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
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
          ],
        );
      },
    );
  }

  Widget _buildRow(List<UsageTrendChar> data) {
    return Container(
      height: 300,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: SimpleLineCharts(_createSampleData(data)),
      ),
    );
  }
}

class SimpleLineCharts extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  static String pointerValue;
  SimpleLineCharts(this.seriesList, {this.animate = true});
  @override
  SimpleLineChart createState() => SimpleLineChart(seriesList);
}

class SimpleLineChart extends State<SimpleLineCharts> {
  final List<charts.Series> seriesList;
  final bool animate;
  static String pointerValue;
  String valueText = "0.0";
  String titleText;
  Widget _timeSeriesChart;
  final formatCurrency =
      new NumberFormat.currency(locale: "en_US", symbol: " ", decimalDigits: 0);
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
        behaviors: [
          LinePointHighlighter(
              symbolRenderer: CustomCircleSymbolRenderer(text: valueText),
              defaultRadiusPx: 55)
        ],
        selectionModels: [
          charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model) {
                setState(() {
                  valueText =
                      '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}';
                  titleText =
                      '${model.selectedSeries[0].domainFn(model.selectedDatum[0].index)}';
                });
              }),
        ],
      );
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 245,
          child: _timeSeriesChart,
        ),
        SizedBox(height: 5),
        titleText != null
            ? Text(
                'Energy(${DateFormat("MMM d").format(DateTime.parse(titleText))}) : ${formatCurrency.format(double.parse(valueText)) ?? ''}',
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

Future<MonthlyUsageTrend> getCustomerContract(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token');
  var responseUsageTrend = await http
      .get('${UrlCons.mainProdUrl}summary/daily-usages-chart', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });
  MonthlyUsageTrend _getContract =
      MonthlyUsageTrend.fromJson(json.decode(responseUsageTrend.body));

  return _getContract;
}
