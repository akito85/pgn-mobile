import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pgn_mobile/models/detail_usage_model.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/usage_detail_detail.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/usage_detail.dart';

class FirstTab extends StatefulWidget {
  @override
  FirstTabState createState() => FirstTabState();
}

class FirstTabState extends State<FirstTab> {
  ScrollController _scrollController = new ScrollController();
  TextEditingController _searchQuery = TextEditingController();
  List<DataUsageDetail> returnGetUsageDetails = [];
  FocusNode _focusNode = FocusNode();
  var items = List<DataUsageDetail>();
  final listData = List<DataUsageDetail>();
  String messageErrorData = "";
  Icon actionIcon = new Icon(Icons.search, color: Colors.white);
  Widget appBarTitle = new Text(
    "Usage Detail",
    style: TextStyle(color: Colors.white),
  );
  bool isLoading = false;
  String nextPage = "";

  @override
  void initState() {
    this.fetchPostNextPage(context, "");
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.fetchPostNextPage(context, "");
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final _usgDetail = Provider.of<UsgDetail>(context);
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 45,
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  child: TextFormField(
                    focusNode: _focusNode,
                    keyboardType: TextInputType.text,
                    controller: _searchQuery,
                    decoration: InputDecoration(
                      labelText: 'Keyword',
                      labelStyle: TextStyle(
                          color: Color(0xff427CEF),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Color(0xFF427CEF),
                        ),
                        onPressed: () {
                          // _focusNode.requestFocus();
                          if (_searchQuery.text.isNotEmpty) {
                            print('masuk kali 1');
                            return _buildContent(
                                context, fetchPost(context, _searchQuery.text));
                          } else {
                            print('masuk kali 2');
                            return _buildContent(
                                context, fetchPost(context, ""));
                          }
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        _buildContent(context, fetchPost(context, "")),
      ],
    );
  }

  // Widget _buildChild(String _searchQuery) {
  //   // if (_searchQuery.isNotEmpty) {
  //   //   print('masuk kali 1');
  //   //   return _buildContent(context, fetchPost(context, _searchQuery));
  //   // } else {
  //   //   print('masuk kali 2');
  //   //   return _buildContent(context, fetchPost(context, ""));
  //   // }
  //   return _buildContent(context, fetchPost(context, ""));
  // }

  Widget _buildContent(
      BuildContext context, Future<UsageDetails> getDetailUsage) {
    return FutureBuilder<UsageDetails>(
      future: getDetailUsage,
      builder: (context, snapshot) {
        print('message $messageErrorData');
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (messageErrorData != "")
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  messageErrorData ?? "",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 300,
              margin:
                  EdgeInsets.only(bottom: 15.0, left: 18, right: 10, top: 20),
              child: Text(
                '${Translations.of(context).text("gas_usage_date_unit")}, ${snapshot.data.meta.startDate.displayStart} - ${snapshot.data.meta.endDate.displayEnd}',
                style: TextStyle(
                    color: Color(0xFF5C727D),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: returnGetUsageDetails.length + 1,
              itemBuilder: (context, i) {
                return i < returnGetUsageDetails.length
                    ? _buildRow(returnGetUsageDetails[i])
                    : SizedBox();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow(DataUsageDetail data) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Card1(data),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UsageTabDetail(
                        title: data.customer.name,
                        idCust: data.customer.custId)));
          },
        )
      ],
    );
  }

  Future<UsageDetails> fetchPost(BuildContext context, String keywoard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    String lang = prefs.getString('lang');

    var responseGetUsageDetail = await http.get(
        'https://api-mobile.pgn.co.id/v2/report/gas-usage-list?q=$keywoard',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang,
        });

    UsageDetails returnGetUsageDetail =
        UsageDetails.fromJson(json.decode(responseGetUsageDetail.body));
    print('isinya1 ${returnGetUsageDetail.message}');
    print('masuk kah');
    if (nextPage == "") {
      print('masuk kah 1 ');
      setState(() {
        returnGetUsageDetails.clear();
        returnGetUsageDetails.addAll(returnGetUsageDetail.data);
        nextPage = returnGetUsageDetail.paging.next;
      });
    } else if (returnGetUsageDetail.data.length == 0 &&
        returnGetUsageDetail.message != null) {
      print('masuk kah 3 ');
      setState(() {
        messageErrorData = returnGetUsageDetail.message;
        returnGetUsageDetails.clear();
      });
    } else if (nextPage != "" && keywoard != "") {
      if (returnGetUsageDetail.data != null) {
        print('masuk kah 2 ');
        setState(() {
          // messageErrorData = returnGetUsageDetail.message;
          returnGetUsageDetails.clear();
          returnGetUsageDetails.addAll(returnGetUsageDetail.data);
        });
      }
    }

    return UsageDetails.fromJson(json.decode(responseGetUsageDetail.body));
  }

  Future<UsageDetails> fetchPostNextPage(
      BuildContext context, String keywoard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    String lang = prefs.getString('lang');

    var responseGetUsageDetail = await http.get(
        '${UrlCons.mainProdUrl}report/gas-usage-list?cursor=$nextPage',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang,
        });

    // if (responseGetUsageDetail.statusCode == 200) {

    UsageDetails returnGetUsageDetail =
        UsageDetails.fromJson(json.decode(responseGetUsageDetail.body));
    print('isinya ${returnGetUsageDetail.message}');
    if (nextPage != returnGetUsageDetail.paging.next) {
      setState(() {
        nextPage = returnGetUsageDetail.paging.next;
      });
    }

    returnGetUsageDetails.addAll(returnGetUsageDetail.data);

    return UsageDetails.fromJson(json.decode(responseGetUsageDetail.body));
  }
}

class Card1 extends StatelessWidget {
  final DataUsageDetail data;
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.customer.name ?? '-',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'CM - ${data.customer.aeId} | ${data.customer.custId}',
                              style: TextStyle(fontSize: 11.0),
                            ),
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
                                Translations.of(context).text(
                                    'f_customer_gas_usage_detail_tv_volume_label'),
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
                                  data.gasUsage.usage.display ?? '-',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 130,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                Translations.of(context).text(
                                    'row_all_customer_gas_usage_tv_estimated_volume_label'),
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
                                  data.gasUsage.estimationUsage.display ?? '-',
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
                                Translations.of(context).text(
                                    'f_customer_gas_usage_detail_tv_volume_label'),
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
                                  data.gasUsage.usage.display ?? '-',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 130,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                Translations.of(context).text(
                                    'row_all_customer_gas_usage_tv_estimated_volume_label'),
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
                                  data.gasUsage.estimationUsage.display ?? '-',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 130,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                Translations.of(context).text(
                                    'row_all_customer_gas_usage_tv_minimum_volume_label'),
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
                                  data.gasUsage.minUsage.display ?? '-',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 130,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                Translations.of(context).text(
                                    'row_all_customer_gas_usage_tv_maximum_volume_label'),
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
                                  data.gasUsage.maxUsage.display ?? '-',
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
                                'Status',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.orange),
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
                                  data.gasUsage.status.display ?? '-',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.orange),
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
      ),
    );
  }
}
