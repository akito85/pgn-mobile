import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/gas_point_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;

class RedeemGasPoint extends StatefulWidget {
  @override
  _RedeemGasPointState createState() => _RedeemGasPointState();
}

class _RedeemGasPointState extends State<RedeemGasPoint> {
  ScrollController _scrollController = ScrollController();
  List<DataGetRedeem> returnHistoryRedeem = [];
  bool _isLoading = false;
  String nextPage = '';

  @override
  void initState() {
    super.initState();
    this.getRedeemistory(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        this.getRedeemistory(context);
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
    return ListView(
      controller: _scrollController,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18, top: 20, bottom: 7),
          child: Text(
            'List of Reward Redeemed',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18, right: 18, bottom: 7),
          child: Divider(
            color: Color(0xFFF4F4F4),
            thickness: 2,
          ),
        ),
        FutureBuilder<RedeemHistoryModel>(
          future: getFutureRedeemHistory(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
                child: LinearProgressIndicator(),
              );
            if (snapshot.hasError)
              return Container(
                child: Text(snapshot.error),
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
                  Center(
                    child: Text(
                      snapshot.data.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              );
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: returnHistoryRedeem.length,
              itemBuilder: (context, i) {
                DateTime dateFormated =
                    DateTime.parse(returnHistoryRedeem[i].redeemDate);

                return Padding(
                  padding: EdgeInsets.only(left: 23, right: 23),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Image.network(
                              returnHistoryRedeem[i].imgUrl,
                              width: 76,
                              height: 76,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        formatDate(dateFormated, [
                                          dd,
                                          ' ',
                                          MM,
                                          ' ',
                                          yyyy
                                        ]).toUpperCase(),
                                        style: TextStyle(fontSize: 11),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 9, right: 9),
                                      decoration: BoxDecoration(
                                          color: returnHistoryRedeem[i]
                                                      .idStatusRedeem ==
                                                  1
                                              ? Color(0xFF02ACEF)
                                              : returnHistoryRedeem[i]
                                                          .idStatusRedeem ==
                                                      2
                                                  ? Color(0xFFFAC842)
                                                  : returnHistoryRedeem[i]
                                                              .idStatusRedeem ==
                                                          4
                                                      ? Color(0xFFFF0000)
                                                      : Color(0xFF81C153),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                          '${returnHistoryRedeem[i].statusRedeem}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.5,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(returnHistoryRedeem[i].name ?? '-'),
                                SizedBox(height: 6),
                                Text(
                                  'Redeem ${returnHistoryRedeem[i].pointRewardCost} Point',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFAC842)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        child: Divider(
                          color: Color(0xFFF4F4F4),
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        _isLoading
            ? Center(
                child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: CircularProgressIndicator(),
              ))
            : SizedBox(height: 10),
      ],
    );
  }

  void getRedeemistory(BuildContext context) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetRedeemGasPoint = await http
        .get('${UrlCons.mainDevUrl}redeem_history?cursor=$nextPage', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    });

    print('HASILNYA GAS POINT Scroll : ${responseGetRedeemGasPoint.body}');

    if (responseGetRedeemGasPoint.statusCode == 200) {
      RedeemHistoryModel returnGetRedeemHistory = RedeemHistoryModel.fromJson(
          json.decode(responseGetRedeemGasPoint.body));
      if (returnGetRedeemHistory.message == null &&
          returnGetRedeemHistory.dataGetRedeem.length > 0) {
        setState(() {
          nextPage = returnGetRedeemHistory.gasPointPaging.nextPage;
          returnHistoryRedeem.addAll(returnGetRedeemHistory.dataGetRedeem);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      throw Exception('Could not get any response');
    }
  }
}

Future<RedeemHistoryModel> getFutureRedeemHistory(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseGetRedeemGasPoint =
      await http.get('${UrlCons.mainDevUrl}redeem_history', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });

  print('HASILNYA GAS POINT : ${responseGetRedeemGasPoint.body}');
  if (responseGetRedeemGasPoint.statusCode == 200) {
    return RedeemHistoryModel.fromJson(
        json.decode(responseGetRedeemGasPoint.body));
  } else {
    throw Exception('Could not get any response');
  }
}
