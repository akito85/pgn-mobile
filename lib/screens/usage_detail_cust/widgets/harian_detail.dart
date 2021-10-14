import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/url_cons.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pgn_mobile/models/dashboard_chart_model.dart';
import 'package:intl/intl.dart';

class HarianDetailCustChart extends StatefulWidget {
  HarianDetailCustChart({this.title, this.period});
  final String title;
  final String period;
  @override
  HarianDetailCustChartState createState() =>
      HarianDetailCustChartState(title, period);
}

class HarianDetailCustChartState extends State<HarianDetailCustChart> {
  final String title;
  final String period;
  HarianDetailCustChartState(this.title, this.period);
  @override
  Widget build(BuildContext context) {
    print('INI PERIODNYA : $period');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          Translations.of(context).text('title_bar_gu_daily_list'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildContent(context, fetchPost(context, period)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, Future<HarianDetailCustDashboard> getDailyDetail) {
    return FutureBuilder<HarianDetailCustDashboard>(
        future: getDailyDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          if (snapshot.data.message != null)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 180),
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
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.data.length + 1,
              itemBuilder: (context, i) {
                return i < snapshot.data.data.length
                    ? _buildRow(snapshot.data.data[i])
                    : SizedBox(
                        height: 10.0,
                      );
              });
        });
  }

  Widget _buildRow(DataHourlyUsage data) {
    return Column(
      children: <Widget>[Card1(data)],
    );
  }
}

class Card1 extends StatelessWidget {
  final DataHourlyUsage data;
  Card1(this.data);
  @override
  Widget build(BuildContext context) {
    String formatDate =
        DateFormat("dd MMM yyy").format(DateTime.parse(data.date.value));
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.top,
                    collapsed: Column(
                      children: <Widget>[
                        // for(var i in Iterable.generate(3))
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${data.date.display}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Meter ID: ${data.meterId}' ?? '-',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5C727D),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Volume',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  data.volume.display ?? "-",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'GHV',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Energi',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.energy.display}',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Tekanan',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.pressure.display}',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Temperatur',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.temp.display}',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    expanded: Column(
                      children: <Widget>[
                        // for(var i in Iterable.generate(7))
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${data.date.display}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Meter ID: ${data.meterId}' ?? '-',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5C727D),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Volume',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  data.volume.display ?? "-",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'GHV',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Energi',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.energy.display}',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Tekanan',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.pressure.display}',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Temperatur',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.temp.display}',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Faktor Koreksi',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  data.cFactor,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Uncorrected Index',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.unCIndex.display}',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Corrected Index',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.cIndex.display}',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                'Kapasitas Meter',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.meterCap.display}',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                '% Kapasitas',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 15),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, top: 15),
                                child: Text(
                                  '${data.capPer} (${data.meterStat.display})',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          crossFadePoint: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<HarianDetailCustDashboard> fetchPost(
    BuildContext context, String title) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseHourlyUsage = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-list/$title',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    },
  );

  return HarianDetailCustDashboard.fromJson(
      json.decode(responseHourlyUsage.body));
}
