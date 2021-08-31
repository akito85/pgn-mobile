import 'package:flutter/material.dart';
import 'package:pgn_mobile/models/daily_usage_detail_chart.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class HarianDetailChart extends StatefulWidget {
  HarianDetailChart({this.idCust, this.period, this.titleApbar});
  final String titleApbar;
  final String idCust;
  final String period;
  @override
  HarianDetailChartState createState() =>
      HarianDetailChartState(idCust, period, titleApbar);
}

class HarianDetailChartState extends State<HarianDetailChart> {
  final String idCust;
  final String period;
  final String titleApbar;
  HarianDetailChartState(this.idCust, this.period, this.titleApbar);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          titleApbar,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/new_backgound.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              _buildContent(context, fetchPost(context, idCust, period)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, Future<DailyUsageDetailChart> getDailyDetail) {
    return FutureBuilder<DailyUsageDetailChart>(
        future: getDailyDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
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

  Widget _buildRow(DataDailyUsageChart data) {
    return Column(
      children: <Widget>[Card1(data)],
    );
  }
}

class Card1 extends StatelessWidget {
  final DataDailyUsageChart data;
  Card1(this.data);

  @override
  Widget build(BuildContext context) {
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
                      // for(var i in Iterable.generate(4))
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 11, right: 14),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data.date.display ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context)
                                  .text('f_gu_legend_volume'),
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
                            width: 125,
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context)
                                  .text('row_daily_usage_tv_energy_label'),
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
                                data.energy.display ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context)
                                  .text('row_hourly_usage_tv_pressure_label'),
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
                                data.pressure.display ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(
                                left: 20.0, top: 15, bottom: 10),
                            child: Text(
                              Translations.of(context).text(
                                  'row_hourly_usage_tv_temperature_label'),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 35.0, top: 15, bottom: 10),
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
                              margin: EdgeInsets.only(
                                  left: 5.0, top: 15, bottom: 10),
                              child: Text(
                                data.temp.display ?? "-",
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
                      // for(var i in Iterable.generate(11))
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data.date.display ?? "-",
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
                            width: 125,
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
                            width: 125,
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context)
                                  .text('row_daily_usage_tv_energy_label'),
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
                                data.energy.display ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context)
                                  .text('row_hourly_usage_tv_pressure_label'),
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
                                data.pressure.display ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context).text(
                                  'row_hourly_usage_tv_temperature_label'),
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
                                data.temp.display ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context).text(
                                  'row_hourly_usage_tv_correction_factor_label'),
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
                                data.cFactor ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context).text(
                                  'row_hourly_usage_tv_uncorrected_index_label'),
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
                                data.unCIndex.display ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context).text(
                                  'row_hourly_usage_tv_corrected_index_label'),
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
                                data.cIndex.display ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context).text(
                                  'row_daily_usage_tv_metercapacity_label'),
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
                                data.meterCap.display ?? "-",
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
                            width: 125,
                            margin: EdgeInsets.only(
                                left: 20.0, top: 15, bottom: 10),
                            child: Text(
                              Translations.of(context).text(
                                  'row_daily_usage_tv_metercapacity_percentage_label'),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 35.0, top: 15, bottom: 10),
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
                              margin: EdgeInsets.only(
                                  left: 5.0, top: 15, bottom: 10),
                              child: Text(
                                data.meterStat.display ?? "-",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green[600]),
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
    ));
  }
}

Future<DailyUsageDetailChart> fetchPost(
    BuildContext context, String idCust, String period) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token');
  String lang = prefs.getString('lang');
  var responseHourlyUsage = await http.get(
      '${UrlCons.mainProdUrl}customers/$idCust/gas-usages/daily-list/$period',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang,
      });

  return DailyUsageDetailChart.fromJson(json.decode(responseHourlyUsage.body));
}
