import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/cm_visit_model.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/cm_visit/cm_visit_detail.dart';
import 'package:pgn_mobile/screens/cm_visit/cm_visit_form.dart';

class CMVisit extends StatefulWidget {
  @override
  _CMVisitState createState() => _CMVisitState();
}

class _CMVisitState extends State<CMVisit> {
  bool isVisibleButton = false;
  bool loadingIndicator = false;
  TextEditingController _searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'CM Visit',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              height: 45,
              margin: EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8,
                child: TextFormField(
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
                        if (_searchQuery.text.isNotEmpty) {
                          getCmVisit(context);
                          setState(() {
                            loadingIndicator = true;
                          });
                        } else {
                          setState(() {
                            loadingIndicator = true;
                          });
                          getCmVisit(context);
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
            _buildContent(context, getCmVisit(context)),
            Positioned(
              bottom: 10,
              left: 18,
              right: 18,
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFF427CEF)),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 8.0),
                          width: 24.0,
                          height: 24.0,
                          child: Icon(Icons.add, color: Colors.white)),
                      Text(
                        'Add New Visit Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CMVisitForm()));
                  },
                ),
              ),
            ),
            Visibility(
              visible: loadingIndicator,
              child: Padding(
                padding: EdgeInsets.only(),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Future<CMVisitList> list) {
    return FutureBuilder<CMVisitList>(
        future: list,
        builder: (context, snapsnapshot) {
          if (!snapsnapshot.hasData) return LinearProgressIndicator();
          return Container(
            margin: EdgeInsets.only(top: 65, bottom: 50),
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

  Future<CMVisitList> getCmVisit(BuildContext context) async {
    final sotarageCache = FlutterSecureStorage();
    String accessToken = await sotarageCache.read(key: 'access_token');
    String lang = await sotarageCache.read(key: 'lang');
    var cmVisitResponse = await http.get(
        '${UrlCons.mainDevUrl}cm-visit?search=${_searchQuery.text}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang
        });
    setState(() {
      loadingIndicator = false;
    });
    return CMVisitList.fromJson(json.decode(cmVisitResponse.body));
  }
}

Widget _cardState(BuildContext context, CMVisitModel model) {
  DateTime date = DateTime.parse(model.reportDate);
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CMVisitDetail(
                  id: model.id, name: model.customerCmModel.name)));
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
                model.customerCmModel.name,
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
        )),
  );
}
