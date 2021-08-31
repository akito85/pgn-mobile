import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/models/monthly_usage_trend_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:date_format/date_format.dart';
import 'package:charts_flutter/src/text_element.dart' as element;
import 'dart:math';
import 'package:charts_flutter/src/text_style.dart' as style;

class Sales extends StatelessWidget {
  List<QuarterSales> inputSalesData(List<SalesTrendChar> data) {
    final desktopSalesData = List<QuarterSales>();

    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      desktopSalesData.add(QuarterSales(int.parse(formatDate(todayDate, [dd])),
          itemData.usageSales.valueEnd));
    });

    return desktopSalesData;
  }

  List<QuarterSales> inputSalesMinData(List<SalesTrendChar> data) {
    final desktopSalesData = List<QuarterSales>();

    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      desktopSalesData.add(QuarterSales(
          int.parse(formatDate(todayDate, [dd])), itemData.minUsage.valueEnd));
    });

    return desktopSalesData;
  }

  List<QuarterSales> inputSalesMaxData(List<SalesTrendChar> data) {
    final desktopSalesData = List<QuarterSales>();

    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      desktopSalesData.add(QuarterSales(
          int.parse(formatDate(todayDate, [dd])), itemData.maxUsage.valueEnd));
    });

    return desktopSalesData;
  }

  List<QuarterSales> accumulatedSalesData(List<SalesTrendChar> data) {
    final mobileSalesData = List<QuarterSales>();

    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      mobileSalesData.add(QuarterSales(int.parse(formatDate(todayDate, [dd])),
          itemData.accumulatedUsage.valueEnd));
    });

    return mobileSalesData;
  }

  List<Series<QuarterSales, int>> mapChartData2(List<SalesTrendChar> data) {
    return [
      new Series<QuarterSales, int>(
        id: 'Desktop',
        domainFn: (QuarterSales sales, _) => sales.year,
        measureFn: (QuarterSales sales, _) => sales.sales,
        data: accumulatedSalesData(data),
      ),
      new Series<QuarterSales, int>(
        id: 'Mobile',
        domainFn: (QuarterSales sales, _) => sales.year,
        measureFn: (QuarterSales sales, _) => sales.sales,
        data: inputSalesData(data),
      ),
      new Series<QuarterSales, int>(
        id: 'Max',
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
        domainFn: (QuarterSales sales, _) => sales.year,
        measureFn: (QuarterSales sales, _) => sales.sales,
        data: inputSalesMinData(data),
      )..setAttribute(rendererIdKey, 'customLine'),
      new Series<QuarterSales, int>(
        id: 'Max',
        colorFn: (_, __) => MaterialPalette.red.shadeDefault,
        domainFn: (QuarterSales sales, _) => sales.year,
        measureFn: (QuarterSales sales, _) => sales.sales,
        data: inputSalesMaxData(data),
      )..setAttribute(rendererIdKey, 'customLine'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
          child: Column(
            children: <Widget>[
              Container(
                height: 325,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: _buildContent2(context, getCustomerContract(context)),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 15.0),
                    decoration: new BoxDecoration(
                      color: painting.Color(0xFF4578EF),
                      shape: BoxShape.rectangle,
                    ),
                    child: Text('    '),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 3.0, 0.0, 15.0),
                        child: Text(
                          Translations.of(context)
                              .text('f_gu_legend_volume_monthly'),
                          style: painting.TextStyle(
                            fontSize: 10.0,
                          ),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 15.0),
                    decoration: new BoxDecoration(
                      color: Colors.blue[200],
                      shape: BoxShape.rectangle,
                    ),
                    child: Text('    '),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 3.0, 0.0, 15.0),
                        child: Text(
                          Translations.of(context)
                              .text('f_gu_legend_volume_cumulative'),
                          style: painting.TextStyle(
                            fontSize: 10.0,
                          ),
                        )),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 15.0),
                    decoration: new BoxDecoration(
                      color: Colors.green[300],
                      shape: BoxShape.rectangle,
                    ),
                    child: Text('    '),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 3.0, 0.0, 15.0),
                        child: Text(
                          Translations.of(context)
                              .text('f_gu_legend_min_contract'),
                          style: painting.TextStyle(
                            fontSize: 10.0,
                          ),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 15.0),
                    decoration: new BoxDecoration(
                      color: Colors.red[300],
                      shape: BoxShape.rectangle,
                    ),
                    child: Text('    '),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 3.0, 25.0, 15.0),
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
          ),
        )
      ],
    );
  }

  Widget _buildContent2(
      BuildContext context, Future<SalesUsageTrend> getTrendHarian) {
    return FutureBuilder<SalesUsageTrend>(
      future: getTrendHarian,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[LinearProgressIndicator()],
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
                    ? _buildRow2(snapshot.data.data)
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

  Widget _buildRow2(List<SalesTrendChar> data) {
    return Container(
      height: 268,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: SimpleBarChart2(mapChartData2(data)),
      ),
    );
  }
}

class SimpleBarChart2 extends StatefulWidget {
  final List<Series> seriesList;
  final bool animate;
  static String pointerValue;
  SimpleBarChart2(this.seriesList, {this.animate = true});

  @override
  _SimpleBarChartState2 createState() => _SimpleBarChartState2(seriesList);
}

class _SimpleBarChartState2 extends State<SimpleBarChart2> {
  final List<Series> seriesList;
  final bool animate;
  String valueText = "0.0";
  static String pointerValue;
  String titleText;
  Widget chartNumericCombo;
  final formatCurrency =
      new NumberFormat.currency(locale: "en_US", symbol: " ", decimalDigits: 0);
  _SimpleBarChartState2(this.seriesList, {this.animate = true});

  @override
  void initState() {
    super.initState();
    setState(() {
      chartNumericCombo = NumericComboChart(
        seriesList,
        animate: animate,
        domainAxis: NumericAxisSpec(
          tickProviderSpec: BasicNumericTickProviderSpec(desiredTickCount: 6),
        ),
        defaultRenderer:
            BarRendererConfig(groupingType: BarGroupingType.stacked),
        behaviors: [
          LinePointHighlighter(
              symbolRenderer: CustomCircleSymbolRenderer(text: valueText)),
          SelectNearest(eventTrigger: SelectionTrigger.tapAndDrag)
        ],
        customSeriesRenderers: [
          LineRendererConfig(customRendererId: 'customLine')
        ],
        primaryMeasureAxis: NumericAxisSpec(
            tickProviderSpec:
                BasicNumericTickProviderSpec(desiredTickCount: 5)),
        selectionModels: [
          SelectionModelConfig(changedListener: (SelectionModel model) {
            setState(() {
              valueText =
                  '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}';
              titleText =
                  '${model.selectedSeries[0].domainFn(model.selectedDatum[0].index)}';
            });
          })
        ],
      );
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          child: chartNumericCombo,
        ),
        SizedBox(height: 20),
        titleText != null
            ? Text(
                'Energy(${DateFormat("MMM").format(DateTime.now())} $titleText) : ${formatCurrency.format(double.parse(valueText)) ?? ''}',
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
        element.TextElement(_SimpleBarChartState2.pointerValue,
            style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round());
  }
}

class QuarterSales {
  final int year;
  final int sales;

  QuarterSales(this.year, this.sales);
}

Future<SalesUsageTrend> getCustomerContract(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token');
  String currentMonthS;
  String zeroString = '0';
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  if (currentMonth < 10) {
    currentMonthS = '$currentYear$zeroString$currentMonth';
  } else {
    currentMonthS = '$currentYear$currentMonth';
  }
  var responseUsageTrend = await http
      .get('${UrlCons.getUsageContractChart}$currentMonthS', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });
  SalesUsageTrend _getContract =
      SalesUsageTrend.fromJson(json.decode(responseUsageTrend.body));

  return _getContract;
}
