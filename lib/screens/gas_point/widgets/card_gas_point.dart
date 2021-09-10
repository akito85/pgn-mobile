import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/gas_point_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;

class CardGaspoint extends StatefulWidget {
  @override
  _CardGasPointState createState() => _CardGasPointState();
}

class _CardGasPointState extends State<CardGaspoint> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 20),
        FutureBuilder<VirtualCardGasPoint>(
          future: getVirtualCardGasPoint(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/virtual_card.png'),
                    fit: BoxFit.fill,
                  ),
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
                      height: 170,
                    )
                  ],
                ),
              );
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/virtual_card.png')),
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
                      margin: EdgeInsets.only(left: 15.0, bottom: 20, top: 10),
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
            if (!snapshot.hasData) return Container();
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
                      Text(
                          snapshot.data.dataGPHistory.historyGasPoint[i].point),
                      SizedBox(width: 30),
                      Text(snapshot.data.dataGPHistory.historyGasPoint[i].type),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
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
