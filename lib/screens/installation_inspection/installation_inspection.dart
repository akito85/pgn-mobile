import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/installation_inspection_list.dart';
import 'package:pgn_mobile/models/installation_inspection_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/installation_inspection/installation_inspection_detail.dart';

class InstallationInspection extends StatefulWidget {
  @override
  _InstallationInspection createState() => _InstallationInspection();
}

class _InstallationInspection extends State<InstallationInspection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Installation Inspection',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[_buildContent(context, fetchData(context))],
      ),
    );
  }
}

Widget _buildContent(
    BuildContext context, Future<InstallationInspectionList> list) {
  return FutureBuilder<InstallationInspectionList>(
      future: list,
      builder: (context, snapShot) {
        if (!snapShot.hasData) return LinearProgressIndicator();
        return Container(
          child: ListView.builder(
              itemCount: snapShot.data.data.length + 1,
              itemBuilder: (context, int index) {
                return index < snapShot.data.data.length
                    ? _cardState(context, snapShot.data.data[index])
                    : SizedBox(height: 10);
              }),
        );
      });
}

Widget _cardState(BuildContext context, InstallationInspections model) {
  DateTime date = DateTime.parse(model.inspectionDate);
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InstallationInspectionDetail(id: model.id)));
    },
    child: Card(
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
                DateFormat("d MMMM yyyy").format(date).toString(),
                style: TextStyle(
                    color: Color(0xFF455055),
                    fontSize: 10,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                model.customer.name,
                style: TextStyle(
                    color: Color(0xFF427CEF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                model.customer.address,
                style: TextStyle(
                    color: Color(0xFF5C727D),
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8),
              Text(
                model.customer.areaName,
                style: TextStyle(
                    color: Color(0xFF5C727D),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )),
  );
}

Future<InstallationInspectionList> fetchData(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var installationInspectionResponse =
      await http.get('${UrlCons.mainDevUrl}inspection-installation', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang
  });
  return InstallationInspectionList.fromJson(
      json.decode(installationInspectionResponse.body));
}
