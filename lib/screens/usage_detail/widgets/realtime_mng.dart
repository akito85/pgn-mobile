import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/realtime_cust_model.dart';
import 'package:pgn_mobile/models/spbg_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/usage_detail/widgets/realtime_detail_mng.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/services/app_localizations.dart';

class RealtimeMng extends StatefulWidget {
  final String title, idCust;
  RealtimeMng({this.title, this.idCust});
  @override
  RealtimeMngState createState() => RealtimeMngState(title, idCust);
}

class RealtimeMngState extends State<RealtimeMng>
    with TickerProviderStateMixin {
  final String title, idCust;
  DataSpbg data;
  RealtimeMngState(this.title, this.idCust);
  String groupID;

  List<LinearSalesDateTime> inputDataChartFlow(List<UsageDetailChar> data) {
    final myFakeDesktopData = List<LinearSalesDateTime>();

    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      myFakeDesktopData
          .add(LinearSalesDateTime(todayDate, itemData.flow.value));
    });

    return myFakeDesktopData;
  }

  List<LinearSalesDateTime> inputDataChartCounterVolume(
      List<UsageDetailChar> data) {
    final myFakeDesktopData = List<LinearSalesDateTime>();

    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      myFakeDesktopData
          .add(LinearSalesDateTime(todayDate, itemData.counterVolume.value));
    });

    return myFakeDesktopData;
  }

  List<charts.Series<LinearSalesDateTime, DateTime>> _createSampleData17(
      List<UsageDetailChar> data) {
    return [
      charts.Series<LinearSalesDateTime, DateTime>(
        id: 'Flow',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSalesDateTime sales, _) => sales.year,
        measureFn: (LinearSalesDateTime sales, _) => sales.sales,
        data: inputDataChartFlow(data),
      ),
      charts.Series<LinearSalesDateTime, DateTime>(
        id: 'CounterVolume',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSalesDateTime sales, _) => sales.year,
        measureFn: (LinearSalesDateTime sales, _) => sales.sales,
        data: inputDataChartCounterVolume(data),
      ),
    ];
  }

  dynamic storageCache = new FlutterSecureStorage();
  @override
  void initState() {
    getTitleCust();
    super.initState();
  }

  void getTitleCust() async {
    String titleCusts = await storageCache.read(key: 'usergroup_id') ?? "";
    setState(() {
      groupID = titleCusts;
    });
  }

  Widget build(BuildContext context) {
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
        _buildContent(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
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
                  child:
                      _buildCharContent(context, fetchGetChar(context, idCust)),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildCharContent(BuildContext context,
      Future<ChartUsageDetailRealtime> getChartUsageDetail) {
    return FutureBuilder<ChartUsageDetailRealtime>(
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
                              builder: (context) => RealtimeDetailMngChart(
                                    custID: idCust,
                                    title: title,
                                  )));
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
        domainAxis: new charts.DateTimeAxisSpec(
          tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
            day: new charts.TimeFormatterSpec(
              format: 'mm',
              transitionFormat: 'mm ss',
            ),
          ),
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

Future<ChartUsageDetailRealtime> fetchGetChar(
    BuildContext context, String custID) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseUsageChar = await http.get(
    '${UrlCons.mainProdUrl}customers/$custID/gas-usages/realtime-chart',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );

  ChartUsageDetailRealtime _getContract =
      ChartUsageDetailRealtime.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}
