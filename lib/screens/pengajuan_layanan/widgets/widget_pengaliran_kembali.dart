import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/pengaliran_kembali_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;

class WidgetReferensiBiayaTeknis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Informasi Biaya Pengaliran Kembali',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Text(
              'Provinsi Sumatera Utara, Riau, Kepulauan Riau, Jambi, Sumatera Selatan, Lampung, DKI Jakarta, Jawa Barat, Banten, Kalimantan Utara, Kalimantan Timur, Jawa Tengah, Jawa Timur, Sulawesi Selatan, Sulawesi Tenggara',
              style: TextStyle(color: Color(0xFF5C727D), height: 2),
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
                    child: Text('Area')),
                Text('Pengaliran Kembali')
              ],
            ),
          ),
          FutureBuilder<Biaya>(
            future: getLiability(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.titleData.length,
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
                                child:
                                    Text('${snapshot.data.titleData[i].area}')),
                            Text('Rp ${snapshot.data.titleData[i].cost}')
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

  Future<Biaya> getLiability() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    var response = await http.get(
        '${UrlCons.mainProdUrl}customer-service/reflow-cost?per_page=10000',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    Biaya getBiaya;
    getBiaya = Biaya.fromJson(json.decode(response.body));
    return getBiaya;
  }
}
