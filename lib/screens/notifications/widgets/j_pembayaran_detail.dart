import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/notification_model.dart';
import 'package:expandable/expandable.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/models/cust_profile_model.dart';

class JamPembayaranDetail extends StatefulWidget {
  JamPembayaranDetail({this.data});
  final DataNotifList data;
  @override
  JamPemDetailState createState() => JamPemDetailState(data);
}

class JamPemDetailState extends State<JamPembayaranDetail> {
  DataNotifList data;
  JamPemDetailState(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('title_bar_customer_guarantee_detail'),
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
              margin: EdgeInsets.only(top: 120),
              child: _buildContent(
                  context, getCustomerGuarantees(context, data.id))),
        ],
      ),
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

  Widget _buildRow(DataCustGuarantees dataCustGuarantees) {
    return Card1(dataCustGuarantees: dataCustGuarantees);
  }
}

class Card1 extends StatelessWidget {
  final DataCustGuarantees dataCustGuarantees;
  Card1({this.dataCustGuarantees});

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
    DateTime pGEndDate =
        DateTime.parse("${dataCustGuarantees.gEndDate} 00:00:04");
    DateTime pGStartDate =
        DateTime.parse("${dataCustGuarantees.gStartDate} 00:00:04");
    DateTime currentTime = DateTime.now();
    final startTime = DateTime(currentTime.year, currentTime.month, 1, 0, 0);
    final endTime =
        DateTime(currentTime.year, currentTime.month + 3, 0, 23, 59);
    if (dataCustGuarantees.gStatus == true &&
        pGEndDate.isAfter(startTime) &&
        pGEndDate.isBefore(endTime))
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
                        // for(var i in Iterable.generate(3))
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                Translations.of(context)
                                    .text('row_guarantee_tv_guarantee_number'),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                  dataCustGuarantees.guratanteesNumb ?? "-",
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
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                  dataCustGuarantees.guaranteesPublisher ?? "-",
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
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                  dataCustGuarantees.gBalance ?? "-",
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
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                Translations.of(context)
                                    .text('row_guarantee_tv_guarantee_number'),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                  dataCustGuarantees.guratanteesNumb ?? "-",
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
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                  dataCustGuarantees.guaranteesPublisher ?? "-",
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
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                  dataCustGuarantees.gBalance ?? "-",
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
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                  dataCustGuarantees.guaranteesType ?? "-",
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
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                      .format(pGStartDate)
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
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                    .text('row_guarantee_tv_status'),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
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
                                  gStatus ?? "-",
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
      ));
    else
      return Container();
  }
}

Future<GetGuarantees> getCustomerGuarantees(
    BuildContext context, String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token');
  var responseGuaranteesCust = await http
      .get('${UrlCons.mainProdUrl}customers/$id/guarantees', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });
  GetGuarantees _getGuarantees =
      GetGuarantees.fromJson(json.decode(responseGuaranteesCust.body));

  return _getGuarantees;
}
