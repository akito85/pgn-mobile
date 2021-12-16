import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/pengembalian_pembayaran_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/otp/otp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PengembalianPembayaranDetail extends StatefulWidget {
  final int id;
  PengembalianPembayaranDetail({this.id});
  @override
  _PengembalianPembayaranDetailState createState() =>
      _PengembalianPembayaranDetailState(id: id);
}

class _PengembalianPembayaranDetailState
    extends State<PengembalianPembayaranDetail> {
  final int id;
  _PengembalianPembayaranDetailState({this.id});
  final storageCache = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF427CEF),
      appBar: AppBar(
        backgroundColor: Color(0xFF427CEF),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Pengembalian Sisa Jaminan Pembayaran',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: FutureBuilder<DetailData>(
          future: getFuturePengembalianPembayaranDetail(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
                child: LinearProgressIndicator(),
              );
            if (snapshot.data == null)
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 150),
                    alignment: Alignment.center,
                    child: Image.asset('assets/penggunaan_gas.png'),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Error',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              );
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  height: 70,
                  color: Color(0xFF427CEF),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(snapshot.data.status ?? '',
                            style: TextStyle(
                                color: Color(0xFF427CEF),
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(top: 5, bottom: 5, left: 15),
                          child: Text(
                              DateFormat('dd MMM yyy | hh:mm:ss a').format(
                                  DateTime.parse(snapshot.data.createdAt)
                                      .toLocal()),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 80),
                  padding: EdgeInsets.only(left: 18, right: 18, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 15),
                        child: Text('Data Diri',
                            style: TextStyle(
                                color: Color(0xFF427CEF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('ID Pelanggan'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.custId}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Nama Pelanggan'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.custName}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Jenis Kelamin'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.gender}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Tempat, Tanggal Lahir'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                    '${snapshot.data.bPlace}, ${DateFormat('dd MMMM yyy').format(DateTime.parse(snapshot.data.bDate).toLocal())}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('NIK (KTP/SIM)'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.nik}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Email'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.email}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Nomer Handphone'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.phoneNumb}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 15, bottom: 15),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Text('Alamat',
                            style: TextStyle(
                                color: Color(0xFF427CEF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Alamat'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.address}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Perumahan / Apartment (optional)'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.street}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('RT / RW, Kelurahan'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                    '${snapshot.data.rt} / ${snapshot.data.rw}, ${snapshot.data.kelurahan}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Kecamatan, kabupaten'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                    '${snapshot.data.kecamatan}, ${snapshot.data.kabupaten}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Provinsi, Kode Pos'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                    '${snapshot.data.prov}, ${snapshot.data.postalCode}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Koordinat Lokasi'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                    '${snapshot.data.lat},${snapshot.data.long}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Status di Lokasi Pelanggan'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.locStat}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 15, bottom: 15),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Text('Data Pelengkap',
                            style: TextStyle(
                                color: Color(0xFF427CEF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Nama Pemilik Rekening'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.accountBankName}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Nomer Rekening'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.bankNumb}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Nama Bank'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.bankName}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text('Kantor Cabang'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 10,
                              child: Text(':'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('${snapshot.data.bankBranch}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20, top: 40),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                deleteFormIdAlert();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 5),
                                child: Text(
                                  'Hapus',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         BerhentiBerlanggananUpdate(
                                  //             id: widget.id),
                                  //   ),
                                  // );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF81C153),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 5),
                                  child: Text('Update'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Future<bool> deleteFormIdAlert() {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
    );
    return Alert(
      context: context,
      style: alertStyle,
      title: "Information !",
      content: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            "Anda yakin ingin menghapus pengajuan pengembalian sisa jaminan pembayaran ini ? ",
            style: TextStyle(
                // color: painting.Color.fromRGBO(255, 255, 255, 0),
                fontSize: 17,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10)
        ],
      ),
      buttons: [
        DialogButton(
          width: 130,
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Colors.green,
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          width: 130,
          onPressed: () async {
            deleteFormId();
          },
          color: Colors.red,
          child: Text(
            "Delete",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }

  Future<DetailData> getFuturePengembalianPembayaranDetail() async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var response = await http.get(
        '${UrlCons.mainDevUrl}customer-service/return-deposit/${widget.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang,
        });
    print('GET DETAIL PENGALIRAN KEMBALI ${response.body}');
    return DetailData.fromJson(json.decode(response.body));
  }

  void deleteFormId() async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseDeleteCustId = await http.delete(
      '${UrlCons.mainProdUrl}customer-service/return-deposit/${widget.id}',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
    );
    Create deleteFormId =
        Create.fromJson(json.decode(responseDeleteCustId.body));
    if (responseDeleteCustId.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      showToast(deleteFormId.dataCreate.message);
    } else {
      showToast(deleteFormId.dataCreate.message);
    }
  }
}
