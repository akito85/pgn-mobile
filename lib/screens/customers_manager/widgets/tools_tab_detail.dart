import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/cust_list_model.dart';
import 'package:expandable/expandable.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/models/cust_profile_model.dart';

class ToolsDetail extends StatefulWidget {
  ToolsDetail({this.data});
  final DataListCust data;
  @override
  ToolsDetailState createState() => ToolsDetailState(data);
}

class ToolsDetailState extends State<ToolsDetail> {
  DataListCust data;
  ToolsDetailState(this.data);
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
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                        child: Text(
                      data.name,
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    )),
                    SizedBox(width: 15),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Text(
                      data.id ?? "-",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
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
                            .text('f_customer_detail_equipment_tv_empty_desc'),
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
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          elevation: 5,
          child: Container(
            height: 50.0,
            width: 500,
            margin: EdgeInsets.only(bottom: 20.0, top: 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                        child: Text(
                      data.name,
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    )),
                    SizedBox(width: 15),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Text(
                      data.id ?? "-",
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
            margin: EdgeInsets.only(top: 100),
            child: _buildContent(
                context, getCustomerGuarantees(context, data.id))),
      ],
    );
  }

  Widget _buildContent(BuildContext context, Future<GetEquipCust> getEquip) {
    return FutureBuilder<GetEquipCust>(
      future: getEquip,
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
                  "Data Belum Tersedia",
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

  Widget _buildRow(DataCustEquip dataCustGuarantees) {
    return Card1(dataCustGuarantees: dataCustGuarantees);
  }
}

class Card1 extends StatelessWidget {
  Card1({this.dataCustGuarantees});

  final DataCustEquip dataCustGuarantees;

  @override
  Widget build(BuildContext context) {
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
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              width: 140,
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                Translations.of(context)
                                    .text('row_equipment_tv_name'),
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
                                  dataCustGuarantees.title ?? "-",
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
                                    .text('row_equipment_tv_minimum_capacity'),
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
                                  '${dataCustGuarantees.minCap} ${Translations.of(context).text('row_equipment_tv_capacity_cubicperhour')}',
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
                                    .text('row_equipment_tv_maximum_capacity'),
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
                                  '${dataCustGuarantees.maxCap} ${Translations.of(context).text('row_equipment_tv_capacity_cubicperhour')}',
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
                                Translations.of(context)
                                    .text('row_equipment_tv_name'),
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
                                  dataCustGuarantees.title ?? "-",
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
                                    .text('row_equipment_tv_minimum_capacity'),
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
                                  '${dataCustGuarantees.minCap} ${Translations.of(context).text('row_equipment_tv_capacity_cubicperhour')}',
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
                                    .text('row_equipment_tv_maximum_capacity'),
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
                                  '${dataCustGuarantees.maxCap} ${Translations.of(context).text('row_equipment_tv_capacity_cubicperhour')}',
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
                                    .text('row_equipment_tv_operation_hour'),
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
                                  '${dataCustGuarantees.numbHour ?? 0} ${Translations.of(context).text('row_equipment_tv_operation_hourperday')}',
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
                                    .text('row_equipment_tv_operation_day'),
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
                                  '${dataCustGuarantees.numbDay ?? 0} ${Translations.of(context).text('row_equipment_tv_operation_dayperweek')}',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(right: 2, bottom: 18),
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

Future<GetEquipCust> getCustomerGuarantees(
    BuildContext context, String id) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  var responseGuaranteesCust = await http
      .get('${UrlCons.mainProdUrl}customers/$id/equipments', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });
  GetEquipCust _getGuarantees =
      GetEquipCust.fromJson(json.decode(responseGuaranteesCust.body));
  print("GET Equip ${responseGuaranteesCust.body}");
  return _getGuarantees;
}
