import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class PaymentMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('title_bar_payment_method' ?? '-'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15),
          Container(
            child: ExpandableNotifier(
              child: ScrollOnExpand(
                scrollOnExpand: false,
                scrollOnCollapse: true,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 5),
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: ExpandablePanel(
                            tapHeaderToExpand: true,
                            hasIcon: false,
                            tapBodyToCollapse: true,
                            collapsed: Row(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  margin:
                                      EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0),
                                  child: Image.asset(
                                    'assets/bca.png',
                                    height: 120.0,
                                    width: 120.0,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.keyboard_arrow_right),
                                ))
                              ],
                            ),
                            expanded: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      margin: EdgeInsets.fromLTRB(
                                          15.0, 0.0, 0.0, 0),
                                      child: Image.asset(
                                        'assets/bca.png',
                                        height: 120.0,
                                        width: 120.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ))
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  child: Divider(color: Colors.black),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0),
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                                    child: Text(
                                      "Internet Banking BCA",
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 11),
                                        child: Text(
                                          'Pilih "Transaksi Lainya" pilih "Pembayaran"',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF404040),
                                              fontSize: 14),
                                        )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Pilih pembayaran "PAM/GAS", pilih perusahaan "PGN (GAS NEGARA)"',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Silahkan memsukkan kode area PGN + nomor ID Pelanggan secara lengkap dan benar, lalu tekan Benar.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Apabila nomor ID Pelanggan sudah benar maka akan muncul informasi data Pelanggan.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Tekan "Ya" untuk melakukan transaksi pembayaran.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        '6',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 11),
                                          child: Text(
                                            'Simpan struk ATM sebagai bukti pembayaran yang sah.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  crossFadePoint: 0,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: ExpandableNotifier(
              child: ScrollOnExpand(
                scrollOnExpand: false,
                scrollOnCollapse: true,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 5),
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: ExpandablePanel(
                            tapHeaderToExpand: true,
                            hasIcon: false,
                            tapBodyToCollapse: true,
                            collapsed: Row(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  margin:
                                      EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 0),
                                  child: Image.asset(
                                    'assets/icon_bank_mandiri.png',
                                    height: 120.0,
                                    width: 120.0,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.keyboard_arrow_right),
                                ))
                              ],
                            ),
                            expanded: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      margin: EdgeInsets.fromLTRB(
                                          35.0, 0.0, 0.0, 0),
                                      child: Image.asset(
                                        'assets/icon_bank_mandiri.png',
                                        height: 120.0,
                                        width: 120.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ))
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  child: Divider(color: Colors.black),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0),
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                                    child: Text(
                                      "Internet Banking Mandiri",
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 20),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 21),
                                        child: Text(
                                          'Buka www.bankmandiri.co.id',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF404040),
                                              fontSize: 14),
                                        )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Login User dan Pin Internet Banking.',
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Klik menu "Bayar" kemudian klik Sub Menu "Multi Payment"',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, top: 11),
                                        child: Text(
                                          'Pilih nomor Rekening Bank Mandiri Pelanggan. Pilih "Perusahaan Gas Negara".',
                                          style: TextStyle(
                                              color: Color(0xFF404040),
                                              fontSize: 14),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, top: 11),
                                        child: Text(
                                          'Masukkan kode area PGN + nomor ID Pelanggan kemudian klik "Lanjutkan".',
                                          style: TextStyle(
                                              color: Color(0xFF404040),
                                              fontSize: 14),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '6',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, top: 11),
                                        child: Text(
                                          'Jika ID yang diamsukkan sudah benar, akan muncul identitas serta tagihan.',
                                          style: TextStyle(
                                              color: Color(0xFF404040),
                                              fontSize: 14),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '7',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Beri tanda cek pada kolom tagihan, klik  "Lanjutkan"',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        '8',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 11),
                                          child: Text(
                                            'Masukkan token/PIN Mandiri untuk konfirmasi pembayaran dan tekan Kirim.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                ////////////////2
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  child: Divider(color: Colors.black),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0),
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                                    child: Text(
                                      "ATM Mandiri",
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 20),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 21),
                                          child: Text(
                                            'Pilih "BAYAR/BELI", pilih "Listrik / Gas", pilih "Gas Negara".',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Masukkan kode area PGN + nomor ID Pelanggan secara lengkap dan benar, kemudian tekan "Benar".',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Apabila nomor ID Pelanggan sudah benar, maka muncul informasi tagihan gas serta data Pelanggan.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Tekan "1" untuk pembayaran kemudian tekan "ya".',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 11),
                                          child: Text(
                                            'Simpan struk ATM sebagai bukri bayar yang sah.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                ///////3
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  child: Divider(color: Colors.black),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0),
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                                    child: Text(
                                      "Teller Ban Mandiri",
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 20),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 21),
                                          child: Text(
                                            'Kunjungi teller Bank Mandiri terdekat.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Ambil Formulir Multi Pembayaran.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Isilah formulir tersebut. Pada kolom penerimaan, isi Nama Perusahaan Penyedia Jasa "PGN". Kemudian lanjutkan dengan mengisi Nomor Pelanggan, pada kolom Penyetoran/Pemilik Rekening, isi Nama dan Alamat.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Selanjutnya pada kolom Tujuan Transkasi, isi dengan pembayaran gas PGN. Pada kolom Mata Uang, contreng bagian kontak Rupiah. Pada kolom Jenis Setoran, contreng tunai atau masukkan nomor rekening jika mekanisme pendebetan. Pada kolom Jumlah dan Terbilang,  masukkan total tagihannya.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Serahkan formulir tersebut pada teller.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        '6',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 11),
                                          child: Text(
                                            'Simpan bukti pembayaran.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  crossFadePoint: 0,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 2 //////////////
          Container(
            child: ExpandableNotifier(
              child: ScrollOnExpand(
                scrollOnExpand: false,
                scrollOnCollapse: true,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 5),
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: ExpandablePanel(
                            tapHeaderToExpand: true,
                            hasIcon: false,
                            tapBodyToCollapse: true,
                            collapsed: Row(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  margin:
                                      EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 0),
                                  child: Image.asset(
                                    'assets/icon_bank_bri.png',
                                    height: 120.0,
                                    width: 120.0,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.keyboard_arrow_right),
                                ))
                              ],
                            ),
                            expanded: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      margin: EdgeInsets.fromLTRB(
                                          35.0, 0.0, 0.0, 0),
                                      child: Image.asset(
                                        'assets/icon_bank_bri.png',
                                        height: 120.0,
                                        width: 120.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ))
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  child: Divider(color: Colors.black),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0),
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                                    child: Text(
                                      "ATM BRI",
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 20),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 21),
                                        child: Text(
                                          'Pilih "Transaksi Lainnya", pilih "Pembayaran".',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF404040),
                                              fontSize: 14),
                                        )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Pilih "Pembayaran Lainnya", pilih "Pembayaran PGN".',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Masukkan kode area PGN + nomor ID Pelanggan secara lengkap dan benar.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Jika nomor ID Pelanggan sudah benar maka akan muncul informasi data pembayaran pelanggan.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Tekan "Ya" untuk melanjutkan transaksi pembayaran.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        '6',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 11),
                                          child: Text(
                                            'Simpan struk ATM sebagai bukti pembayaran yang sah.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  crossFadePoint: 0,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //NEW3 ////////////////////
          Container(
            child: ExpandableNotifier(
              child: ScrollOnExpand(
                scrollOnExpand: false,
                scrollOnCollapse: true,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 5),
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: ExpandablePanel(
                            tapHeaderToExpand: true,
                            hasIcon: false,
                            tapBodyToCollapse: true,
                            collapsed: Row(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  margin:
                                      EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 0),
                                  child: Image.asset(
                                    'assets/btn.png',
                                    height: 120.0,
                                    width: 120.0,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.keyboard_arrow_right),
                                ))
                              ],
                            ),
                            expanded: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      margin: EdgeInsets.fromLTRB(
                                          35.0, 0.0, 0.0, 0),
                                      child: Image.asset(
                                        'assets/btn.png',
                                        height: 120.0,
                                        width: 120.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ))
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  child: Divider(color: Colors.black),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0),
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                                    child: Text(
                                      "ATM BTN",
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 20),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 21),
                                        child: Text(
                                          'Pilih "Transaksi Lainnya".',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF404040),
                                              fontSize: 14),
                                        )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Pilih "Pembayaran".',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Pilih "Pembayaran Gas".',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Input kode area PGN + nomor ID Pelanggan PGN.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Tekan "Benar" jika nomor ID sudah benar.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '6',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Pilih tipe rekening giro/tabungan.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '7',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Munucl informasi tagihan gas beserta data pelanggan, tekan "Ya" untuk melakukan pembayaran.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        '8',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 11),
                                          child: Text(
                                            'Simpan struk ATM sebagi bukti pembayaran yang sah.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                ////////////////2
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  child: Divider(color: Colors.black),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0),
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                                    child: Text(
                                      "Teller BTN",
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 20),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 21),
                                          child: Text(
                                            'Kunjungi teller BTN terdekat.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Ambil Formulir Pembayaran Jasa.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Isilah formulir tersebut. Pada kolom Pembayaran Jasa, contreng bagian kotak lain-lain dan tulis "GAS PGN". Kemudian lanjutkan dengan mengisi ID Pelanggan, Nama Pelanggan, dan Alamat Pelanggan.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Serahkan formulir tersebut pada teller',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 11),
                                          child: Text(
                                            'Simpan bukti pembayaran',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                ///////3
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  child: Divider(color: Colors.black),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0),
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                                    child: Text(
                                      "Internet Banking BTN",
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 20),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 21),
                                          child: Text(
                                            'Buka https://internetbanking.btn.co.id',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Login user ID dan Password internet banking.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Pilih menu "Pembayaran" kemudian pilih "Penermia Tidak Ada di Daftar".',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Pilih GAS pada kolom Kategori Institusi, pilih PERUSAHAAN GAS NEGARA pada kolom institusi, masukkan Nama Pelanggan pada kolom Penerima, masukkan Nomor Pelanggan pada kolom ID Pealanggan.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Pada menu Dari Rekening, pilih nomor rekening BTN pelanggan.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '6',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Pada menu Jadwal Transaksi, pilih "SEKARANG"',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '7',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Beri tanda cek pada kolom Syarat dan Ketentuan,  klik "Lanjut", klik "Konfirmasi"',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '8',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Masukkan token untuk konfirmasi pembayaran, klik "Lanjut", dan klik "OK"',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        '9',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 11),
                                          child: Text(
                                            'Pilih cetak/simpan bukti pembayaran',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  crossFadePoint: 0,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //New 4//////////////
          Container(
            child: ExpandableNotifier(
              child: ScrollOnExpand(
                scrollOnExpand: false,
                scrollOnCollapse: true,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 5),
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: ExpandablePanel(
                            tapHeaderToExpand: true,
                            hasIcon: false,
                            tapBodyToCollapse: true,
                            // headerAlignment: ExpandablePanelHeaderAlignment.top,
                            collapsed: Row(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  margin:
                                      EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0),
                                  child: Image.asset(
                                    'assets/Indomaret.png',
                                    height: 120.0,
                                    width: 120.0,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.keyboard_arrow_right),
                                ))
                              ],
                            ),
                            expanded: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      margin: EdgeInsets.fromLTRB(
                                          25.0, 0.0, 0.0, 0),
                                      child: Image.asset(
                                        'assets/Indomaret.png',
                                        height: 120.0,
                                        width: 120.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ))
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  child: Divider(color: Colors.black),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0),
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                                    child: Text(
                                      "Payment Point Online Bank",
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 20),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 21),
                                        child: Text(
                                          'Sebutkan kode area PGN dan nomor ID Pelanggan.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF404040),
                                              fontSize: 14),
                                        )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Jika nomor ID Pelanggan sudah benar, maka disebutkan Nama Pelanggan dan besar tagihan.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 11),
                                          child: Text(
                                            'Bayarkan ke Loket PPOB/Indomaret ',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Color(0xFFFF972F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 15,
                                              top: 11),
                                          child: Text(
                                            'Simpan struk PPOB/Indomaret sebagai bukti bayar yang sah.',
                                            style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 14),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  crossFadePoint: 0,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
