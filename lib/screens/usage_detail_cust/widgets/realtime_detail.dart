import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/realtime_cust_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RealtimeDetailCustChart extends StatefulWidget {
  RealtimeDetailCustChart({this.title, this.period});
  final String title;
  final String period;
  @override
  RealtimeDetailCustChartState createState() =>
      RealtimeDetailCustChartState(title, period);
}

class RealtimeDetailCustChartState extends State<RealtimeDetailCustChart> {
  final String title;
  final String period;
  RealtimeDetailCustChartState(this.title, this.period);
  @override
  Widget build(BuildContext context) {
    print('INI PERIODNYA : $period');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Realtime Detail',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context,
      Future<ChartUsageDetailRealtimeDetail> getDailyDetail) {
    return FutureBuilder<ChartUsageDetailRealtimeDetail>(
        future: getDailyDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Column(
              children: [
                SizedBox(height: 10),
                LinearProgressIndicator(),
              ],
            );
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

  Widget _buildRow(UsageDetailList data) {
    return Column(
      children: <Widget>[Card1(data)],
    );
  }
}

class Card1 extends StatelessWidget {
  final UsageDetailList data;
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
                // for(var i in Iterable.generate(3))
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${data.date.display}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          data.counterVolume.display ?? "-",
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
                        'Flow',
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
                          data.flow.display,
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
                        'Temprature',
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
                          '${data.tempratureList.display}',
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
                          '${data.pressureVolumeList.display}',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<ChartUsageDetailRealtimeDetail> fetchPost(
    BuildContext context, String title) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseDailyUsage = await http.get(
    '${UrlCons.mainProdUrl}customers/me/gas-usages/realtime-list',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    },
  );
  print('HASIL GET LIST HARIAN : ${responseDailyUsage.body}');
  return ChartUsageDetailRealtimeDetail.fromJson(
      json.decode(responseDailyUsage.body));
}

void _downloadPDF(BuildContext context, String period) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseDailyUsage = await http.get(
      '${UrlCons.mainProdUrl}customers/me/gas-usages/realtime-list',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      });
  var postPDF = await http.post(
      'http://pgn-mobile-api-laravel.noxus.co.id/api/export/export_pdf_realtime_usage_detail',
      headers: {'Content-Type': 'application/json'},
      body: responseDailyUsage.body);

  _launchURL(postPDF.body);
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
