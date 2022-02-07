import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/pengajuan_teknis_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/cicilan/cicilan_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/klaim_asuransi/klaim_asuransi_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pemasangan_kembali/pemasangan_kembali_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pembaruan_data/pembaruan_data_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pengajuan_amandemen/pengajuan_amandemen_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pengajuan_asuransi/pengajuan_asuransi_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pengajuan_teknis/pengajuan_teknis_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pengaliran_kembali/pengaliran_kembali_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/berhenti_berlangganan/berhenti_berlangganan_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pengembalian_pembayaran/pengembalian_pembayaran_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/penghentian_sementara/penghentian_sementara_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class PengajuanLayanan extends StatefulWidget {
  @override
  _PengajuanLayananState createState() => _PengajuanLayananState();
}

class _PengajuanLayananState extends State<PengajuanLayanan> {
  String custID = '';
  final storageCache = FlutterSecureStorage();

  void initState() {
    super.initState();
    getDataCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Pengajuan Layanan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pengajuanBanner.jpeg'),
              ),
            ),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18, top: 20),
            child: Text(
                'Pengajuan layanan kepelangganan dapat dilakukan dengan mengisi form pengajuan sesuai dengan daftar layanan di bawah ini:'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18, top: 44),
            child: Row(
              children: [
                Container(width: 85, child: Text('Layanan Komersial')),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 34, right: 18, top: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PengajuanAmandemenList(),
                  ),
                );
              },
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF427CEF),
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/doc-amandemen.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pengajuan Amendemen')),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BerhentiBerlanggananList(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 34, right: 18, top: 20),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF427CEF),
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/doc-stop service.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pengajuan Berhenti Berlangganan')),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18, top: 44),
            child: Row(
              children: [
                Expanded(
                  child: Container(child: Text('Layanan Teknis & Operasional')),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PenghentianSementaraList(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 34, right: 18, top: 20),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF427CEF),
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/doc-pause.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Penghentian Sementara')),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PengaliranKembaliList(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 34, right: 18, top: 20),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF427CEF),
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/doc-run.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pengaliran Kembali')),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PemasanganKembaliList(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 34, right: 18, top: 20),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF427CEF),
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/doc-install.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pemasangan Kembali')),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder<PengajuanTeknisTypeModel>(
            future: getFutureKlaimAsuransiList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
                  child: LinearProgressIndicator(),
                );
              if (snapshot.data.code != null) return SizedBox();
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PengajuanTeknisList(
                              techId: snapshot.data.data[i].id,
                              techName: snapshot.data.data[i].name,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 34, right: 18, top: 20),
                        child: Row(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFF427CEF),
                                  radius: 15,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset(
                                      'assets/doc-technical.png',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(snapshot.data.data[i].name)),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18, top: 44),
            child: Row(
              children: [
                Container(width: 85, child: Text('Lain-Lain')),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PembaruanDataiList(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 34, right: 18, top: 20),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF427CEF),
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/doc-update.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pembaruan Data Pelanggan')),
                  ),
                ],
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => PengembalianPembayaranList(),
          //       ),
          //     );
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 34, right: 18, top: 20),
          //     child: Row(
          //       children: [
          //         Center(
          //           child: Padding(
          //             padding: EdgeInsets.only(right: 12.0),
          //             child: CircleAvatar(
          //               backgroundColor: Color(0xFF427CEF),
          //               radius: 15,
          //               child: Padding(
          //                 padding: const EdgeInsets.all(2.0),
          //                 child: Image.asset(
          //                   'assets/doc-return.png',
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Expanded(
          //           child: Padding(
          //               padding: const EdgeInsets.only(left: 5),
          //               child: Text('Pengembalian Sisa Jaminan')),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CicilanList(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 34, right: 18, top: 20),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF427CEF),
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/doc-return.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pengajuan Layanan Cicilan JP/Piutang')),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (custID.contains('000')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PengajuanAsuransiList(),
                  ),
                );
              } else {
                successAlert(context, 'Pengajuan Asuransi Kebakaran');
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 34, right: 18, top: 20),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF427CEF),
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/doc-insurance.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pengajuan Asuransi Kebakaran')),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // if (custID.contains('000')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KlaimAsuransiList(),
                ),
              );
              // } else {
              //   successAlert(context, 'Klaim Asuransi');
              // }
            },
            child: Padding(
              padding:
                  EdgeInsets.only(left: 34, right: 18, top: 20, bottom: 44),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF427CEF),
                        radius: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/doc-claim.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Klaim Asuransi')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getDataCred() async {
    String custIDString = await storageCache.read(key: 'customer_id');
    setState(() {
      custID = custIDString;
    });
  }

  Future<bool> successAlert(BuildContext context, String title) {
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
      title: "Informasi !",
      content: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            'Pengajuan Layanan $title hanya untuk pelanggan GPIR & GPIK',
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
            "Ok",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }

  Future<PengajuanTeknisTypeModel> getFutureKlaimAsuransiList() async {
    String accessToken = await storageCache.read(key: 'access_token');
    var response = await http.get(
        '${UrlCons.mainDevUrl}customer-service/technical-service-job-type',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        });
    //print('GET LIST JENIS LAYANAN TEKNIS ${response.body}');
    return PengajuanTeknisTypeModel.fromJson(json.decode(response.body));
  }
}
