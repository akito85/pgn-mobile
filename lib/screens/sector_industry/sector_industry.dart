import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/sector_industry_model.dart';

class SectorIndustry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('title_bar_gus'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: _buildContent(context, fetchPost(context)),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, Future<GetSectorIndustry> getSectorIndustry) {
    return FutureBuilder<GetSectorIndustry>(
        future: getSectorIndustry,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8,
                margin: EdgeInsets.only(
                    top: 15.0, left: 15.0, right: 15.0, bottom: 25.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 15.0, left: 20),
                              child: Text(
                                Translations.of(context)
                                    .text('f_gus_all_summary_title'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0, left: 20),
                              child: Text(
                                'Data Tanggal ${snapshot.data.meta.startDate.display} - ${snapshot.data.meta.endDate.display}',
                                style: TextStyle(
                                    color: Color(0xFF5C727D),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 20.0),
                          child: Text(
                            Translations.of(context)
                                .text('f_gus_all_summary_total_customer_label'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 35.0),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Text(
                              snapshot.data.data.totalCustomer.toString(),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 20.0, top: 10),
                          child: Text(
                            Translations.of(context).text(
                                'f_gus_all_summary_total_volume_mmscfd_label'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 35.0, top: 10),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, top: 10),
                            child: Text(
                              snapshot.data.data.totalEnergy.display,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(
                              left: 20.0, top: 10, bottom: 15.0),
                          child: Text(
                            Translations.of(context)
                                .text('f_gus_all_summary_total_volume_label'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 35.0, top: 10, bottom: 15.0),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 5.0, top: 10, bottom: 15.0),
                            child: Text(
                              snapshot.data.data.totalVolume.display,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0, left: 15, bottom: 5.0),
                child: Text(
                  Translations.of(context).text('title_bar_gus'),
                  style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.data.chart.length + 1,
                itemBuilder: (context, i) {
                  return i < snapshot.data.data.chart.length
                      ? _buildRow(snapshot.data.data.chart[i])
                      : SizedBox(
                          height: 10.0,
                        );
                },
              ),
            ],
          );
        });
  }

  Widget _buildRow(ChartSectorInd data) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: new LinearPercentIndicator(
          padding: EdgeInsets.only(left: 25, right: 25),
          backgroundColor: Color(0xFFEBEBEB),
          fillColor: Colors.white,
          animation: true,
          animationDuration: 1000,
          lineHeight: 30.0,
          percent: double.parse(data.percentage) / 100,
          center: Container(
            alignment: Alignment.centerRight,
            child: Text(
              '${data.name}-${data.energy.display} (${data.percentage}%)',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 11, color: Colors.black),
            ),
          ),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.blue[300]),
    );
  }
}

Future<GetSectorIndustry> fetchPost(BuildContext context) async {

  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  var responseGetSectorIndustry = await http
      .get('${UrlCons.prodRelyonUrl}summary/allcustomer', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });

  return GetSectorIndustry.fromJson(
      json.decode(responseGetSectorIndustry.body));
}
