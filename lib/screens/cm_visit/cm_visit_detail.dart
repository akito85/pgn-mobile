import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/cm_visit_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/cm_visit_response.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'cm_visit_form.dart';

class CMVisitDetail extends StatefulWidget {
  CMVisitDetail({this.id});
  final String id;
  @override
  _CMVisitDetailState createState() => _CMVisitDetailState(id);
}

class _CMVisitDetailState extends State<CMVisitDetail> {
  ProgressDialog progressDialog;
  final String id;
  _CMVisitDetailState(this.id);
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 12, left: 16, right: 16),
          decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(3)),
          child: Padding(
            padding:
                EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
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
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Text(
              'Documentation',
              style: TextStyle(
                  color: const Color(0xFF427CEF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )),
        Container(
          height: 100,
          margin: EdgeInsets.only(top: 14),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: model.data.images.length + 1,
            itemBuilder: (context, int index) {
              return index < model.data.images.length
                  ? _listPhotos(context, model.data.images[index])
                  : SizedBox(height: 15);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 34, bottom: 14, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 120.0,
                height: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFD3D3D3)),
                child: MaterialButton(
                    child: Text('Delete',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    onPressed: () {
                      progressDialog.show();
                      deleteContent(context, id);
                    }),
              ),
              Container(
                width: 228.0,
                height: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF81C153)),
                child: MaterialButton(
                    child: Text('Edit Report',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CMVisitForm(
                                  id: model.data.id.toString(),
                                  date: DateFormat("d MMMM yyyy")
                                      .format(date)
                                      .toString(),
                                  activity: model.data.activityType,
                                  visitType: model.data.visitType,
                                  activityDesc: model.data.activityDescription,
                                  customerName: model.data.customerCmModel.name,
                                  customerId: model.data.customerCmModel.id,
                                  contactPerson:
                                      model.data.contactPersonModel.name,
                                  address:
                                      model.data.contactPersonModel.address,
                                  phoneNumber:
                                      model.data.contactPersonModel.phone,
                                  emailAddress:
                                      model.data.contactPersonModel.email,
                                  report: model.data.report)));
                      // photo1: model.data.images[0].isNotEmpty
                      //     ? model.data.images[0]
                      //     : "",
                      // photo2: model.data.images[1].isNotEmpty
                      //     ? model.data.images[1]
                      //     : "",
                      // photo3: model.data.images[2].isNotEmpty
                      //     ? model.data.images[2]
                      //     : ""
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _listPhotos(BuildContext context, String images) {
    var splitString = images.split(',');
    Uint8List image = base64.decode(splitString[1]);
    return InkWell(
        onTap: () {
          _showDialog(context, images);
        },
        child: Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(right: 15, left: 15),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    fit: BoxFit.fill, image: MemoryImage(image)))));
  }

  void _showDialog(BuildContext context, String images) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var splitString = images.split(',');
          Uint8List image = base64.decode(splitString[1]);
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.transparent,
            content: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 500.0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 350,
                        height: 400,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.fill, image: MemoryImage(image)))),
                    Text(
                      images,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )
                  ]),
            ),
          );
        });
  }

  Future<CmVisitReponse> deleteContent(BuildContext context, String id) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    var response =
        await http.delete('${UrlCons.mainProdUrl}cm-visit/$id', headers: {
      'Authorization': 'Bearer $accessToken',
    });
    if (response.statusCode == 200) {
      setState(() {
        progressDialog.hide();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/cmVisit');
      });
    }
    return CmVisitReponse.fromJson(json.decode(response.body));
  }
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
