import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/cust_profile_model.dart';
import 'package:expandable/expandable.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PaymentDetailSales extends StatefulWidget {
  PaymentDetailSales({this.data, this.idCust});
  final Customer data;
  final String idCust;
  @override
  PaymentDetailState createState() => PaymentDetailState(data, idCust);
}

class PaymentDetailState extends State<PaymentDetailSales> {
  Customer data;
  String idCust;
  PaymentDetailState(this.data, this.idCust);
  @override
  Widget build(BuildContext context) {
    if (data == null)
      return ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin:
                              EdgeInsets.only(top: 10.0, left: 15, right: 15),
                          child: Text(
                            data.data.name ?? '-',
                            style: TextStyle(
                                color: Colors.blue[300],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: 10.0, left: 15, right: 15, bottom: 10),
                    child: Text(
                      idCust ?? '-',
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset('assets/negative_jaminan.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    children: <Widget>[
                      Text(
                        Translations.of(context).text('error_sorry'),
                        style: TextStyle(fontSize: 30.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        Translations.of(context)
                            .text('f_customer_detail_guarantee_tv_empty_desc'),
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    return Stack(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          margin: EdgeInsets.only(left: 15, right: 15),
          elevation: 5,
          child: Container(
            margin: EdgeInsets.only(bottom: 20.0, top: 10),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 5.0, left: 15, right: 15, bottom: 5),
                          child: Text(
                            data.data.name,
                            style: TextStyle(
                                color: Colors.blue[300],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      data.data.custId ?? "-",
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 110),
            child: _buildContent(context, getCustomerGuarantees(context))),
      ],
    );
  }

  Widget _buildContent(
      BuildContext context, Future<GetGuarantees> getGuarantees) {
    return FutureBuilder<GetGuarantees>(
      future: getGuarantees,
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
      },
    );
  }

  Widget _buildRow(DataCustGuarantees dataCustGuarantees) {
    return Card1(dataCustGuarantees: dataCustGuarantees);
  }
}

class Card1 extends StatelessWidget {
  Card1({this.dataCustGuarantees});

  final DataCustGuarantees dataCustGuarantees;
  bool statusGuarantees;
  String gStatus;
  Color status;

  @override
  Widget build(BuildContext context) {
    statusGuarantees = dataCustGuarantees.gStatus;
    if (statusGuarantees == null) {
      status = Colors.red;
      gStatus = 'Inactive';
    } else if (statusGuarantees = false) {
      status = Colors.red;
      gStatus = 'Inactive';
    } else if (statusGuarantees = true) {
      status = Colors.green;
      gStatus = 'Active';
    }
    print('COLORS : $status');
    DateTime pGEndDate =
        DateTime.parse("${dataCustGuarantees.gStartDate} 00:00:04");
    DateTime pGEffectiveDate =
        DateTime.parse("${dataCustGuarantees.gEndDate} 00:00:04");
    if (dataCustGuarantees.gStatus == true) {
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context).text(
                                      'row_guarantee_tv_guarantee_number'),
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
                                    dataCustGuarantees.guratanteesNumb,
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
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_guarantee_tv_publisher'),
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
                                    dataCustGuarantees.guaranteesPublisher,
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
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_guarantee_tv_balance'),
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
                                    "${dataCustGuarantees.gCurrency} ${dataCustGuarantees.gBalance}",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context).text(
                                      'row_guarantee_tv_guarantee_number'),
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
                                    dataCustGuarantees.guratanteesNumb,
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
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_guarantee_tv_publisher'),
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
                                    dataCustGuarantees.guaranteesPublisher,
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
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_guarantee_tv_balance'),
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
                                    "${dataCustGuarantees.gCurrency} ${dataCustGuarantees.gBalance}",
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
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_guarantee_tv_types'),
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
                                    dataCustGuarantees.guaranteesType,
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
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_guarantee_tv_start_date'),
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
                                    DateFormat("d MMM yyyy")
                                        .format(pGEndDate)
                                        .toString(),
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
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_guarantee_tv_end_date'),
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
                                    DateFormat("d MMM yyyy")
                                        .format(pGEffectiveDate)
                                        .toString(),
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
                                width: 140,
                                margin: EdgeInsets.only(left: 20.0, top: 15),
                                child: Text(
                                  Translations.of(context)
                                      .text('row_guarantee_tv_status'),
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
                                    gStatus,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: status),
                                  ),
                                ),
                              )
                            ],
                          ),
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

Future<GetGuarantees> getCustomerGuarantees(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  var responseGuaranteesCust = await http
      .get('${UrlCons.mainProdUrl}customers/me/guarantees', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });
  GetGuarantees _getGuarantees =
      GetGuarantees.fromJson(json.decode(responseGuaranteesCust.body));
  return _getGuarantees;
}
