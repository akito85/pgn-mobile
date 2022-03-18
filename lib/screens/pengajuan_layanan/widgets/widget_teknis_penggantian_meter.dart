import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/penggantian_meter_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;

class WidgetReferensiBiayaTeknisPenggantianMeter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Biaya Penggantian Meter Gas',
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
                          child: Text('Jenis G Size Meter')),
                      Text('Biaya yang Dikenakan')
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
                          child: Text(
                              '${snapshot.data.area1.dataPenutupanG16.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area1.dataPenutupanG16.cost))}')
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
                          child: Text(
                              '${snapshot.data.area1.dataPenutupanG25.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area1.dataPenutupanG25.cost))}')
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
                          child: Text(
                              '${snapshot.data.area1.dataPenutupanG4.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area1.dataPenutupanG4.cost))}')
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
                          child: Text(
                              '${snapshot.data.area1.dataPenutupanG6.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area1.dataPenutupanG6.cost))}')
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
                          child: Text(
                              '${snapshot.data.area1.dataPenutupanG10.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area1.dataPenutupanG10.cost))}')
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
                          child: Text(
                              '${snapshot.data.area1.dataPenutupanG162.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area1.dataPenutupanG162.cost))}')
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
                          child: Text(
                              '${snapshot.data.area1.dataPenutupanG252.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area1.dataPenutupanG252.cost))}')
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                // AREA 2
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
                          child: Text('Jenis G Size Meter')),
                      Text('Biaya yang Dikenakan')
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
                          child: Text(
                              '${snapshot.data.area2.dataPenutupanG16.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area2.dataPenutupanG16.cost))}')
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
                          child: Text(
                              '${snapshot.data.area2.dataPenutupanG25.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area2.dataPenutupanG25.cost))}')
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
                          child: Text(
                              '${snapshot.data.area2.dataPenutupanG4.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area2.dataPenutupanG4.cost))}')
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
                          child: Text(
                              '${snapshot.data.area2.dataPenutupanG6.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area2.dataPenutupanG6.cost))}')
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
                          child: Text(
                              '${snapshot.data.area2.dataPenutupanG10.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area2.dataPenutupanG10.cost))}')
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
                          child: Text(
                              '${snapshot.data.area2.dataPenutupanG162.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area2.dataPenutupanG162.cost))}')
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
                          child: Text(
                              '${snapshot.data.area2.dataPenutupanG252.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area2.dataPenutupanG252.cost))}')
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),

                /// AREA 3
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
                          child: Text('Jenis G Size Meter')),
                      Text('Biaya yang Dikenakan')
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
                          child: Text(
                              '${snapshot.data.area3.dataPenutupanG16.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area3.dataPenutupanG16.cost))}')
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
                          child: Text(
                              '${snapshot.data.area3.dataPenutupanG25.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area3.dataPenutupanG25.cost))}')
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
                          child: Text(
                              '${snapshot.data.area3.dataPenutupanG4.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area3.dataPenutupanG4.cost))}')
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
                          child: Text(
                              '${snapshot.data.area3.dataPenutupanG6.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area3.dataPenutupanG6.cost))}')
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
                          child: Text(
                              '${snapshot.data.area3.dataPenutupanG10.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area3.dataPenutupanG10.cost))}')
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
                          child: Text(
                              '${snapshot.data.area3.dataPenutupanG162.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area3.dataPenutupanG162.cost))}')
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
                          child: Text(
                              '${snapshot.data.area3.dataPenutupanG252.type}')),
                      Text(
                          'Rp ${NumberFormat.currency(locale: 'ID', symbol: '').format(double.parse(snapshot.data.area3.dataPenutupanG252.cost))}')
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
          }),
    );
  }

  Future<Biaya> getLiability() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    var response = await http.get(
        '${UrlCons.mainProdUrl}customer-service/technical-service-change-meter-gas-cost',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    Biaya getBiaya;
    getBiaya = Biaya.fromJson(json.decode(response.body));
    return getBiaya;
  }
}