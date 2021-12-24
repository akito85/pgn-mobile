import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/pengajuan_asuransi_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;

class WidgetReferensiBiaya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Biaya Premi Asuransi',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Text(
              'Liability dan Biaya Premi Asuransi Kebakaran',
              style: TextStyle(color: Color(0xFF427CEF)),
            ),
          ),
          Container(
            height: 45,
            color: Color(0xFFF4F4F4),
            margin: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 150,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Liability')),
                Text('Biaya Premi per Tahun')
              ],
            ),
          ),
          FutureBuilder<Liability>(
            future: getLiability(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.datasLiability.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Row(
                          children: [
                            Container(
                                width: 150,
                                margin: EdgeInsets.only(left: 16, right: 16),
                                child: Text(
                                    'Rp ${snapshot.data.datasLiability[i].name}')),
                            Text('Rp ${snapshot.data.datasLiability[i].cost}')
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<Liability> getLiability() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    var response = await http.get(
        '${UrlCons.mainProdUrl}customer-service/fire-insurance-application-cost?per_page=10000',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    Liability getLiability;
    getLiability = Liability.fromJson(json.decode(response.body));
    return getLiability;
  }
}
