import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pgn_mobile/models/url_cons.dart';

import 'package:pgn_mobile/models/spbg_model.dart';
import 'package:pgn_mobile/screens/payment_plain/widgets/payment_plan_detail.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class PaymentPlain extends StatefulWidget {
  @override
  PaymentPlainState createState() => PaymentPlainState();
}

class PaymentPlainState extends State<PaymentPlain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          Translations.of(context).text('payment_plan'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildContent(context, fetchPost(context)),
        ],
      )),
    );
  }

  Widget _buildContent(BuildContext context, Future<GetSpbg> getDetailUsage) {
    return FutureBuilder<GetSpbg>(
        future: getDetailUsage,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.data.length + 1,
                itemBuilder: (context, i) {
                  return i < snapshot.data.data.length
                      ? _buildRow(snapshot.data.data[i])
                      : SizedBox(
                          height: 10.0,
                        );
                },
              ),
            ],
          );
        });
  }

  Widget _buildRow(DataSpbg data) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Card1(data),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PaymentPlanDetail(paymentPlanID: data.id)));
          },
        )
      ],
    );
  }
}

class Card1 extends StatelessWidget {
  final DataSpbg data;
  Card1(this.data);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      scrollOnExpand: false,
      scrollOnCollapse: true,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          margin: EdgeInsets.only(left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  tapHeaderToExpand: true,
                  tapBodyToCollapse: false,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  header: Padding(
                      padding: EdgeInsets.only(top: 11, right: 14, left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.calendar_today,
                              color: Color(0xFF5C727D),
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              data.id ?? '-',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          )
                        ],
                      )),
                  collapsed: Column(
                    children: <Widget>[
                      Divider(
                        color: Colors.black,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 130,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context)
                                  .text('row_invoice_paymentplan_invoiceid'),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35.0, top: 15),
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
                              child: Text(
                                data.title ?? '-',
                                style: TextStyle(
                                    fontSize: 13.0,
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
                              Translations.of(context).text(
                                  'row_invoice_paymentplan_confirmationid'),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35.0, top: 15),
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
                              child: Text(
                                data.title ?? '-',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 11),
                    ],
                  ),
                  expanded: Column(
                    children: <Widget>[
                      Divider(
                        color: Colors.black,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 130,
                            margin: EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              Translations.of(context)
                                  .text('row_invoice_paymentplan_invoiceid'),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35.0, top: 15),
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
                              child: Text(
                                data.title ?? '-',
                                style: TextStyle(
                                    fontSize: 13.0,
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
                              Translations.of(context).text(
                                  'row_invoice_paymentplan_confirmationid'),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35.0, top: 15),
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
                              child: Text(
                                data.title ?? '-',
                                style: TextStyle(
                                    fontSize: 13.0,
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
                              Translations.of(context).text(
                                  'f_invoice_paymentplan_detail_tv_periodepemakaiangas'),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35.0, top: 15),
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
                              child: Text(
                                data.title ?? '-',
                                style: TextStyle(
                                    fontSize: 13.0,
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
                              Translations.of(context).text(
                                  'f_invoice_paymentplan_detail_tv_totaltagihan'),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35.0, top: 15),
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
                              child: Text(
                                data.title ?? '-',
                                style: TextStyle(
                                    fontSize: 13.0,
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
                                  .text('ff_payment_amount'),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35.0, top: 15),
                            child: Text(
                              ':',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0, top: 15),
                              child: Text(
                                data.title ?? '-',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 11)
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 10),
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
  }
}

Future<GetSpbg> fetchPost(BuildContext context) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString('access_token');
  // String tokenType = prefs.getString('token_type');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  // String tokenType = await storageCache.read(key: 'tokenType');
  var responseGetSpbg = await http.get(UrlCons.getSpbgArea, headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });

  return GetSpbg.fromJson(json.decode(responseGetSpbg.body));
}
