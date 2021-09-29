import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/cm_visit_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/url_cons.dart';

class CMVisitDetail extends StatefulWidget {
  CMVisitDetail({this.id});
  final String id;
  @override
  _CMVisitDetailState createState() => _CMVisitDetailState(id);
}

class _CMVisitDetailState extends State<CMVisitDetail> {
  final String id;
  _CMVisitDetailState(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('NOXUS Ideata Prima PT - Report',
            style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[_callCmVisitDetail(context, getDetail(context, id))],
      ),
    );
  }
}

Widget _callCmVisitDetail(
    BuildContext context, Future<CmVisitDetailModel> model) {
  return FutureBuilder(
      future: model,
      builder: (context, snapShot) {
        if (!snapShot.hasData) return LinearProgressIndicator();
        return _buildContent(context, snapShot.data);
      });
}

Widget _buildContent(BuildContext context, CmVisitDetailModel model) {
  DateTime date = DateTime.parse(model.data.reportDate);
  String ids = model.data.customerCmModel.id;
  return Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 12, left: 16, right: 16),
        decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(3)),
        child: Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Site/Business Visit',
                style: TextStyle(
                    color: const Color(0xFF5C727D),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat("d MMMM yyyy").format(date).toString(),
                style: TextStyle(
                    color: const Color(0xFF5C727D),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              child: Text(model.data.contactPersonModel.name,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF427CEF),
                      fontWeight: FontWeight.w600))),
          Container(
            margin: EdgeInsets.only(top: 4),
            alignment: Alignment.topLeft,
            child: Text('ID.$ids',
                style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF5C727D),
                    fontWeight: FontWeight.w600)),
          )
        ]),
      ),
      Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 12),
        alignment: Alignment.topLeft,
        child: Text(
          model.data.contactPersonModel.address,
          style: TextStyle(
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ),
      ),
      Container(
        margin: EdgeInsets.all(16),
        child: Divider(color: Colors.blueGrey),
      ),
      Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Contact Person',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF455055)),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    model.data.contactPersonModel.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF455055)),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    'Contact Person',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF455055)),
                  ),
                ),
                Container(
                  child: Text(
                    model.data.contactPersonModel.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF455055)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 12, left: 16, right: 16),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Email Address',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF455055)),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                model.data.contactPersonModel.email,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF455055)),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.all(16),
        child: Divider(color: Colors.blueGrey),
      ),
      Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Costumer Complaint Handling',
                style: TextStyle(
                    color: const Color(0xFF427CEF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              alignment: Alignment.topLeft,
              child: Text(
                model.data.activityDescription,
                style: TextStyle(
                    height: 1.5,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'CM Visit Reports',
                style: TextStyle(
                    color: const Color(0xFF427CEF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              alignment: Alignment.topLeft,
              child: Text(
                model.data.report,
                style: TextStyle(
                    height: 1.5,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 40),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 12),
                alignment: Alignment.topLeft,
                child: Text(
                  'Documentation',
                  style: TextStyle(
                      color: const Color(0xFF427CEF),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, int index) {
                    return _listPhotos(context);
                  },
                ),
              )
            ]),
      )
    ],
  );
}

Widget _listPhotos(BuildContext context) {
  return Container(
    width: 100,
    height: 100,
    margin: EdgeInsets.only(right: 20),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text('Test 1',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
  );
}

Future<CmVisitDetailModel> getDetail(BuildContext context, String id) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseCmVisitDetail =
      await http.get('${UrlCons.mainProdUrl}cm-visit/$id', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });
  return CmVisitDetailModel.fromJson(json.decode(responseCmVisitDetail.body));
}
