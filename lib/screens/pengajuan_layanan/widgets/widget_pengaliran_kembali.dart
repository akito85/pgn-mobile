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
      body: FutureBuilder<Biaya>(
        future: getLiability(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Text(
                  snapshot.data.area1.name,
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
                        child: Text('Jenis Pelanggan')),
                    Text('Pengaliran Kembali')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text('${snapshot.data.area1.dataRT.type}')),
                    Text(
                        '${snapshot.data.area1.dataRT.currency} ${snapshot.data.area1.dataRT.totalCost}')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text('${snapshot.data.area1.dataPK.type}')),
                    Text(
                        '${snapshot.data.area1.dataPK.currency} ${snapshot.data.area1.dataPK.totalCost}')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              ////////////// 2
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Text(
                  snapshot.data.area2.name,
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
                        child: Text('Jenis Pelanggan')),
                    Text('Pengaliran Kembali')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text('${snapshot.data.area2.dataRT.type}')),
                    Text(
                        '${snapshot.data.area2.dataRT.currency} ${snapshot.data.area2.dataRT.totalCost}')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text('${snapshot.data.area2.dataPK.type}')),
                    Text(
                        '${snapshot.data.area2.dataPK.currency} ${snapshot.data.area2.dataPK.totalCost}')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              ////////////// 3
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Text(
                  snapshot.data.area3.name,
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
                        child: Text('Jenis Pelanggan')),
                    Text('Pengaliran Kembali')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text('${snapshot.data.area3.dataRT.type}')),
                    Text(
                        '${snapshot.data.area3.dataRT.currency} ${snapshot.data.area3.dataRT.totalCost}')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text('${snapshot.data.area3.dataPK.type}')),
                    Text(
                        '${snapshot.data.area3.dataPK.currency} ${snapshot.data.area3.dataPK.totalCost}')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              ////////////// 4
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Text(
                  snapshot.data.area4.name,
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
                        child: Text('Jenis Pelanggan')),
                    Text('Pengaliran Kembali')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text('${snapshot.data.area4.dataRT.type}')),
                    Text(
                        '${snapshot.data.area4.dataRT.currency} ${snapshot.data.area4.dataRT.totalCost}')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text('${snapshot.data.area4.dataPK.type}')),
                    Text(
                        '${snapshot.data.area4.dataPK.currency} ${snapshot.data.area4.dataPK.totalCost}')
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
      ),
    );
  }

  Future<Biaya> getLiability() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    var response = await http
        .get('${UrlCons.mainProdUrl}customer-service/reflow-cost', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    });
    Biaya getBiaya;
    getBiaya = Biaya.fromJson(json.decode(response.body));
    return getBiaya;
  }
}
