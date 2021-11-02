import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/installation_inspection_model.dart';
import 'package:pgn_mobile/models/installation_inspection_response.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/url_cons.dart';

class InstallationInspectionDetail extends StatefulWidget {
  InstallationInspectionDetail({this.id});
  final String id;
  @override
  _InstallationInspectionDetailState createState() =>
      _InstallationInspectionDetailState(id);
}

class _InstallationInspectionDetailState
    extends State<InstallationInspectionDetail> {
  final String id;
  _InstallationInspectionDetailState(this.id);
  bool visibleCircular = true;
  bool visibleContent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Installation Inspection',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _fetchData(context, fetchInstallationDetail(context, id))
                  ],
                ))));
  }

  Widget _fetchData(
      BuildContext context, Future<InstallationInspectionResponse> model) {
    return FutureBuilder(
        future: model,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildContent(context, snapshot.data);
        });
  }

  Widget _buildContent(
      BuildContext context, InstallationInspectionResponse model) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(model.data.customer.areaName,
                      style: TextStyle(
                          color: const Color(0xFF5C727D),
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  Text(model.data.customer.id,
                      style: TextStyle(
                          color: const Color(0xFF5C727D),
                          fontSize: 12,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(model.data.customer.name,
                style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFF427CEF),
                    fontWeight: FontWeight.w600)),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            alignment: Alignment.topLeft,
            child: Text(model.data.customer.address,
                style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF5C727D),
                    fontWeight: FontWeight.normal)),
          ),
          _buildDivider(context, 16.0),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Inspection Summary',
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
                    model.data.summary,
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
          _buildDivider(context, 16.0),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'General Visual Inspection',
              style: TextStyle(
                  color: const Color(0xFF427CEF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: model.data.inspection.length + 1,
              itemBuilder: (context, i) {
                return i < model.data.inspection.length
                    ? _buildInspectionList(context, model.data.inspection[i])
                    : SizedBox(height: 10);
              }),
          _buildDivider(context, 0.0),
          SizedBox(height: 20),
          _buildBottomBoxContainer(
              context,
              'assets/ic_list.png',
              'Inspected by:',
              model.data.inspectionBy,
              'Inspector:',
              model.data.inspectionBy,
              'Date:',
              model.data.inspectionDate),
          SizedBox(height: 8),
          _buildBottomBoxContainer(
              context,
              'assets/ic_checkmark.png',
              'Acknowledged by:',
              model.data.acknowledgeBy ?? '-',
              'Engineer:',
              model.data.acknowledgeBy ?? '-',
              'Date:',
              model.data.acknowledgeDate),
          SizedBox(height: 20),
          Visibility(
              visible: !model.data.remark ? true : false,
              child:
                  _buildBottomBoxOutlined(context, 'Inspection Remark: FAILED'))
        ],
      ),
    );
  }
}

Widget _buildDescription(BuildContext context, String desc) {
  if (desc != "") {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(desc,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              height: 2,
              fontWeight: FontWeight.normal)),
    );
  } else {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text('No issues recorded',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: const Color(0xFFADADAD),
              fontSize: 14,
              fontWeight: FontWeight.normal)),
    );
  }
}

Widget _buildDivider(BuildContext context, double margin) {
  return Container(
    margin: EdgeInsets.only(top: margin),
    child: Divider(color: const Color(0xFFF4F4F4)),
  );
}

Widget _buildBottomBoxContainer(BuildContext context, String icon, String title,
    String descTitle, String type, String name, String titleDate, String date) {
  return Container(
    decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(2)),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                child:
                    ImageIcon(AssetImage(icon), color: Colors.black, size: 40),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  SizedBox(height: 4),
                  Text(descTitle,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14))
                ],
              )
            ],
          ),
          SizedBox(height: 12),
          Text(type + "        " + name,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14)),
          SizedBox(height: 4),
          type == "Inspector:"
              ? Text(titleDate + "                " + date,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14))
              : Text(titleDate + "               " + date,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14))
        ],
      ),
    ),
  );
}

Widget _buildBottomBoxOutlined(BuildContext context, String title) {
  return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 1, color: const Color(0xFFFF0000)),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xFFFF0000),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )));
}

Widget _buildInspectionList(BuildContext context, InspectionModel model) {
  return Container(
    child: Column(children: <Widget>[
      Container(
          decoration: BoxDecoration(
              color: model.item.isNotEmpty || model.item != null
                  ? const Color(0xFFFF0000)
                  : const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(3)),
          child: _buildSegment(context, model)),
      Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.topLeft,
          child: model.item.length != 0
              ? Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: List.from(model.item.map(
                    (e) => Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              width: 1, color: const Color(0xFFFF0000)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        e,
                        style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  )))
              : SizedBox(height: 10)),
      Container(
        margin: EdgeInsets.only(top: 12, left: 16),
        child: Row(
          children: <Widget>[
            Text("Notes      ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            Expanded(
              child: Divider(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      _buildDescription(context, model.notes)
    ]),
  );
}

Widget _buildSegment(BuildContext context, InspectionModel model) {
  if (model.item.isNotEmpty || model.item != null) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              child: _buildSegmentWhite(context, model),
            ),
            SizedBox(width: 8),
            Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(model.segment,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)))
          ],
        ));
  } else {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              child: _buildSegmentBlack(context, model),
            ),
            SizedBox(width: 8),
            Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(model.segment,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)))
          ],
        ));
  }
}

Widget _buildSegmentWhite(BuildContext context, InspectionModel model) {
  switch (model.segment) {
    case 'Leaks':
      return ImageIcon(AssetImage('assets/ic_water.png'),
          color: Colors.white, size: 25);
      break;
    case 'Misalignment':
      return ImageIcon(AssetImage('assets/ic_misalignment.png'),
          color: Colors.white, size: 25);
      break;
    case 'Support':
      return ImageIcon(AssetImage('assets/ic_support.png'),
          color: Colors.white, size: 25);
      break;
    case 'Vibration':
      return Icon(Icons.waves_outlined, color: Colors.white, size: 24);
      break;
    case 'External Corrosion':
      return ImageIcon(AssetImage('assets/ic_corrosion.png'),
          color: Colors.white, size: 25);
      break;
    case 'Insulation':
      return ImageIcon(AssetImage('assets/ic_insulation.png'),
          color: Colors.white, size: 25);
      break;
    case 'Other':
      return ImageIcon(AssetImage('assets/ic_asteriks.png'),
          color: Colors.white, size: 25);
      break;
    default:
      return SizedBox(height: 10);
  }
}

Widget _buildSegmentBlack(BuildContext context, InspectionModel model) {
  switch (model.segment) {
    case 'Leaks':
      return ImageIcon(AssetImage('assets/ic_water.png'),
          color: Colors.black, size: 25);
      break;
    case 'Misalignment':
      return ImageIcon(AssetImage('assets/ic_misalignment.png'),
          color: Colors.black, size: 25);
      break;
    case 'Support':
      return ImageIcon(AssetImage('assets/ic_support.png'),
          color: Colors.black, size: 25);
      break;
    case 'Vibration':
      return Icon(Icons.waves_outlined, color: Colors.black, size: 24);
      break;
    case 'External Corrosion':
      return ImageIcon(AssetImage('assets/ic_corrosion.png'),
          color: Colors.black, size: 25);
      break;
    case 'Insulation':
      return ImageIcon(AssetImage('assets/ic_insulation.png'),
          color: Colors.black, size: 25);
      break;
    case 'Other':
      return ImageIcon(AssetImage('assets/ic_asteriks.png'),
          color: Colors.black, size: 25);
      break;
    default:
      return SizedBox(height: 10);
  }
}

Future<InstallationInspectionResponse> fetchInstallationDetail(
    BuildContext context, String id) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var response = await http
      .get('${UrlCons.mainDevUrl}inspection-installation/$id', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });
  return InstallationInspectionResponse.fromJson(json.decode(response.body));
}
