import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:expandable/expandable.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/models/cust_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:pgn_mobile/models/notification_model.dart';
import 'dart:convert';

class KontrakDetail extends StatefulWidget {
  KontrakDetail({this.data});
  final DataNotifList data;
  @override
  KontrakDetailState createState() => KontrakDetailState(data);
}

class KontrakDetailState extends State<KontrakDetail> {
  DataNotifList data;
  KontrakDetailState(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('title_bar_customer_contract_detail'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/new_backgound.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.only(left: 15.0, right: 15),
            child: Container(
              height: 60.0,
              width: 500,
              margin: EdgeInsets.only(bottom: 20.0, top: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 8.0, left: 15, right: 15),
                      child: Text(
                        data.nameCust,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            color: Color(0xff427CEF),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: Text(
                        data.id,
                        style: TextStyle(
                            color: Color(0xff427CEF),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 100),
              child: _buildContent(
                  context, getCustomerContract(context, data.id))),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, Future<GetContract> getContract) {
    return FutureBuilder<GetContract>(
        future: getContract,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          if (snapshot.data.message != null)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    snapshot.data.message,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.data.length + 1,
            itemBuilder: (context, i) {
              return i < snapshot.data.data.length
                  ? _buildRow(snapshot.data.data[i])
                  : SizedBox(
                      height: 10.0,
                    );
            },
          );
        });
  }
}

Widget _buildRow(DataCustContract dataCustContract) {
  return Card1(dataCustContract: dataCustContract);
}

class Card1 extends StatelessWidget {
  Card1({this.dataCustContract});

  final DataCustContract dataCustContract;
  String statusContract;
  Color status;

  @override
  Widget build(BuildContext context) {
    statusContract = dataCustContract.statusContract.display;
    if (statusContract == 'Inaktif' || statusContract == 'Inactive') {
      status = Colors.red;
    } else {
      status = Colors.green;
    }
    DateTime pGEndDate =
        DateTime.parse("${dataCustContract.endDate.value} 00:00:04");
    DateTime currentTime = DateTime.now();
    String endYear = DateFormat("yyyy").format(pGEndDate).toString();
    final startTime = DateTime(currentTime.year, currentTime.month, 1, 0, 0);
    final endTime =
        DateTime(currentTime.year, currentTime.month + 3, 0, 23, 59);

    if (dataCustContract.statusContract.value == '1' &&
        pGEndDate.isAfter(startTime) &&
        pGEndDate.isBefore(endTime)) {
      return ExpandableNotifier(
        child: ScrollOnExpand(
          scrollOnExpand: false,
          scrollOnCollapse: true,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      tapHeaderToExpand: true,
                      tapBodyToCollapse: true,
                      headerAlignment: ExpandablePanelHeaderAlignment.top,
                      collapsed: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_contract_number'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    dataCustContract.numbContract,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_minimum_volume'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    '${dataCustContract.minUsage.value.toString()} ${dataCustContract.minUsage.display}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_maximum_volume'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    '${dataCustContract.maxUsage.value.toString()} ${dataCustContract.maxUsage.display}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      expanded: Column(
                        children: <Widget>[
                          // for(var i in Iterable.generate(7))
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_contract_number'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    dataCustContract.numbContract,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_minimum_volume'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    '${dataCustContract.minUsage.value.toString()} ${dataCustContract.minUsage.display}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_maximum_volume'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    '${dataCustContract.maxUsage.value.toString()} ${dataCustContract.maxUsage.display}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_approve_date'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    dataCustContract.approvedDate.display,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_start_date'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    dataCustContract.startDate.display,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_end_date'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    dataCustContract.endDate.display,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_status'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0, top: 15),
                                  child: Text(
                                    dataCustContract.statusContract.display,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: status),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10, bottom: 18),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            crossFadePoint: 0,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

Future<GetContract> getCustomerContract(BuildContext context, String id) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString('access_token');
  // String lang = prefs.getString('lang');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseContractCust =
      await http.get('${UrlCons.mainProdUrl}customers/$id/contracts', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang
  });
  GetContract _getContract =
      GetContract.fromJson(json.decode(responseContractCust.body));

  return _getContract;
}
