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
      //print('INI DATANYA ${itemData.date.value}');
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
    getTitleCust();
    getPeriod();
    super.initState();
  }

  void getTitleCust() async {
    String titleCusts = await storageCache.read(key: 'usergroup_id') ?? "";
    setState(() {
      groupID = titleCusts;
    });
  }

  String periodSelected;
  List<String> listPeriod = [];
  int indexDropDown = 5;
  String hintPeriod = DateFormat("MMMM yyyy").format(DateTime.now()).toString();
  bool vis0 = false;
  bool vis1 = false;
  bool vis2 = false;
  bool vis3 = false;
  bool vis4 = false;
  bool vis5 = true;
  void getPeriod() {
    final now = DateTime.now();
    final sixMonthAgo = now.subtract(Duration(days: 150));
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
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, top: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFF427CEF), width: 2)),
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 8),
                child: DropdownButton(
                    hint: Text(
                        DateFormat("MMMM yyyy")
                            .format(DateTime.now())
                            .toString(),
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down_circle_rounded,
                        color: Color(0xFF427CEF)),
                    isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(
                        color: Color(0xFF455055),
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                    value: periodSelected,
                    onChanged: (newValue) {
                      //print('SELECTEDs $newValue');
                      setState(() {
                        periodSelected = newValue;
                        indexDropDown = listPeriod.indexOf(newValue);
                        if (indexDropDown == 0) {
                          vis0 = true;
                          vis1 = false;
                          vis2 = false;
                          vis3 = false;
                          vis4 = false;
                          vis5 = false;
                        } else if (indexDropDown == 1) {
                          vis0 = false;
                          vis1 = true;
                          vis2 = false;
                          vis3 = false;
                          vis4 = false;
                          vis5 = false;
                        } else if (indexDropDown == 2) {
                          vis0 = false;
                          vis1 = false;
                          vis2 = true;
                          vis3 = false;
                          vis4 = false;
                          vis5 = false;
                        } else if (indexDropDown == 3) {
                          vis0 = false;
                          vis1 = false;
                          vis2 = false;
                          vis3 = true;
                          vis4 = false;
                          vis5 = false;
                        } else if (indexDropDown == 4) {
                          vis0 = false;
                          vis1 = false;
                          vis2 = false;
                          vis3 = false;
                          vis4 = true;
                          vis5 = false;
                        } else if (indexDropDown == 5) {
                          vis0 = false;
                          vis1 = false;
                          vis2 = false;
                          vis3 = false;
                          vis4 = false;
                          vis5 = true;
                        }
                      });

                      //print('SELECTED $periodSelected');
                    },
                    items: listPeriod.map((valueItem) {
                      DateTime date = DateTime.parse(valueItem);
                      return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                              DateFormat("MMMM yyyy").format(date).toString()));
                    }).toList()))),
        Visibility(
          visible: vis0,
          child: _buildCharContent(
              context,
              fetchGetChar(context, listPeriod[0], idCust),
              periodSelected != null ? periodSelected : hintPeriod),
        ),
        Visibility(
          visible: vis1,
          child: _buildCharContent2(
              context,
              fetchGetChar2(context, listPeriod[1], idCust),
              periodSelected != null ? periodSelected : hintPeriod),
        ),
        Visibility(
          visible: vis2,
          child: _buildCharContent3(
              context,
              fetchGetChar3(context, listPeriod[2], idCust),
              periodSelected != null ? periodSelected : hintPeriod),
        ),
        Visibility(
          visible: vis3,
          child: _buildCharContent4(
              context,
              fetchGetChar4(context, listPeriod[3], idCust),
              periodSelected != null ? periodSelected : hintPeriod),
        ),
        Visibility(
          visible: vis4,
          child: _buildCharContent5(
              context,
              fetchGetChar5(context, listPeriod[4], idCust),
              periodSelected != null ? periodSelected : hintPeriod),
        ),
        Visibility(
          visible: vis5,
          child: _buildCharContent6(
              context,
              fetchGetChar6(context, listPeriod[5], idCust),
              periodSelected != null ? periodSelected : hintPeriod),
        )
      ],
    );
  }

  Widget _buildCharContent(BuildContext context,
      Future<ChartUsageDetail> getChartUsageDetail, String period) {
    //print('PERIOD CHANGE $period');

    return FutureBuilder<ChartUsageDetail>(
        future: getChartUsageDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
                            children: <Widget>[
                              LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          if (snapshot.data.message != null)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
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
                                  style: TextStyle(
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
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          return Container(
            margin: EdgeInsets.only(top: 30, left: 5, right: 5),
            height: 350,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 320,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 140,
                                    margin:
                                        EdgeInsets.only(left: 14.0, top: 18.0),
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
                                  margin:
                                      EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: painting.Color(0xFF4578EF),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          5.0, 2.0, 0.0, 0.0),
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
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.blue),
                                    child: Text(
                                      Translations.of(context).text(
                                          'f_customer_gas_usage_detail_bt_detail'),
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () {
                                    //print('ini titlenyaaa : $title');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HarianDetailCustChart(
                                                    title: title,
                                                    period: DateFormat("yyyyMM")
                                                        .format(DateTime.parse(
                                                            period))
                                                        .toString())));
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  Widget _buildCharContent6(BuildContext context,
      Future<ChartUsageDetail> getChartUsageDetail, String period) {
    //print('PERIOD CHANGE $period');

    return FutureBuilder<ChartUsageDetail>(
        future: getChartUsageDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
                            children: <Widget>[
                              LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          if (snapshot.data.message != null)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
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
                                  style: TextStyle(
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
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          return Container(
            margin: EdgeInsets.only(top: 30, left: 5, right: 5),
            height: 350,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 320,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 140,
                                    margin:
                                        EdgeInsets.only(left: 14.0, top: 18.0),
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
                                  margin:
                                      EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: painting.Color(0xFF4578EF),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          5.0, 2.0, 0.0, 0.0),
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
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.blue),
                                    child: Text(
                                      Translations.of(context).text(
                                          'f_customer_gas_usage_detail_bt_detail'),
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () {
                                    //print('ini titlenyaaa : $title');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HarianDetailCustChart(
                                                    title: title,
                                                    period: DateFormat("yyyyMM")
                                                        .format(DateTime.parse(
                                                            period))
                                                        .toString())));
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  Widget _buildCharContent2(BuildContext context,
      Future<ChartUsageDetail> getChartUsageDetail, String period) {
    //print('PERIOD CHANGE $period');

    return FutureBuilder<ChartUsageDetail>(
        future: getChartUsageDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
                            children: <Widget>[
                              LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          if (snapshot.data.message != null)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
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
                                  style: TextStyle(
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
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          return Container(
            margin: EdgeInsets.only(top: 30, left: 5, right: 5),
            height: 350,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 320,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 140,
                                    margin:
                                        EdgeInsets.only(left: 14.0, top: 18.0),
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
                                  margin:
                                      EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: painting.Color(0xFF4578EF),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          5.0, 2.0, 0.0, 0.0),
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
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.blue),
                                    child: Text(
                                      Translations.of(context).text(
                                          'f_customer_gas_usage_detail_bt_detail'),
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () {
                                    //print('ini titlenyaaa : $title');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HarianDetailCustChart(
                                                    title: title,
                                                    period: DateFormat("yyyyMM")
                                                        .format(DateTime.parse(
                                                            period))
                                                        .toString())));
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  Widget _buildCharContent3(BuildContext context,
      Future<ChartUsageDetail> getChartUsageDetail, String period) {
    //print('PERIOD CHANGE $period');

    return FutureBuilder<ChartUsageDetail>(
        future: getChartUsageDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
                            children: <Widget>[
                              LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          if (snapshot.data.message != null)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
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
                                  style: TextStyle(
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
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          return Container(
            margin: EdgeInsets.only(top: 30, left: 5, right: 5),
            height: 350,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 320,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 140,
                                    margin:
                                        EdgeInsets.only(left: 14.0, top: 18.0),
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
                                  margin:
                                      EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: painting.Color(0xFF4578EF),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          5.0, 2.0, 0.0, 0.0),
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
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.blue),
                                    child: Text(
                                      Translations.of(context).text(
                                          'f_customer_gas_usage_detail_bt_detail'),
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () {
                                    //print('ini titlenyaaa : $title');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HarianDetailCustChart(
                                                    title: title,
                                                    period: DateFormat("yyyyMM")
                                                        .format(DateTime.parse(
                                                            period))
                                                        .toString())));
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  Widget _buildCharContent4(BuildContext context,
      Future<ChartUsageDetail> getChartUsageDetail, String period) {
    //print('PERIOD CHANGE $period');

    return FutureBuilder<ChartUsageDetail>(
        future: getChartUsageDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
                            children: <Widget>[
                              LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          if (snapshot.data.message != null)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
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
                                  style: TextStyle(
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
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          return Container(
            margin: EdgeInsets.only(top: 30, left: 5, right: 5),
            height: 350,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 320,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 140,
                                    margin:
                                        EdgeInsets.only(left: 14.0, top: 18.0),
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
                                  margin:
                                      EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: painting.Color(0xFF4578EF),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          5.0, 2.0, 0.0, 0.0),
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
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.blue),
                                    child: Text(
                                      Translations.of(context).text(
                                          'f_customer_gas_usage_detail_bt_detail'),
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () {
                                    //print('ini titlenyaaa : $title');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HarianDetailCustChart(
                                                    title: title,
                                                    period: DateFormat("yyyyMM")
                                                        .format(DateTime.parse(
                                                            period))
                                                        .toString())));
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  Widget _buildCharContent5(BuildContext context,
      Future<ChartUsageDetail> getChartUsageDetail, String period) {
    //print('PERIOD CHANGE $period');

    return FutureBuilder<ChartUsageDetail>(
        future: getChartUsageDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
                            children: <Widget>[
                              LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          if (snapshot.data.message != null)
            return Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
              height: 350,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 320,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                          child: Column(
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
                                  style: TextStyle(
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
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );

          return Container(
            margin: EdgeInsets.only(top: 30, left: 5, right: 5),
            height: 350,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 320,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 140,
                                    margin:
                                        EdgeInsets.only(left: 14.0, top: 18.0),
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
                                  margin:
                                      EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: painting.Color(0xFF4578EF),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          5.0, 2.0, 0.0, 0.0),
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
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.blue),
                                    child: Text(
                                      Translations.of(context).text(
                                          'f_customer_gas_usage_detail_bt_detail'),
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () {
                                    //print('ini titlenyaaa : $title');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HarianDetailCustChart(
                                                    title: title,
                                                    period: DateFormat("yyyyMM")
                                                        .format(DateTime.parse(
                                                            period))
                                                        .toString())));
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  Widget _buildRow(List<UsageDetailChar> data) {
    //print('DATANYA ${data[0].date.display}');
    //print('INDEXNYA  $indexDropDown');
    return indexDropDown == 0
        ? Container(
            height: 212,
            child: Padding(
                padding: EdgeInsets.all(1.0),
                child: SimpleLineCharts(_createSampleData17(data))),
          )
        : indexDropDown == 1
            ? Container(
                height: 212,
                child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: SimpleLineCharts2(_createSampleData17(data))),
              )
            : indexDropDown == 2
                ? Container(
                    height: 212,
                    child: Padding(
                        padding: EdgeInsets.all(1.0),
                        child: SimpleLineCharts3(_createSampleData17(data))),
                  )
                : indexDropDown == 3
                    ? Container(
                        height: 212,
                        child: Padding(
                            padding: EdgeInsets.all(1.0),
                            child:
                                SimpleLineCharts4(_createSampleData17(data))),
                      )
                    : indexDropDown == 4
                        ? Container(
                            height: 212,
                            child: Padding(
                                padding: EdgeInsets.all(1.0),
                                child: SimpleLineCharts5(
                                    _createSampleData17(data))),
                          )
                        : Container(
                            height: 212,
                            child: Padding(
                                padding: EdgeInsets.all(1.0),
                                child: SimpleLineCharts6(
                                    _createSampleData17(data))),
                          );
    ;
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

class SimpleLineCharts2 extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  SimpleLineCharts2(this.seriesList, {this.animate = true});
  @override
  SimpleLineChart2 createState() => SimpleLineChart2(seriesList);
}

class SimpleLineCharts3 extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  SimpleLineCharts3(this.seriesList, {this.animate = true});
  @override
  SimpleLineChart3 createState() => SimpleLineChart3(seriesList);
}

class SimpleLineCharts4 extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  SimpleLineCharts4(this.seriesList, {this.animate = true});
  @override
  SimpleLineChart4 createState() => SimpleLineChart4(seriesList);
}

class SimpleLineCharts5 extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  SimpleLineCharts5(this.seriesList, {this.animate = true});
  @override
  SimpleLineChart5 createState() => SimpleLineChart5(seriesList);
}

class SimpleLineCharts6 extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  SimpleLineCharts6(this.seriesList, {this.animate = true});
  @override
  SimpleLineChart6 createState() => SimpleLineChart6(seriesList);
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

class SimpleLineChart2 extends State<SimpleLineCharts2> {
  final List<charts.Series> seriesList;
  final bool animate;
  String valueText = '0';
  String titleText;
  Widget _timeSeriesChart;
  SimpleLineChart2(this.seriesList, {this.animate = true});

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

class SimpleLineChart3 extends State<SimpleLineCharts3> {
  final List<charts.Series> seriesList;
  final bool animate;
  String valueText = '0';
  String titleText;
  Widget _timeSeriesChart;
  SimpleLineChart3(this.seriesList, {this.animate = true});

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

class SimpleLineChart4 extends State<SimpleLineCharts4> {
  final List<charts.Series> seriesList;
  final bool animate;
  String valueText = '0';
  String titleText;
  Widget _timeSeriesChart;
  SimpleLineChart4(this.seriesList, {this.animate = true});

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

class SimpleLineChart5 extends State<SimpleLineCharts5> {
  final List<charts.Series> seriesList;
  final bool animate;
  String valueText = '0';
  String titleText;
  Widget _timeSeriesChart;
  SimpleLineChart5(this.seriesList, {this.animate = true});

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

class SimpleLineChart6 extends State<SimpleLineCharts6> {
  final List<charts.Series> seriesList;
  final bool animate;
  String valueText = '0';
  String titleText;
  Widget _timeSeriesChart;
  SimpleLineChart6(this.seriesList, {this.animate = true});

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
    BuildContext context, String period, String custID) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  //print('PERIOD NYA $period');
  DateTime date = DateTime.parse(period);
  String periodDate = DateFormat("yyyyMM").format(date).toString();

  var responseUsageChar = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-chart/$periodDate',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );
  //print('TITLE PERIOD : $period');
  //print('HASIL GET USAGE : ${responseUsageChar.body}');
  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}

Future<ChartUsageDetail> fetchGetChar0(
    BuildContext context, String period, String custID) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  //print('PERIOD NYA $period');
  DateTime date = DateTime.parse(period);
  String periodDate = DateFormat("yyyyMM").format(date).toString();

  var responseUsageChar = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-chart/$periodDate',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );
  //print('TITLE PERIOD : $period');
  //print('HASIL GET USAGE : ${responseUsageChar.body}');
  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}

Future<ChartUsageDetail> fetchGetChar6(
    BuildContext context, String period, String custID) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  //print('PERIOD NYA $period');
  DateTime date = DateTime.parse(period);
  String periodDate = DateFormat("yyyyMM").format(date).toString();

  var responseUsageChar = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-chart/$periodDate',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );
  //print('TITLE PERIOD : $period');
  //print('HASIL GET USAGE : ${responseUsageChar.body}');
  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}

Future<ChartUsageDetail> fetchGetChar2(
    BuildContext context, String period, String custID) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  //print('PERIOD NYA $period');
  DateTime date = DateTime.parse(period);
  String periodDate = DateFormat("yyyyMM").format(date).toString();

  var responseUsageChar = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-chart/$periodDate',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );
  //print('TITLE PERIOD : $period');
  //print('HASIL GET USAGE : ${responseUsageChar.body}');
  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}

Future<ChartUsageDetail> fetchGetChar3(
    BuildContext context, String period, String custID) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  //print('PERIOD NYA $period');
  DateTime date = DateTime.parse(period);
  String periodDate = DateFormat("yyyyMM").format(date).toString();

  var responseUsageChar = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-chart/$periodDate',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );
  //print('TITLE PERIOD : $period');
  //print('HASIL GET USAGE : ${responseUsageChar.body}');
  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}

Future<ChartUsageDetail> fetchGetChar4(
    BuildContext context, String period, String custID) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  //print('PERIOD NYA $period');
  DateTime date = DateTime.parse(period);
  String periodDate = DateFormat("yyyyMM").format(date).toString();

  var responseUsageChar = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-chart/$periodDate',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );
  //print('TITLE PERIOD : $period');
  //print('HASIL GET USAGE : ${responseUsageChar.body}');
  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}

Future<ChartUsageDetail> fetchGetChar5(
    BuildContext context, String period, String custID) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  //print('PERIOD NYA $period');
  DateTime date = DateTime.parse(period);
  String periodDate = DateFormat("yyyyMM").format(date).toString();

  var responseUsageChar = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-chart/$periodDate',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );
  //print('TITLE PERIOD : $period');
  //print('HASIL GET USAGE : ${responseUsageChar.body}');
  ChartUsageDetail _getContract =
      ChartUsageDetail.fromJson(json.decode(responseUsageChar.body));

  return _getContract;
}
