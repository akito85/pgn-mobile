import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/penghentian_sementara_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;

class WidgetBiayaAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Biaya Administrasi Penghentian Sementara',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 10),
            child: Text(
              'Pelayanan Wilayah Utama',
              style: TextStyle(color: Color(0xFF427CEF)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: Text(
              'Provinsi Sumatera Utara, Riau, Kepulauan Riau, Jambi, Sumatera Selatan, Lampung, DKI Jakarta, Jawa Barat, Banten, Kalimantan Utara, Kalimantan Timur, Jawa Tengah, Jawa Timur, Sulawesi Selatan, Sulawesi Tenggara',
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          Container(
            height: 60,
            color: Color(0xFFF4F4F4),
            margin: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: Text('Jenis G Size Meter')),
                Container(
                    width: 110,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Penutupan Aliran Gas')),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text('Penutupan Aliran Gas & Pencabutan Meter')))
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
                                width: 70,
                                margin: EdgeInsets.only(left: 16, right: 5),
                                child:
                                    Text(snapshot.data.titleData[i].meteSize)),
                            Container(
                                width: 110,
                                margin: EdgeInsets.only(left: 16, right: 16),
                                child: Text(
                                    'Rp ${snapshot.data.titleData[i].gasClosing}')),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                        'Rp ${snapshot.data.titleData[i].gasAndMeterClosing}')))
                          ],
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 10),
                          child: Divider(
                            color: Colors.grey,
                          )),
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
        '${UrlCons.mainProdUrl}customer-service/temporary-suspend-cost?per_page=10000',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    Biaya getBiaya;
    getBiaya = Biaya.fromJson(json.decode(response.body));
    return getBiaya;
  }
}
