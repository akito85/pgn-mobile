import 'dart:convert';

import 'package:date_format/date_format.dart';
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
      children: <Widget>[
        SizedBox(height: 20),
        FutureBuilder<VirtualCardGasPoint>(
          future: getVirtualCardGasPoint(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xFF00000029),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00000029).withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/card_gaspoint.jpg'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                margin: EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  children: [
                    LinearProgressIndicator(),
                    Container(
                      height: 210,
                    )
                  ],
                ),
              );
            if (snapshot.hasError) return Container();
            return Container(
              decoration: BoxDecoration(
                color: Color(0xFF00000029),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF00000029).withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage('assets/card_gaspoint.jpg'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              margin: EdgeInsets.only(left: 18, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 176,
                    margin: EdgeInsets.only(left: 16, top: 80),
                    child: Text(
                      '${snapshot.data.dataVCGasPoint.nameCust ?? ''}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 176,
                    margin: EdgeInsets.only(left: 16, top: 5),
                    child: Text(
                      '${snapshot.data.dataVCGasPoint.address ?? ''}',
                      style: TextStyle(fontSize: 10.5, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 5),
                    child: Text(
                      '${snapshot.data.dataVCGasPoint.custId ?? ''}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 15, bottom: 20),
                        child: Text(
                          'Point',
                          style: TextStyle(fontSize: 10.5, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 12, right: 16, bottom: 20),
                        child: Text(
                          '${snapshot.data.dataVCGasPoint.pointReward ?? ''}',
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
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

    print('HASILNYA GAS POINT Scroll : ${responseGetHistoryGasPoint.body}');

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

Future<VirtualCardGasPoint> getVirtualCardGasPoint(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');

  var responseGetVCGasPoint =
      await http.get('${UrlCons.mainDevUrl}virtual_card', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });

  print('HASILNYA : ${responseGetVCGasPoint.body}');
  if (responseGetVCGasPoint.statusCode == 200) {
    return VirtualCardGasPoint.fromJson(
        json.decode(responseGetVCGasPoint.body));
  } else {
    throw Exception('Could not get any response');
  }
}

Future<GasPointHistoryModel> getFutureGasPointHistory(
    BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');

  var responseGetHistoryGasPoint =
      await http.get('${UrlCons.mainDevUrl}gas_point_history', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });

  print('HASILNYA GAS POINT : ${responseGetHistoryGasPoint.body}');
  if (responseGetHistoryGasPoint.statusCode == 200) {
    return GasPointHistoryModel.fromJson(
        json.decode(responseGetHistoryGasPoint.body));
  } else {
    throw Exception('Could not get any response');
  }
}
