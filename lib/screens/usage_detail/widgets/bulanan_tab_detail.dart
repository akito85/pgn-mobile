import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/models/detail_usage_model.dart';
import 'package:date_format/date_format.dart';
import 'package:charts_flutter/src/text_element.dart' as element;

class BulananTabDetail extends StatelessWidget {
  final String title, idCust;
  BulananTabDetail(this.title, this.idCust);

  List<LinearSales> inputDataChartEnergy(List<UsageDetailCharMonthly> data) {
    final myFakeDesktopData = List<LinearSales>();
    data.forEach((itemData) {
      var todayDate = DateTime.parse(itemData.month.value);
      var month = formatDate((todayDate), [m]);
      var year = formatDate((todayDate), [yyyy]);
      var day = formatDate((todayDate), [dd]);
      print('ini data ENERGI : $month ${itemData.usageDetailMonthly.value}');
      myFakeDesktopData.add(LinearSales(
          DateTime(int.parse(year), int.parse(month), int.parse(day), 17, 30),
          itemData.usageDetailMonthly.value));
    });

    return myFakeDesktopData;
  }

  List<LinearSales> inputDataChartMin(List<UsageDetailCharMonthly> data) {
    final myFakeTabletData = List<LinearSales>();
    data.forEach((itemData) {
      var todayDate = DateTime.parse(itemData.month.value);
      var month = formatDate((todayDate), [m]);
      var year = formatDate((todayDate), [yyyy]);
      var day = formatDate((todayDate), [dd]);

      myFakeTabletData.add(LinearSales(
          DateTime(int.parse(year), int.parse(month), int.parse(day)),
          itemData.minUsageDetail.value));
    });

    return myFakeTabletData;
  }

  List<LinearSales> inputDataChartMax(List<UsageDetailCharMonthly> data) {
    final myFakeMobileData = List<LinearSales>();
    data.forEach((itemData) {
      var todayDate = DateTime.parse(itemData.month.value);
      var month = formatDate((todayDate), [m]);
      var year = formatDate((todayDate), [yyyy]);
      var day = formatDate((todayDate), [dd]);

      myFakeMobileData.add(LinearSales(
          DateTime(int.parse(year), int.parse(month), int.parse(day)),
          itemData.maxUsage.value));
    });

    return myFakeMobileData;
  }

  List<charts.Series<LinearSales, DateTime>> _createSampleData(
      List<UsageDetailCharMonthly> data) {
    return [
      charts.Series<LinearSales, DateTime>(
        id: 'Mobile',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.time,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: inputDataChartMin(data),
      ),
      charts.Series<LinearSales, DateTime>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.time,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: inputDataChartMax(data),
      ),
      charts.Series<LinearSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.time,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: inputDataChartEnergy(data),
      ),
    ];
  }

  @override
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
        Card(
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 10.0, top: 10.0),
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
                  height: 280,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: _buildCharMonthContent(
                        context, fetchGetCharMonth(context, idCust)),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(25.0, 5.0, 0.0, 15.0),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: painting.Color(0xFF4578EF),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(5.0, 7.0, 0.0, 15.0),
                          child: Text(
                            Translations.of(context)
                                .text('f_gu_legend_volume_monthly'),
                            style: painting.TextStyle(
                              fontSize: 10.0,
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(25.0, 5.0, 0.0, 15.0),
                      decoration: new BoxDecoration(
                        color: Colors.green[300],
                        shape: BoxShape.rectangle,
                      ),
                      child: Text('    '),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(5.0, 7.0, 0.0, 15.0),
                          child: Text(
                            Translations.of(context)
                                .text('f_gu_legend_min_contract'),
                            style: painting.TextStyle(
                              fontSize: 10.0,
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(25.0, 5.0, 0.0, 15.0),
                      decoration: new BoxDecoration(
                        color: Colors.red[300],
                        shape: BoxShape.rectangle,
                      ),
                      child: Text('    '),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(5.0, 7.0, 25.0, 15.0),
                          child: Text(
                            Translations.of(context)
                                .text('f_gu_legend_max_contract'),
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

  Widget _buildCharMonthContent(BuildContext context,
      Future<ChartUsageDetailMonthly> getChartUsageDetailMonth) {
    return FutureBuilder<ChartUsageDetailMonthly>(
        future: getChartUsageDetailMonth,
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
            ],
          );
        });
  }

  Widget _buildRow(List<UsageDetailCharMonthly> data) {
    return Container(
      height: 250,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: SimpleLineChart(_createSampleData(data)),
      ),
    );
  }
}

class SimpleLineChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  static String pointerValue;
  SimpleLineChart(this.seriesList, {this.animate = true});

  @override
  _SimpleLineChartState createState() => _SimpleLineChartState(seriesList);
}

class _SimpleLineChartState extends State<SimpleLineChart> {
  final List<Series> seriesList;
  final bool animate;
  String titleText;
  static String pointerValue;
  String valueText = "0.0";
  Widget _timeSeriesChart;
  final formatCurrency =
      new NumberFormat.currency(locale: "en_US", symbol: " ", decimalDigits: 0);
  _SimpleLineChartState(this.seriesList, {this.animate = true});

  @override
  void initState() {
    super.initState();
    setState(
      () {
        _timeSeriesChart = charts.TimeSeriesChart(
          seriesList,
          defaultRenderer:
              new LineRendererConfig(includePoints: true, radiusPx: 4.0),
          animate: false,
          customSeriesRenderers: [
            new PointRendererConfig(customRendererId: 'customPoint'),
          ],
          primaryMeasureAxis: new NumericAxisSpec(
              tickProviderSpec:
                  new BasicNumericTickProviderSpec(desiredTickCount: 5)),
          dateTimeFactory: const LocalDateTimeFactory(),
          behaviors: [
            LinePointHighlighter(
                symbolRenderer: CustomCircleSymbolRenderer(texts: pointerValue))
          ],
          selectionModels: [
            SelectionModelConfig(
              changedListener: (SelectionModel model) {
                if (model.hasDatumSelection)
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
          ],
        );
      },
    );
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
                'Energy(${DateFormat("MMM").format(DateTime.parse(titleText))}) : ${formatCurrency.format(double.parse(valueText)) ?? ''}',
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
  String texts;
  CustomCircleSymbolRenderer({this.texts});
  @override
  CustomCircleSymbolRenderer.paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 20,
            bounds.height + 10),
        fill: Color.transparent);
    var textStyle = style.TextStyle();
    // textStyle.color = Color.yellow;
    textStyle.fontSize = 15;
    canvas.drawText(
        element.TextElement(_SimpleLineChartState.pointerValue,
            style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round());
  }
}

class LinearSales {
  final DateTime time;
  final int sales;

  LinearSales(this.time, this.sales);
}

Future<ChartUsageDetailMonthly> fetchGetCharMonth(
    BuildContext context, String custID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token');
  var responseUsageCharMonth = await http.get(
      '${UrlCons.getDataCustomerMng}$custID/gas-usages/monthly-chart',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
  ChartUsageDetailMonthly _getContract = ChartUsageDetailMonthly.fromJson(
      json.decode(responseUsageCharMonth.body));

  return _getContract;
}
