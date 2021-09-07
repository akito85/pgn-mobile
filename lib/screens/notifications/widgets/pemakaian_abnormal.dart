import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/models/notification_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/harian_detail_chart.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PemakaianAbnormal extends StatefulWidget {
  @override
  PemAbnormalState createState() => PemAbnormalState();
}

class PemAbnormalState extends State<PemakaianAbnormal> {
  ScrollController _scrollController = ScrollController();
  String nextPage = "";
  String errorStat = "";
  List<DataNotifList> returnGetNotifUSage = [];
  List<DataNotifList> returnGetNotifUSagesecond = [];

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchPostNextPage(context);
        //  nextPage;
      }
    });
    if (nextPage == "") {
      fetchPost(context);
    }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: returnGetNotifUSage.length + 1,
      controller: _scrollController,
      itemBuilder: (context, i) {
        return i < returnGetNotifUSage.length
            ? _buildRow(returnGetNotifUSage[i])
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }

  Widget _buildRow(DataNotifList data) {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    String currentMonthS;
    if (currentMonth < 10) {
      currentMonthS = '0$currentMonth';
    } else {
      currentMonthS = currentMonth.toString();
    }
    String dateformatCurrent =
        '${currentYear.toString()}${currentMonthS.toString()}${currentMonthS.toString()}';
    String formatDate =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent));
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HarianDetailChart(
                  idCust: data.id,
                  period: formatDate,
                  titleApbar: Translations.of(context)
                      .text('title_bar_customer_abnormal_detail'),
                ),
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/icon_default_pelanggan.png'),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 11, right: 10),
                        child: Text(
                          data.nameCust ?? '',
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.blue[500],
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 20, top: 3),
                          child: Text(
                            'CM - ${data.aeId} | ${data.id}',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 13, left: 18, bottom: 18, right: 20),
              child: Text(
                data.address ?? '-',
                style: TextStyle(
                    color: Colors.grey[500], fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }

  void fetchPostNextPage(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('access_token');
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    GetNotificationList returnGetNotifUsages;

    var responseGetSpbg = await http.get(
        '${UrlCons.mainProdUrl}customers?issue=usage&cursor=$nextPage',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    returnGetNotifUsages =
        GetNotificationList.fromJson(json.decode(responseGetSpbg.body));
    if (nextPage == returnGetNotifUsages.paging.next) {
    } else if (nextPage != returnGetNotifUsages.paging.next) {
      setState(() {
        nextPage = returnGetNotifUsages.paging.next;
      });
      returnGetNotifUSage.addAll(returnGetNotifUsages.data);
    }
  }

  Future<GetNotificationList> fetchPost(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('access_token');
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    var responseGetSpbg = await http
        .get('${UrlCons.mainProdUrl}customers?issue=usage', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    });
    GetNotificationList returnGetNotifUsages =
        GetNotificationList.fromJson(json.decode(responseGetSpbg.body));

    if (returnGetNotifUsages.message != null &&
        returnGetNotifUSage.length == 0) {
      setState(() {
        errorStat = returnGetNotifUsages.message;
        // returnGetNotifUSage.addAll(returnGetNotifUsages.data);
      });
    } else if (returnGetNotifUsages.data != null) {
      setState(() {
        nextPage = returnGetNotifUsages.paging.next;
        returnGetNotifUSage.addAll(returnGetNotifUsages.data);
      });
      // return returnGetNotifUsages;
    }
  }
}
