import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/models/top_usage_detail_model.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/usage_detail_detail.dart';

class PeningkatanTab extends StatefulWidget {
  @override
  PeningkatanTabState createState() => PeningkatanTabState();
}

class PeningkatanTabState extends State<PeningkatanTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildContent(context, fetchPost(context)),
      ],
    ));
  }

  Widget _buildContent(
      BuildContext context, Future<TopUsageDetail> getTopUsageDetail) {
    return FutureBuilder<TopUsageDetail>(
        future: getTopUsageDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          if (snapshot.data.message != null)
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
                    snapshot.data.message,
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
                color: Colors.white,
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

  Widget _buildRow(DataTopUsage data) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Card1(data),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UsageTabDetail(
                        title: data.customer.name, idCust: data.customer.id)));
          },
        )
      ],
    );
  }
}

class Card1 extends StatelessWidget {
  final DataTopUsage data;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
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
                        'CM - ${data.customer.aeId} | ${data.customer.id}',
                        style: TextStyle(fontSize: 11.0),
                      ),
                    ],
                  )),
              Column(
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
                              .text('row_gain_usage_tv_prev_volume_label'),
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
                            data.usage.usageBefore.display ?? '-',
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
                              .text('row_gain_usage_tv_after_volume_label'),
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
                            data.usage.usageAfter.display ?? '-',
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
                              .text('row_gain_usage_tv_difference_gain_label'),
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
                            data.usage.usageDiff.display ?? '-',
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
                        margin:
                            EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                        child: Text(
                          Translations.of(context)
                              .text('row_gain_usage_tv_percentage_label'),
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 35.0, top: 15, bottom: 15),
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
                          margin:
                              EdgeInsets.only(left: 5.0, top: 15, bottom: 15),
                          child: Text(
                            '${data.usage.percentageDiff} %' ?? '-',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

Future<TopUsageDetail> fetchPost(BuildContext context) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString('access_token');
  // String lang = prefs.getString('lang');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  print('ACCESS TOKEN 2: $accessToken');
  var responseTopUsage =
      await http.get('${UrlCons.mainProdUrl}report/top-gain-usage', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });

  return TopUsageDetail.fromJson(json.decode(responseTopUsage.body));
}
