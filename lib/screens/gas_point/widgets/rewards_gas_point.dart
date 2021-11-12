import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pgn_mobile/models/gas_point_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/otp/otp_register.dart';

class RewardsGasPoint extends StatefulWidget {
  @override
  _RewardsGasPointState createState() => _RewardsGasPointState();
}

class _RewardsGasPointState extends State<RewardsGasPoint> {
  String pointGasPoint = '0';
  String messageAlert = '';
  bool selected = false;
  String idRewards, name, imgUrl;
  int pointNeeded, remainingPoint = 0;
  ScrollController _scrollController = ScrollController();
  List<DataGetRewards> returnDataRewards = [];
  bool _isLoading = false;
  String nextPage = '';
  @override
  void initState() {
    super.initState();
    this.getGasPointRewards(context);
    getVirtualCardGasPoint(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        this.getGasPointRewards(context);
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
        ListView(
          controller: _scrollController,
          children: [
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFFAC842)),
              margin: EdgeInsets.only(left: 18, right: 18),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 20, bottom: 16),
                    child: Image.asset(
                      'assets/icon_rewards.png',
                      height: 88,
                      width: 140,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Points Collected',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7C6400),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          pointGasPoint,
                          style: TextStyle(
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7C6400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18, top: 20, bottom: 7),
              child: Text(
                'Amazing Rewards Just for You!',
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
            FutureBuilder<GetRewardsModel>(
              future: getRewards(context),
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
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _isLoading
                      ? returnDataRewards.length + 1
                      : returnDataRewards.length,
                  itemBuilder: (context, i) {
                    if (returnDataRewards.length == i)
                      return Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: CircularProgressIndicator(),
                      ));
                    return InkWell(
                      onTap: () {
                        setState(() {
                          idRewards = returnDataRewards[i].id;
                          pointNeeded = returnDataRewards[i].cost;
                          name = returnDataRewards[i].nameRewards;
                          imgUrl = returnDataRewards[i].imgRedeem;
                          _isLoading = false;
                        });
                        if (pointGasPoint == '0') {
                          showToast('Gas Point 0');
                        } else if (int.parse(pointGasPoint) < pointNeeded) {
                          showToast('Not Enough Points !');
                        } else {
                          // if (remainingPoint <= 0) {
                          //   remainingPoint = 0;
                          // } else {
                          remainingPoint =
                              int.parse(pointGasPoint) - pointNeeded;
                          // }

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return redeemPointFormAlert(
                                    context,
                                    name,
                                    idRewards,
                                    pointGasPoint,
                                    pointNeeded,
                                    remainingPoint,
                                    imgUrl);
                              });
                        }
                      },
                      child: Card(
                        margin:
                            EdgeInsets.only(left: 18, right: 18, bottom: 11),
                        shape: idRewards == returnDataRewards[i].id
                            ? RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color(0xFF427CEF), width: 2.0),
                                borderRadius: BorderRadius.circular(10.0))
                            : RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 12, bottom: 12),
                              child: Image.network(
                                returnDataRewards[i].imgRedeem,
                                width: 52,
                                height: 56,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  returnDataRewards[i].nameRewards,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color:
                                          idRewards == returnDataRewards[i].id
                                              ? Color(0xFF427CEF)
                                              : Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${returnDataRewards[i].cost}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color:
                                            idRewards == returnDataRewards[i].id
                                                ? Color(0xFF427CEF)
                                                : Colors.black),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'POINTS',
                                    style: TextStyle(fontSize: 9),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
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
      ],
    );
  }

  Widget redeemPointFormAlert(BuildContext context, String name, String id,
      String currentPoint, int pointNedeed, int remainingPoint, String imgUrl) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: 325,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Point Redeem Confirmation',
                style: TextStyle(
                    color: Color(0xFF427CEF),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, top: 20, bottom: 12),
                  child: Image.network(
                    imgUrl,
                    width: 64,
                    height: 64,
                  ),
                ),
                Expanded(child: Text(name))
              ],
            ),
            Divider(
              color: Color(0xFFF4F4F4),
              thickness: 2,
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Current Point',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    currentPoint,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Point Needed',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    pointNedeed.toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Color(0xFFF4F4F4),
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Remaining Point',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    remainingPoint.toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 40.0,
                  width: 84,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xFFD3D3D3),
                  ),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xFF427CEF),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        postRedeem(context, id);
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Future.delayed(Duration(seconds: 2), () {
                              //   Navigator.of(context).pop(true);
                              // });
                              return redeemSuccessAlert(context);
                            },
                          );
                        });

                        // postRedeem(context, id);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void postRedeem(BuildContext context, String id) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    print('AKSES ID : $id');
    var responsePostRedeemGasPoint =
        await http.post('${UrlCons.mainDevUrl}users/rewards/$id', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    });

    print('HASILNYA Post Redeem: ${responsePostRedeemGasPoint.body}');
    // if (responsePostRedeemGasPoint.statusCode == 200) {
    PostRedeemModel postRedeemGasPoint =
        PostRedeemModel.fromJson(json.decode(responsePostRedeemGasPoint.body));
    if (postRedeemGasPoint.message == null) {
      print('MASUK SINI ${postRedeemGasPoint.dataPostRedeem.message}');
      setState(() {
        idRewards = '';
        pointGasPoint = remainingPoint.toString();
        messageAlert = postRedeemGasPoint.dataPostRedeem.message;
      });
    } else {
      setState(() {
        idRewards = '';
        pointGasPoint = remainingPoint.toString();
        messageAlert = postRedeemGasPoint.message;
      });
    }
    // } else {
    //   throw Exception('Could not get any response');
    // }
  }

  Widget redeemSuccessAlert(context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                FaIcon(
                  Icons.check_circle_outline,
                  size: 70,
                  color: Color(0xFF81C153),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 5),
                        child: Text(
                          'Thank You! ',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF81C153),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(messageAlert),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF427CEF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            )
          ],
        ),
      ),
    );
  }

  void getVirtualCardGasPoint(BuildContext context) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');

    var responseGetVCGasPoint =
        await http.get('${UrlCons.mainDevUrl}virtual_card', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    print('HASILNYA : ${responseGetVCGasPoint.body}');
    if (responseGetVCGasPoint.statusCode == 200) {
      VirtualCardGasPoint virtualCardGasPoint =
          VirtualCardGasPoint.fromJson(json.decode(responseGetVCGasPoint.body));
      setState(() {
        pointGasPoint = virtualCardGasPoint.dataVCGasPoint.pointReward;
      });
    } else {
      throw Exception('Could not get any response');
    }
  }

  void getGasPointRewards(BuildContext context) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    print('AKSES TOKEN : $accessToken');
    var responseGetRewardsGasPoint = await http
        .get('${UrlCons.mainDevUrl}rewards?cursor=$nextPage', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    });

    print('HASILNYA Get Rewards: ${responseGetRewardsGasPoint.body}');
    // if (responseGetRewardsGasPoint.statusCode == 200) {
    GetRewardsModel returnGetRewardsModel =
        GetRewardsModel.fromJson(json.decode(responseGetRewardsGasPoint.body));
    if (returnGetRewardsModel.message == null &&
        returnGetRewardsModel.dataGetRewards.length > 0) {
      setState(() {
        nextPage = returnGetRewardsModel.gasPointPaging.nextPage;
        returnDataRewards.addAll(returnGetRewardsModel.dataGetRewards);
        _isLoading = false;
      });
    }
    // } else {
    //   throw Exception('Could not get any response');
    // }
  }
}

Future<GetRewardsModel> getRewards(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  print('AKSES TOKEN : $accessToken');
  var responseGetRewardsGasPoint =
      await http.get('${UrlCons.mainDevUrl}rewards', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });

  print('HASILNYA Get Rewards: ${responseGetRewardsGasPoint.body}');
  // if (responseGetRewardsGasPoint.statusCode == 200) {
  return GetRewardsModel.fromJson(json.decode(responseGetRewardsGasPoint.body));
  // } else {
  //   throw Exception('Could not get any response');
  // }
}
