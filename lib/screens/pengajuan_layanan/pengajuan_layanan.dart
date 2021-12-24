import 'package:flutter/material.dart';
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

class PengajuanLayanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: Color(0xff427CEF),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PengajuanTeknisList(
                    techId: 33,
                    techName: 'Pemasangan PGN Meter',
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pemasangan PGN Meter')),
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
                  builder: (context) => PengajuanTeknisList(
                    techId: 34,
                    techName: 'Pemasangan Pipa Instalasi per meter',
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pemasangan Pipa Instalasi per meter')),
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
                  builder: (context) => PengajuanTeknisList(
                    techId: 35,
                    techName: 'Pasang Water Heater Rinnai',
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pasang Water Heater Rinnai')),
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
                  builder: (context) => PengajuanTeknisList(
                    techId: 36,
                    techName: 'Pembersihan Tungku Kompor',
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pembersihan Tungku Kompor')),
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
                  builder: (context) => PengajuanTeknisList(
                    techId: 37,
                    techName: 'Penambahan Pipa Instalasi',
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Penambahan Pipa Instalasi')),
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
                  builder: (context) => PengajuanTeknisList(
                    techId: 38,
                    techName: 'Perbaikan Pipa Instalasi',
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Perbaikan Pipa Instalasi')),
                  ),
                ],
              ),
            ),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PengembalianPembayaranList(),
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Pengembalian Sisa Jaminan')),
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
                  builder: (context) => PengajuanAsuransiList(),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KlaimAsuransiList(),
                ),
              );
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
}
