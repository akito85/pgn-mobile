import 'package:flutter/material.dart';

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
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: Text('G.1.6')),
                Container(
                    width: 110,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 100.000')),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text('Rp 135.000')))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Divider(
                color: Colors.grey,
              )),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: Text('G.2.5')),
                Container(
                    width: 110,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 100.000')),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text('Rp 150.000')))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Divider(
                color: Colors.grey,
              )),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: Text('G.4')),
                Container(
                    width: 110,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 160.000')),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text('Rp 195.000')))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Divider(
                color: Colors.grey,
              )),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: Text('G.6')),
                Container(
                    width: 110,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 160.000')),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text('Rp 200.000')))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Divider(
                color: Colors.grey,
              )),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: Text('G.10')),
                Container(
                    width: 110,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 160.000')),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text('Rp 235.000')))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Divider(
                color: Colors.grey,
              )),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: Text('G.10')),
                Container(
                    width: 110,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 160.000')),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text('Rp 235.000')))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Divider(
                color: Colors.grey,
              )),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: Text('G.16')),
                Container(
                    width: 110,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 290.000')),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text('Rp 580.000')))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Divider(
                color: Colors.grey,
              )),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: Text('G.25')),
                Container(
                    width: 110,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 290.000')),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text('Rp 610.000')))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Divider(
                color: Colors.grey,
              )),
        ],
      ),
    );
  }
}
