import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/gas_point_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;

class PointsGasPoint extends StatefulWidget {
  @override
  _PointsGasPointState createState() => _PointsGasPointState();
}

class _PointsGasPointState extends State<PointsGasPoint> {
  ScrollController _scrollController = ScrollController();
  List<HistoryGasPoint> returnHistoryGP = [];
  bool _isLoading = false;
  String nextPage = '';

  @override
  void initState() {
    super.initState();
    this.getGasPointHistory(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        this.getGasPointHistory(context);
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
            'Point Accumulated',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
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
        FutureBuilder<GasPointHistoryModel>(
          future: getFutureGasPointHistory(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
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
              itemCount: returnHistoryGP.length,
              itemBuilder: (context, i) {
                DateTime dateFormated =
                    DateTime.parse(returnHistoryGP[i].dateHistory);

                return Padding(
                  padding: EdgeInsets.only(left: 23, right: 23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          formatDate(dateFormated, [dd, ' ', MM, ' ', yyyy])
                              .toUpperCase(),
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: Text(returnHistoryGP[i].desc ?? '-')),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(returnHistoryGP[i].type,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: returnHistoryGP[i].type == 'redeem'
                                          ? Color(0xFFFAC842)
                                          : Color(0xFF81C153))),
                              SizedBox(height: 5),
                              Text(
                                '${returnHistoryGP[i].point} Point',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: returnHistoryGP[i].type == 'redeem'
                                        ? Color(0xFFFAC842)
                                        : Color(0xFF81C153)),
                              ),
                            ],
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

  void getGasPointHistory(BuildContext context) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');

    var responseGetHistoryGasPoint = await http.get(
        '${UrlCons.mainDevUrl}gas_point_history?cursor=$nextPage',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        });

    if (responseGetHistoryGasPoint.statusCode == 200) {
      GasPointHistoryModel returnGetPointHistory =
          GasPointHistoryModel.fromJson(
              json.decode(responseGetHistoryGasPoint.body));
      if (returnGetPointHistory.message == null &&
          returnGetPointHistory.dataGPHistory.length > 0) {
        setState(() {
          nextPage = returnGetPointHistory.gasPointPaging.nextPage;
          returnHistoryGP.addAll(returnGetPointHistory.dataGPHistory);
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

Future<GasPointHistoryModel> getFutureGasPointHistory(
    BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseGetHistoryGasPoint =
      await http.get('${UrlCons.mainDevUrl}gas_point_history', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });

  if (responseGetHistoryGasPoint.statusCode == 200) {
    return GasPointHistoryModel.fromJson(
        json.decode(responseGetHistoryGasPoint.body));
  } else {
    throw Exception('Could not get any response');
  }
}
