import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/url_cons.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/dashboard_chart_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<DataHourlyUsage> listHourlyUsage = [];
  String nextPage = "";
  String errorStat = "";
  bool isLoading = false;
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        isLoading = false;

        // this.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 50.0,
                        width: 60,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF4578EF),
                        ),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          child: Icon(
                            Icons.file_download,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _downloadPDF(context, period);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildContent(context, fetchPost(context, period)),
            isLoading == true ? CircularProgressIndicator : SizedBox()
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
              itemCount: listHourlyUsage.length,
              itemBuilder: (context, i) {
                return i < listHourlyUsage.length
                    ? _buildRow(listHourlyUsage[i])
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

  void _downloadPDF(BuildContext context, String period) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseDailyUsage = await http.get(
        '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-list/$period',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang
        });
    var postPDF = await http.post(
        'http://pgn-mobile-api-laravel.noxus.co.id/api/export/export_pdf_daily_usage_details',
        headers: {'Content-Type': 'application/json'},
        body: responseDailyUsage.body);

    _launchURL(postPDF.body);
  }

  void loadMore() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');

    var responseDailyUsage = await http.get(
      '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-list/$period',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
    );

    HarianDetailCustDashboard detailCustDashboard =
        HarianDetailCustDashboard.fromJson(
            json.decode(responseDailyUsage.body));
    if (detailCustDashboard.message != null &&
        detailCustDashboard.data.length == 0) {
      setState(() {
        errorStat = detailCustDashboard.message;
        isLoading = false;
      });
    } else if (detailCustDashboard.data != null) {
      setState(() {
        // nextPage = detailCustDashboard.paging.next;
        listHourlyUsage.addAll(detailCustDashboard.data);
        isLoading = false;
      });
    }
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<HarianDetailCustDashboard> fetchPost(
    BuildContext context, String title) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseDailyUsage = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/daily-list/$title',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    },
  );
  print('response daily usage ${title}');
  print('response daily usage ${responseDailyUsage.body}');
  HarianDetailCustDashboard detailCustDashboard =
      HarianDetailCustDashboard.fromJson(json.decode(responseDailyUsage.body));

  return detailCustDashboard;
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
                                  data.ghv.display ?? "-",
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
                                  data.ghv.display ?? "-",
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
                                  data.cFactor.toString(),
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
