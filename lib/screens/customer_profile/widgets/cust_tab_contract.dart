import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/cust_profile_model.dart';
import 'package:expandable/expandable.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ContractDetailSales extends StatefulWidget {
  ContractDetailSales({this.data, this.idCust});
  final Customer data;
  final String idCust;
  @override
  ContractDetailState createState() => ContractDetailState(data, idCust);
}

class ContractDetailState extends State<ContractDetailSales> {
  Customer data;
  String idCust;
  ContractDetailState(this.data, this.idCust);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          margin: EdgeInsets.only(left: 15, right: 15),
          elevation: 5,
          child: Container(
            height: 55.0,
            width: 500,
            margin: EdgeInsets.only(bottom: 10.0, top: 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Text(
                      data.data.name,
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      idCust ?? "-",
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 90),
          child: _buildContent(
            context,
            getCustomerContract(context),
          ),
        ),
      ],
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
          itemCount: snapshot.data.data.length + 1,
          itemBuilder: (context, i) {
            snapshot.data.data.sort(
                (a, b) => b.approvedDate.value.compareTo(a.approvedDate.value));
            return i < snapshot.data.data.length
                ? _buildRow(snapshot.data.data[i])
                : SizedBox(
                    height: 10.0,
                  );
          },
        );
      },
    );
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
    if (dataCustContract.statusContract.value == '1') {
      return ExpandableNotifier(
        child: ScrollOnExpand(
          scrollOnExpand: false,
          scrollOnCollapse: true,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              shape: Border(
                left: BorderSide(color: status, width: 2.0),
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
                            children: <Widget>[
                              Container(
                                width: 130,
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_contract_tv_contract_number'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15.0),
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
                                margin: EdgeInsets.only(left: 15.0, top: 15),
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
                                    '${dataCustContract.minUsage.display}',
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
                                      .text('row_contract_tv_maximum_volume'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15.0, top: 15),
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
                                    '${dataCustContract.maxUsage.display}',
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
                          Row(
                            children: <Widget>[
                              Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 20.0),
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
                                margin: EdgeInsets.only(left: 15.0),
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
                                margin: EdgeInsets.only(left: 15.0, top: 15),
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
                                    '${dataCustContract.minUsage.display}',
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
                                      .text('row_contract_tv_maximum_volume'),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15.0, top: 15),
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
                                    '${dataCustContract.maxUsage.display}',
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
                                margin: EdgeInsets.only(left: 15.0, top: 15),
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
                                margin: EdgeInsets.only(left: 15.0, top: 15),
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
                                margin: EdgeInsets.only(left: 15.0, top: 15),
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
                                      color: status),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15.0, top: 15),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: status),
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
                          padding: EdgeInsets.only(right: 2, bottom: 10),
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

Future<GetContract> getCustomerContract(BuildContext context) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString('access_token');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  var responseContractCust = await http
      .get('${UrlCons.mainProdUrl}customers/me/contracts', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });
  GetContract _getContract =
      GetContract.fromJson(json.decode(responseContractCust.body));

  return _getContract;
}
