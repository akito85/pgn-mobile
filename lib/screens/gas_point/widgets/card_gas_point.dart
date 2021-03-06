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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 65),
          child: ListView(
            controller: _scrollController,
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.only(left: 18, right: 18),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16, top: 20),
                                  child: Text(
                                    'PGN Reward Card',
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16, top: 20),
                                child: Image.asset(
                                  'assets/icon_card.png',
                                  height: 36,
                                ),
                              )
                            ],
                          ),
                          LinearProgressIndicator(),
                          Container(
                            height: 143,
                          )
                        ],
                      ),
                    );
                  if (snapshot.hasError) return Container();
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/virtual_card.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 16, top: 20),
                                child: Text(
                                  'PGN Reward Card',
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16, top: 20),
                              child: Image.asset(
                                'assets/icon_card.png',
                                height: 36,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 16, top: 60),
                                child: Text(
                                  '${snapshot.data.dataVCGasPoint.nameCust ?? ''}',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16, top: 60),
                              child: Text(
                                'Point',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 16),
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
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, right: 16),
                              child: Text(
                                '${snapshot.data.dataVCGasPoint.pointReward ?? ''}',
                                style: TextStyle(
                                    fontSize: 26, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 5,
                            width: 55,
                            margin:
                                EdgeInsets.only(left: 16.0, bottom: 20, top: 8),
                            decoration: new BoxDecoration(
                              color: Colors.white,
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
                padding: EdgeInsets.only(left: 18, top: 20, bottom: 7),
                child: Text(
                  'PGN Point History',
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
                                formatDate(
                                        dateFormated, [dd, ' ', MM, ' ', yyyy])
                                    .toUpperCase(),
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child:
                                        Text(returnHistoryGP[i].desc ?? '-')),
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
                                          color: returnHistoryGP[i].type ==
                                                  'redeem'
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
          ),
        ),
        Positioned(
          bottom: 10,
          left: 18,
          right: 18,
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Color(0xFF427CEF),
            ),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              child: Text(
                'Redeem Point',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ),
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
