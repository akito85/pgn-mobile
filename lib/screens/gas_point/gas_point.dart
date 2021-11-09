import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/gas_point_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/gas_point/widgets/points_gas_point.dart';
import 'package:pgn_mobile/screens/gas_point/widgets/redeem_gas_point.dart';
import 'package:pgn_mobile/screens/gas_point/widgets/rewards_gas_point.dart';
import 'package:pgn_mobile/screens/gas_point/widgets/tandc_gas_point.dart';

class GasPoint extends StatefulWidget {
  @override
  _GasPointState createState() => _GasPointState();
}

class _GasPointState extends State<GasPoint> with TickerProviderStateMixin {
  TabController _tabController;
  int selectedIndex = 0;
  List<String> listMenus = [];
  final storageCache = new FlutterSecureStorage();
  void initState() {
    super.initState();
    getCred(context);
    _tabController = new TabController(vsync: this, length: 5, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

//ID MENU RTPK GAS Point 12
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            margin: EdgeInsets.only(left: 18, right: 18),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFF4F4F4), width: 2))),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Color(0xFF4578EF),
              labelStyle: TextStyle(),
              indicatorColor: Color(0xFFADADAD),
              unselectedLabelColor: Color(0xFFADADAD),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 3,
                  color: Color(0xFF4578EF),
                ),
                insets: EdgeInsets.only(
                  left: 0,
                  right: 25,
                ),
              ),
              labelPadding: EdgeInsets.only(left: 0, right: 25),
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                  // _tabController.index = index;
                });
              },
              tabs: <Widget>[
                Tab(
                    child: Align(
                        alignment: Alignment.centerLeft, child: Text('Card'))),
                Tab(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Rewards'))),
                Tab(
                    child: Align(
                        alignment: Alignment.centerLeft, child: Text('Point'))),
                Tab(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Redeem'))),
                Tab(
                    child: Align(
                        alignment: Alignment.centerLeft, child: Text('T&C'))),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(controller: _tabController, children: [
              buildCardGasPoint(context),
              RewardsGasPoint(),
              PointsGasPoint(),
              RedeemGasPoint(),
              TandCGasPoint()
            ]),
            selectedIndex == 0
                ? Positioned(
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
                        onPressed: () {
                          setState(() {
                            _tabController.index = 1;
                          });
                        },
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildCardGasPoint(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 20),
        FutureBuilder<VirtualCardGasPoint>(
          future: getVirtualCardGasPoint(context),
          builder: (context, snapshot) {
            // print('HASIL SNAP ${snapshot.data.message}');
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
            if (snapshot.data.code != '200') {
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
                    Container(
                      height: 210,
                    )
                  ],
                ),
              );
            }
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
          padding: EdgeInsets.only(left: 18, top: 30, bottom: 7),
          child: Text(
            'PGN Point History',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
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
                  itemCount: snapshot.data.dataGPHistory.length >= 5
                      ? 5
                      : snapshot.data.dataGPHistory.length,
                  itemBuilder: (context, i) {
                    DateTime dateFormated = DateTime.parse(
                        snapshot.data.dataGPHistory[i].dateHistory);

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
                                  child: Text(
                                      snapshot.data.dataGPHistory[i].desc ??
                                          '-')),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(snapshot.data.dataGPHistory[i].type,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: snapshot.data.dataGPHistory[i]
                                                      .type ==
                                                  'redeem'
                                              ? Color(0xFFFAC842)
                                              : Color(0xFF81C153))),
                                  SizedBox(height: 5),
                                  Text(
                                    '${snapshot.data.dataGPHistory[i].point} Point',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: snapshot.data.dataGPHistory[i]
                                                    .type ==
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
                ),
                Container(
                  height: 40.0,
                  margin: EdgeInsets.only(bottom: 100, left: 18, right: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    border: Border.all(color: Color(0xFF427CEF)),
                  ),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'Show All Poin History',
                      style: TextStyle(
                          color: Color(0xFF427CEF),
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // Navigat
                      _tabController.animateTo(2);
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

  getCred(BuildContext context) async {
    String listMenusString = await storageCache.read(key: 'list_menu') ?? "";

    setState(() {
      listMenus = listMenusString.split(',');
    });
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
  // if (responseGetVCGasPoint.statusCode == 200) {
  return VirtualCardGasPoint.fromJson(json.decode(responseGetVCGasPoint.body));
  // } else {
  //   throw Exception('Could not get any response');
  // }
}
