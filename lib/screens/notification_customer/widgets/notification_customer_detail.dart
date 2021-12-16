import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/notification_customer_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;

class NotifCustDetail extends StatelessWidget {
  final int id;
  NotifCustDetail({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Inbox Detail',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _buildContent(context, fetchPost(context, id)),
    );
  }

  Widget _buildContent(BuildContext context, Future<DataNotif> getListNotif) {
    return FutureBuilder<DataNotif>(
      future: getListNotif,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.message != null)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 180),
              Container(
                alignment: Alignment.center,
                child: Image.asset('assets/penggunaan_gas.png'),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  snapshot.data.message,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            ],
          );
        return ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 8,
                  color: Color(0xFF427CEF),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 10, right: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${snapshot.data.payload.type}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 10, right: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${snapshot.data.payload.title}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 15, right: 15),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 15, right: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${snapshot.data.payload.body}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              wordSpacing: 2),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: snapshot.data.payload.imageUrl != null
                              ? Image.network(
                                  snapshot.data.payload.imageUrl,
                                )
                              : Text('-')),
                    ],
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  Future<DataNotif> fetchPost(BuildContext context, int id) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var response = await http.get(
      '${UrlCons.mainProdUrl}customers/me/notification-inbox/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
    );
    DataNotif notifCustModel = DataNotif.fromJson(json.decode(response.body));

    return notifCustModel;
  }
}
