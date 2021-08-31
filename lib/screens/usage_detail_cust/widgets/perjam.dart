import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pgn_mobile/models/hourly_usage_detail_model.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

class Perjam extends StatefulWidget {
  final String title, idCust;
  Perjam({this.title, this.idCust});
  @override
  PerJamTabDetailState createState() => PerJamTabDetailState(title, idCust);
}

class PerJamTabDetailState extends State<Perjam> {
  final String title, idCust;
  PerJamTabDetailState(this.title, this.idCust);

  List<DataHourlyUsage> returnGetUsageHourly = [];
  Future<HourlyUsageDetail> getSpbg;
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  String nextPage = "";
  String errorStat = "";

  @override
  void initState() {
    this.fetchPostNextPage(context, idCust);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.fetchPostNextPage(context, idCust);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (errorStat != "")
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/penggunaan_gas.png'),
          ),
          SizedBox(height: 20),
          Container(
            child: Text(
              errorStat,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 40),
        ],
      );
    return ListView(
      controller: _scrollController,
      shrinkWrap: true,
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
                        _downloadPDF(context, idCust);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildList(),
      ],
    );
  }

  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: returnGetUsageHourly.length + 1,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        if (i == returnGetUsageHourly.length) {
          return _buildProgressIndicator();
        } else {
          return i < returnGetUsageHourly.length
              ? _buildRow(returnGetUsageHourly[i])
              : SizedBox(
                  height: 10.0,
                );
        }
      },
    );
  }

  Widget _buildRow(DataHourlyUsage data) {
    return Column(
      children: <Widget>[
        Card1(data),
      ],
    );
  }

  Future<HourlyUsageDetail> fetchPostNextPage(
      BuildContext context, String idCust) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    String lang = prefs.getString('lang');
    var responseHourlyUsage = await http.get(
      '${UrlCons.mainProdUrl}customers/me/gas-usages/hourly-list',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
    );
    HourlyUsageDetail _getNextPage =
        HourlyUsageDetail.fromJson(json.decode(responseHourlyUsage.body));
    if (_getNextPage.message != null) {
      setState(() {
        errorStat = _getNextPage.message;
      });
    } else if (_getNextPage.data != null) {
      setState(() {
        errorStat = "";
        nextPage = _getNextPage.paging.next;
      });
      returnGetUsageHourly.addAll(_getNextPage.data);
    }
  }
}

class Card1 extends StatelessWidget {
  final DataHourlyUsage data;
  Card1(this.data);

  @override
  Widget build(BuildContext context) {
    String formatDate =
        DateFormat("dd MMM yyy").format(DateTime.parse(data.date));
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
                          margin: EdgeInsets.only(left: 20, top: 11, right: 14),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '$formatDate | ${data.hour}:00',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 5, right: 14),
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
                              margin: EdgeInsets.only(left: 20.0, top: 23),
                              child: Text(
                                'Pemakaian',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 35.0, top: 23),
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
                                margin: EdgeInsets.only(left: 5.0, top: 23),
                                child: Text(
                                  '0.00 Sm3',
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
                                  '${data.pressure} BarA',
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
                                  '${data.temp} Celsius',
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
                          margin: EdgeInsets.only(left: 20, top: 11),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '$formatDate | ${data.hour}:00',
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
                              margin: EdgeInsets.only(left: 20.0, top: 23),
                              child: Text(
                                'Pemakaian',
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
                                  '0.00 Sm3',
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
                                  '${data.pressure} BarA',
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
                                  '${data.temp} Celsius',
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
                                  '${data.unCIndex} m3',
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
                                  '${data.cIndex} Sm3',
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
                                'Estimated Energy',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 15),
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
                                  '-',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 19)
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10, bottom: 5),
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

void _downloadPDF(BuildContext context, String idCust) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token');
  String lang = prefs.getString('lang');
  var responseHourlyUsage = await http.get(
      '${UrlCons.mainProdUrl}customers/me/gas-usages/hourly-list',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      });
  var postPDF = await http.post(
      'http://pgn-mobile-api-laravel.noxus.co.id/api/export/export_pdf_usage_details',
      headers: {'Content-Type': 'application/json'},
      body: responseHourlyUsage.body);

  _launchURL(postPDF.body);
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
