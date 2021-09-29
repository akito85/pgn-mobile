import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/cm_visit_model.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/cm_visit/cm_visit_detail.dart';
import 'package:pgn_mobile/screens/cm_visit/cm_visit_form.dart';

class CMVisit extends StatefulWidget {
  @override
  _CMVisitState createState() => _CMVisitState();
}

class _CMVisitState extends State<CMVisit> with TickerProviderStateMixin {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: _buildContent(context, getCmVisit(context)),
          ),
          Positioned(
              bottom: 10,
              left: 18,
              right: 18,
              child: Container(
                color: Colors.white,
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF427CEF)),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CMVisitForm()));
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text('Add New Visit Report',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal))),
                ),
              ))
        ],
      ),
    );
  }
}

Widget _buildContent(BuildContext context, Future<CMVisitList> list) {
  return FutureBuilder<CMVisitList>(
      future: list,
      builder: (context, snapsnapshot) {
        if (!snapsnapshot.hasData) return LinearProgressIndicator();
        return Container(
          child: ListView.builder(
            itemCount: snapsnapshot.data.data.length + 1,
            itemBuilder: (context, i) {
              return i < snapsnapshot.data.data.length
                  ? _cardState(context, snapsnapshot.data.data[i])
                  : SizedBox(height: 10.0);
            },
          ),
        );
      });
}

Widget _cardState(BuildContext context, CMVisitModel model) {
  return Card(
      color: Colors.white,
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(top: 6, left: 18, right: 18, bottom: 8),
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              model.reportDate,
              style: TextStyle(
                  color: Color(0xFF455055),
                  fontSize: 10,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 10),
            Text(
              model.activityType,
              style: TextStyle(
                  color: Color(0xFF427CEF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              model.contactPersonModel.address,
              style: TextStyle(
                  color: Color(0xFF5C727D),
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ));
}

Future<CMVisitList> getCmVisit(BuildContext context) async {
  final sotarageCache = FlutterSecureStorage();
  String accessToken = await sotarageCache.read(key: 'access_token');
  String lang = await sotarageCache.read(key: 'lang');
  var cmVisitResponse =
      await http.get('${UrlCons.mainDevUrl}cm-visit', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang
  });
  return CMVisitList.fromJson(json.decode(cmVisitResponse.body));
}
