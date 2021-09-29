import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/gas_point_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/dashboard/dashboard.dart';

class CardGaspoint extends StatefulWidget {
  @override
  _CardGasPointState createState() => _CardGasPointState();
}

class _CardGasPointState extends State<CardGaspoint> {
  List<HistoryGasPoint> returnHistoryGP = [];
  String nextPage = '';

  @override
  void initState() {
    super.initState();
    this.getGasPointHistory(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        Padding(
          padding: EdgeInsets.only(left: 18, top: 20, bottom: 7),
          child: Text(
            'PGN Point History',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        FutureBuilder<GasPointHistoryModel>(
          future: getFutureGasPointHistory(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
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
                    margin: EdgeInsets.only(top: 50),
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
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      returnHistoryGP.length >= 5 ? 5 : returnHistoryGP.length,
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
                              Expanded(
                                  child: Text(returnHistoryGP[i].desc ?? '-')),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(returnHistoryGP[i].type,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: returnHistoryGP[i].type ==
                                                  'redeem'
                                              ? Color(0xFFFAC842)
                                              : Color(0xFF81C153))),
                                  SizedBox(height: 5),
                                  Text(
                                    '${returnHistoryGP[i].point} Point',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            returnHistoryGP[i].type == 'redeem'
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
                ),
                Container(
                  height: 45.0,
                  margin: EdgeInsets.only(bottom: 100, left: 18, right: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xFF427CEF),
                  ),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'Show All Poin History',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      // Navigat
                      // _tabController.animateTo(1)
                    },
                  ),
                ),
              ],
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
        });
      } else {}
    } else {
      if (responseGetHistoryGasPoint.statusCode == 401) {
        print('MASUK 3');
        accessTokenAlert(context,
            "Session expired or account changed to other device, please Login again.");
      }
      throw Exception('Could not get any response');
    }
  }
}

Future<VirtualCardGasPoint> getVirtualCardGasPoint(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseGetVCGasPoint =
      await http.get('${UrlCons.mainDevUrl}virtual_card', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
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
  String lang = await storageCache.read(key: 'lang');
  var responseGetHistoryGasPoint =
      await http.get('${UrlCons.mainDevUrl}gas_point_history', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });

  print('HASILNYA GAS POINT : ${responseGetHistoryGasPoint.body}');
  // if (responseGetHistoryGasPoint.statusCode == 200) {
  return GasPointHistoryModel.fromJson(
      json.decode(responseGetHistoryGasPoint.body));
  // } else {
  //   throw Exception('Could not get any response');
  // }
}
