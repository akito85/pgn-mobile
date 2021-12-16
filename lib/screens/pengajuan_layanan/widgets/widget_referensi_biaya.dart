import 'package:flutter/material.dart';

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
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Container(
                    width: 150,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 30.000.000')),
                Text('Rp 15.000')
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
                    width: 150,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 50.000.000')),
                Text('Rp 20.000')
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
                    width: 150,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 70.000.000')),
                Text('Rp 25.000')
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
                    width: 150,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 90.000.000')),
                Text('Rp 30.000')
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
                    width: 150,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 110.000.000')),
                Text('Rp 35.000')
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
                    width: 150,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 130.000.000')),
                Text('Rp 40.000')
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
                    width: 150,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 150.000.000')),
                Text('Rp 45.000')
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
                    width: 150,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Rp 200.000.000')),
                Text('Rp 55.000')
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
