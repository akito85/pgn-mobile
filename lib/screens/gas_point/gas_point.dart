import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/gas_point_model.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class GasPoint extends StatefulWidget {
  @override
  _GasPointState createState() => _GasPointState();
}

class _GasPointState extends State<GasPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),

          FutureBuilder<VirtualCardGasPoint>(
            future: getVirtualCardGasPoint(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                'PGN Reward Card',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10, top: 15),
                            child: Image.asset(
                              'assets/logo_head_menu.png',
                              height: 35,
                            ),
                          )
                        ],
                      ),
                      LinearProgressIndicator(),
                      Container(
                        height: 120,
                      )
                    ],
                  ),
                );
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, top: 15),
                            child: Text(
                              'PGN Reward Card',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10, top: 15),
                          child: Image.asset(
                            'assets/logo_head_menu.png',
                            height: 35,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, top: 40),
                            child: Text(
                                '${snapshot.data.dataVCGasPoint.nameCust ?? ''}'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15, top: 40),
                          child: Text('Point'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, top: 15),
                            child: Text(
                                '${snapshot.data.dataVCGasPoint.custId ?? ''}'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15, right: 15),
                          child: Text(
                              '${snapshot.data.dataVCGasPoint.pointReward ?? ''}'),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 5,
                        width: 55,
                        margin:
                            EdgeInsets.only(left: 15.0, bottom: 20, top: 10),
                        decoration: new BoxDecoration(
                          color: Colors.blue[300],
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Padding(
            padding: EdgeInsets.only(left: 15, top: 50, bottom: 20),
            child: Text('PGN Point History'),
          ),

          FutureBuilder<GasPointHistoryModel>(
            future: getGasPointHistory(context),
            builder: (context, snapshot) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.dataGPHistory.historyGasPoint.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: Row(
                      children: [
                        Text(
                            'Date : ${snapshot.data.dataGPHistory.historyGasPoint[i].dateHistory}'),
                        SizedBox(width: 30),
                        Text(snapshot
                            .data.dataGPHistory.historyGasPoint[i].point),
                        SizedBox(width: 30),
                        Text(snapshot
                            .data.dataGPHistory.historyGasPoint[i].type),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          // Center(
          //   child: Text(
          //     '0',
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //       fontSize: 30.0,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // Center(
          //   child: Text(
          //     'Gas Point',
          //     style: TextStyle(
          //         fontWeight: FontWeight.w500, color: Color(0xFF9B9B9B)),
          //   ),
          // ),
          // Center(
          //   child: Image.asset(
          //     'assets/404-01.png',
          //     height: 300.0,
          //     width: 350.0,
          //   ),
          // ),
          // Center(
          //   child: Text(
          //     Translations.of(context).text('error_sorry'),
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //       fontSize: 20.0,
          //       fontWeight: FontWeight.w800,
          //     ),
          //   ),
          // ),
          // SizedBox(height: 8),
          // Center(
          //   child: Text(
          //     'The Data you requested is',
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //       fontSize: 15.5,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ),
          // Center(
          //   child: Text(
          //     'currently unavailable',
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //       fontSize: 15.5,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

Future<VirtualCardGasPoint> getVirtualCardGasPoint(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');

  var responseGetVCGasPoint =
      await http.get('${UrlCons.mainDevUrl}virtual_card', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });

  print('HASILNYA : ${responseGetVCGasPoint.body}');
  return VirtualCardGasPoint.fromJson(json.decode(responseGetVCGasPoint.body));
}

Future<GasPointHistoryModel> getGasPointHistory(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');

  var responseGetHistoryGasPoint =
      await http.get('${UrlCons.mainDevUrl}gas_point_history', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });

  print('HASILNYA : ${responseGetHistoryGasPoint.body}');
  return GasPointHistoryModel.fromJson(
      json.decode(responseGetHistoryGasPoint.body));
}
