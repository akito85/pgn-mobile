import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:pgn_mobile/models/pengajuan_amendemen_segmen_model.dart';
import 'package:pgn_mobile/models/provinces_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;

import 'package:pgn_mobile/screens/otp/otp.dart';
import 'package:pgn_mobile/screens/register/widgets/map_point.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PengajuanAmandemenSegmenUpdate extends StatefulWidget {
  final int id;
  PengajuanAmandemenSegmenUpdate({this.id});
  @override
  _PengajuanAmandemenSegmenUpdateState createState() =>
      _PengajuanAmandemenSegmenUpdateState(id: id);
}

class _PengajuanAmandemenSegmenUpdateState
    extends State<PengajuanAmandemenSegmenUpdate> {
  final int id;
  _PengajuanAmandemenSegmenUpdateState({this.id});
  DetailData detailDatas = DetailData();
  List listGenderType = [
    "Laki-Laki",
    "Perempuan",
  ];

  List listStatusKepemilikan = [
    "Pemilik",
    "Penyewa",
    "Lain-lain",
  ];

  List listKelompokPelanggan = [
    "KI",
    "RT",
    "Bulk",
  ];

  List listJenisPemakaianGas = [
    "Kebutuhan sendiri/RT",
    "Kebutuhan usaha/komersial",
    "Puskesmas, RS pemerintah, Lembaga sosial, Lembaga Pendidikan pemerintah",
  ];

  DateTime selected = DateTime.now();
  DateTime selectedPengajuan = DateTime.now();
  String valueChoose;
  String valueMediaType;
  String valueKelompokPelanggan;
  bool visibleDataDiri = true;
  bool visibleAlamat = false;
  bool visibleDataPelengkap = false;
  bool visibleReview = false;
  bool pengaliranBBG = false;
  bool perubahanSegmen = true;

  String custName = '';
  String custGroup = '';
  String custID = '';
  String email = '';
  String phoneNumb = '';
  String statusLokasi;
  String jenisPemakianGas;

  List<Map<String, dynamic>> gasEquip = [];
  TextEditingController tempatLahirCtrl = new TextEditingController();
  TextEditingController nikCtrl = new TextEditingController();
  TextEditingController alamatCtrl = new TextEditingController();
  TextEditingController perumahanCtrl = new TextEditingController();
  TextEditingController rtCtrl = new TextEditingController();
  TextEditingController rwCtrl = new TextEditingController();
  TextEditingController kelurahanCtrl = new TextEditingController();
  TextEditingController kecamatanCtrl = new TextEditingController();
  TextEditingController kabupatenCtrl = new TextEditingController();
  TextEditingController provinsiCtrl = new TextEditingController();
  TextEditingController kodeposCtrl = new TextEditingController();
  TextEditingController locationCtrl = new TextEditingController();
  TextEditingController volumeMinCtrl = new TextEditingController();
  TextEditingController volumeMaxCtrl = new TextEditingController();
  TextEditingController jmlJamCtrl = new TextEditingController();
  TextEditingController jmlHariCtrl = new TextEditingController();
  TextEditingController nomorNpwpCtrl = new TextEditingController();
  TextEditingController dayaCtrl = new TextEditingController();
  TextEditingController pemakaianPerBulanCtrl = new TextEditingController();
  TextEditingController jamperHariCtrl = new TextEditingController();
  TextEditingController hariperMingguCtrl = new TextEditingController();
  TextEditingController alasanCtrl = new TextEditingController();
  TextEditingController ktpAddressCtrl = new TextEditingController();

  final storageCache = FlutterSecureStorage();
  ByteData _img = ByteData(0);
  final _sign = GlobalKey<SignatureState>();
  final _formKeyDataDiri = GlobalKey<FormState>();
  final _formKeyAlamat = GlobalKey<FormState>();
  final _formKeyPelengkapSegmen = GlobalKey<FormState>();

  String _fileName;
  Future _showDatePicker() async {
    dynamic selectedPicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
    setState(() {
      selected = selectedPicker;
    });
  }

  Future _showDatePickerPengajuan() async {
    dynamic selectedPicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
    setState(() {
      selectedPengajuan = selectedPicker;
    });
  }

  void initState() {
    super.initState();

    getDataCred();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF427CEF),
      appBar: AppBar(
        backgroundColor: Color(0xFF427CEF),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Pengajuan Amendemen Segmen Update',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 18, right: 18, top: 5),
            height: 80,
            color: Color(0xFF427CEF),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  visibleDataDiri == true
                      ? Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Text(
                                  '1',
                                  style: TextStyle(color: Color(0xFF427CEF)),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Data Diri',
                                style: TextStyle(color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SizedBox(
                                    width: 20,
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 2,
                                    )),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF8EB3FC),
                            child: Text(
                              '1',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                  visibleAlamat == true
                      ? Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Text(
                                  '2',
                                  style: TextStyle(color: Color(0xFF427CEF)),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Alamat ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SizedBox(
                                    width: 20,
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 2,
                                    )),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF8EB3FC),
                            child: Text(
                              '2',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                  visibleDataPelengkap == true
                      ? Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Text(
                                  '3',
                                  style: TextStyle(color: Color(0xFF427CEF)),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Data Pelengkap',
                                style: TextStyle(color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SizedBox(
                                    width: 20,
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 2,
                                    )),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF8EB3FC),
                            child: Text(
                              '3',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: visibleDataDiri,
            child: Form(
              key: _formKeyDataDiri,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 100),
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
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Customer ID',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        enabled: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: custID,
                          hintStyle: TextStyle(color: Colors.black),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Jenis Pengajuan',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 75,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: pengaliranBBG == true
                                      ? Color(0xFF427CEF)
                                      : Colors.white,
                                  border: Border.all(
                                    color: pengaliranBBG == true
                                        ? Color(0xFF427CEF)
                                        : Color(0xFFC3C3C3),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Pengalihan BBG',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: pengaliranBBG == true
                                            ? Colors.white
                                            : Color(0xFFC3C3C3),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  pengaliranBBG = false;
                                  perubahanSegmen = true;
                                });
                              },
                              child: Container(
                                height: 75,
                                margin: EdgeInsets.only(left: 15),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: perubahanSegmen == true
                                      ? Color(0xFF427CEF)
                                      : Colors.white,
                                  border: Border.all(
                                    color: perubahanSegmen == true
                                        ? Color(0xFF427CEF)
                                        : Color(0xFFC3C3C3),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Perubahan Segmen / Kelompok Pelanggan',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: perubahanSegmen == true
                                            ? Colors.white
                                            : Color(0xFFC3C3C3),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 16, right: 16),
                      child: Text(
                        'Nama Pelanggan',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            decoration: BoxDecoration(
                                color: Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              enabled: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: '$custName',
                                hintStyle: TextStyle(color: Colors.black),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Color(0xFFF4F4F4), width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Color(0xFFF4F4F4), width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          margin: EdgeInsets.only(top: 10, right: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Color(0xFFD3D3D3), width: 1)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 8),
                            child: DropdownButton(
                              hint: Text('Jenis Kelamin',
                                  style: TextStyle(
                                      color: Color(0xFF455055),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal)),
                              dropdownColor: Colors.white,
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Color(0xFF455055)),
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              value: valueChoose,
                              onChanged: (newValue) {
                                setState(() {
                                  valueChoose = newValue;
                                });
                              },
                              items: listGenderType.map((valueItem) {
                                return DropdownMenuItem(
                                    value: valueItem, child: Text(valueItem));
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Tempat Lahir',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: tempatLahirCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Jakarta',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Tanggal Lahir',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 55,
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      padding: EdgeInsets.only(left: 16, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFC3C3C3))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(DateFormat('d MMM yyy').format(
                              selected != null ? selected : DateTime.now())),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon: Icon(Icons.calendar_today_outlined),
                                  onPressed: () {
                                    _showDatePicker();
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'NIK (KTP/SIM)',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: nikCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '1285-1258835-20004',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        enabled: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: email,
                          hintStyle: TextStyle(color: Colors.black),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Nomer Handphone',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, left: 16, right: 16, bottom: 45),
                      decoration: BoxDecoration(
                          color: Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        enabled: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixStyle: TextStyle(color: Color(0xFF828388)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          hintText: '+$phoneNumb',
                          hintStyle: TextStyle(color: Colors.black),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFEFEFEF),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 5),
                              child: Text(
                                'Kembali',
                                style: TextStyle(color: Color(0xFF828388)),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKeyDataDiri.currentState.validate() &&
                                    valueChoose != null) {
                                  setState(() {
                                    visibleDataDiri = false;
                                    visibleAlamat = true;
                                  });
                                } else if (valueChoose == null) {
                                  showToast('Jenis Kelamin belum dipilih');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF427CEF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 5),
                                child: Text('Selanjutnya'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: visibleAlamat,
            child: Form(
              key: _formKeyAlamat,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 100),
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
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Customer ID',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        enabled: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: custID,
                          hintStyle: TextStyle(color: Colors.black),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Alamat',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        controller: alamatCtrl,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Jakarta',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Perumahan / Apartment (optional)',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        controller: perumahanCtrl,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Perum Pertamina',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 65,
                          margin: EdgeInsets.only(top: 20, left: 16, right: 5),
                          child: Text(
                            'RT',
                            style: TextStyle(
                                color: Color(0xFF455055),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 65,
                          margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                          child: Text(
                            'RW',
                            style: TextStyle(
                                color: Color(0xFF455055),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          // width: 50,
                          margin: EdgeInsets.only(top: 20, left: 5, right: 16),
                          child: Text(
                            'Kelurahan',
                            style: TextStyle(
                                color: Color(0xFF455055),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 65,
                          margin: EdgeInsets.only(top: 10, left: 16, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xFFD3D3D3))),
                          child: TextFormField(
                            controller: rtCtrl,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Data tidak boleh kosong!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: '00',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 65,
                          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xFFD3D3D3))),
                          child: TextFormField(
                            controller: rwCtrl,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Data tidak boleh kosong!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: '00',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 5, right: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              controller: kelurahanCtrl,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Petukangan',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 20, left: 16, right: 5),
                            child: Text(
                              'Kecamatan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                            child: Text(
                              'Kabupaten',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              controller: kecamatanCtrl,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Pesanggrahan',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              controller: kabupatenCtrl,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Jakarta Selatan',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 20, left: 16, right: 5),
                            child: Text(
                              'Provinsi',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                          child: Text(
                            'Kode Pos',
                            style: TextStyle(
                                color: Color(0xFF455055),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              controller: provinsiCtrl,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'DKI Jakarta',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xFFD3D3D3))),
                          child: TextFormField(
                            controller: kodeposCtrl,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Data tidak boleh kosong!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: '00000',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Koordinat Lokasi',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        controller: locationCtrl,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.location_on_sharp,
                              color: Colors.black,
                              size: 28,
                            ),
                            onPressed: () {
                              _nextLokasiPesangan(context);
                            },
                          ),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Status di Lokasi Pelanggan',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 16, left: 16, bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Color(0xFFD3D3D3), width: 1)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 8),
                        child: DropdownButton(
                          hint: Text('Status di Lokasi Pelanggan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          dropdownColor: Colors.white,
                          icon: Icon(Icons.arrow_drop_down,
                              color: Color(0xFF455055)),
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(
                              color: Color(0xFF455055),
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                          value: statusLokasi,
                          onChanged: (newValue) {
                            setState(() {
                              statusLokasi = newValue;
                            });
                          },
                          items: listStatusKepemilikan.map((valueItem) {
                            return DropdownMenuItem(
                                value: valueItem, child: Text(valueItem));
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                visibleDataPelengkap = false;
                                visibleAlamat = false;
                                visibleDataDiri = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFEFEFEF),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 5),
                              child: Text(
                                'Kembali',
                                style: TextStyle(color: Color(0xFF828388)),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                print('STATUS LOKASI $statusLokasi');
                                if (_formKeyAlamat.currentState.validate() &&
                                    statusLokasi != null) {
                                  setState(() {
                                    visibleDataDiri = false;
                                    visibleAlamat = false;
                                    visibleDataPelengkap = true;
                                  });
                                } else if (statusLokasi == null) {
                                  showToast(
                                      'Status Lokasi Pelanggan Belum dipilih');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF427CEF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 5),
                                child: Text('Selanjutnya'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: visibleDataPelengkap,
            child: Form(
              key: _formKeyPelengkapSegmen,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 100),
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
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Customer ID',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        enabled: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: custID,
                          hintStyle: TextStyle(color: Colors.black),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xFFF4F4F4), width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Alamat Sesuai KTP',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: ktpAddressCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Jakarta',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Nomer NPWP',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: nomorNpwpCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '000000000',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Foto NPWP',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _fileName = null;
                              });
                            },
                            child: Text(
                              'Hapus',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Color(0xFF427CEF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 20, bottom: 10),
                      child: DottedBorder(
                        dashPattern: [3.1],
                        color: Color(0xFFD3D3D3),
                        strokeWidth: 1,
                        child: Container(
                          height: 60,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                _pickFiles('npwp');
                              },
                              child: _fileName != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        _fileName,
                                        style: TextStyle(
                                            color: Color(0xFF427CEF),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Text(
                                      'Unggah Foto NPWP',
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                      child: Center(
                          child: Text(
                        'NPWP dan foto NPWP (tidak mandatory)',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 16, right: 16),
                      child: Text(
                        'Bulan Berlaku yang Diajukan',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 55,
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      padding: EdgeInsets.only(left: 16, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFC3C3C3))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(DateFormat('d MMM yyy')
                              .format(selectedPengajuan)),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon: Icon(Icons.calendar_today_outlined),
                                  onPressed: () {
                                    _showDatePickerPengajuan();
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Jenis Pemakaian Gas',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 16, left: 16, bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Color(0xFFD3D3D3), width: 1)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 8),
                        child: DropdownButton(
                          hint: Text('Jenis Pemakaian Gas',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          dropdownColor: Colors.white,
                          icon: Icon(Icons.arrow_drop_down,
                              color: Color(0xFF455055)),
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(
                              color: Color(0xFF455055),
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                          value: jenisPemakianGas,
                          onChanged: (newValue) {
                            setState(() {
                              jenisPemakianGas = newValue;
                            });
                          },
                          items: listJenisPemakaianGas.map((valueItem) {
                            return DropdownMenuItem(
                                value: valueItem, child: Text(valueItem));
                          }).toList(),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 16, right: 5),
                            child: Text(
                              'Volume Min./Bulan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              'Volume Max./Bulan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              controller: volumeMinCtrl,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: '0',
                                suffixIcon: Text("\m3    "),
                                suffixIconConstraints:
                                    BoxConstraints(minWidth: 5, minHeight: 5),
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 5, right: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              controller: volumeMaxCtrl,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: '0',
                                suffixIcon: Text("\m3    "),
                                suffixIconConstraints:
                                    BoxConstraints(minWidth: 5, minHeight: 5),
                                isDense: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Pemakaian Rata-Rata/Bulan',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: TextFormField(
                        controller: pemakaianPerBulanCtrl,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '0',
                          suffixIcon: Text("\m3    "),
                          suffixIconConstraints:
                              BoxConstraints(minWidth: 5, minHeight: 5),
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 40, left: 16, right: 16, bottom: 20),
                      child: Text(
                        'Daftar Peralatan Gas dan Jumlah Unit',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: gasEquip.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 18, right: 18, top: 5, bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(gasEquip[i]['Name'])),
                                  Container(
                                    width: 60,
                                    // height: 40,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          gasEquip[i]['Value'] =
                                              int.parse(value);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                            gasEquip[i]['Value'].toString(),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            8.0, 5.0, 8.0, 5.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete_outline,
                                          color: Color(0xFFFF0000)),
                                      onPressed: () {
                                        setState(() {
                                          gasEquip.removeWhere((item) =>
                                              item['Name'] ==
                                              gasEquip[i]['Name']);
                                        });
                                      }),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        addGasUsage();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 18, right: 18, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              '+   ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF427CEF),
                              ),
                            ),
                            Text(
                              'Tambah Peralatan',
                              style: TextStyle(
                                color: Color(0xFF427CEF),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18, right: 18, top: 10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 18, right: 18, top: 44, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                              width: 150,
                              child: Text(
                                'Waktu Operasional',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF455055),
                                    fontWeight: FontWeight.bold),
                              )),
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 16, right: 5),
                            child: Text(
                              'Jumlah Jam/Hari',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 16),
                            child: Text(
                              'Jumlah Hari/Minggu',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              controller: jamperHariCtrl,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: '0',
                                suffixIcon: Text("\Jam    "),
                                suffixIconConstraints:
                                    BoxConstraints(minWidth: 5, minHeight: 5),
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 5, right: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              controller: hariperMingguCtrl,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: '0',
                                suffixIcon: Text("\Hari    "),
                                suffixIconConstraints:
                                    BoxConstraints(minWidth: 5, minHeight: 5),
                                isDense: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Kelompok Pelanggan',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 16, left: 16, bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Color(0xFFD3D3D3), width: 1)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 8),
                        child: DropdownButton(
                          hint: Text('Kelompok Pelangaan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          dropdownColor: Colors.white,
                          icon: Icon(Icons.arrow_drop_down,
                              color: Color(0xFF455055)),
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(
                              color: Color(0xFF455055),
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                          value: valueKelompokPelanggan,
                          onChanged: (newValue) {
                            setState(() {
                              valueKelompokPelanggan = newValue;
                            });
                          },
                          items: listKelompokPelanggan.map((valueItem) {
                            return DropdownMenuItem(
                                value: valueItem, child: Text(valueItem));
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Alasan',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                      child: TextFormField(
                        controller: alasanCtrl,
                        keyboardType: TextInputType.text,
                        minLines: 5,
                        maxLines: 5,
                        maxLength: 2000,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFC3C3C3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            hintText: 'Kronologi kejadian'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Tanda Tangan Anda',
                        style: TextStyle(
                            color: Color(0xFF455055),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 200,
                      margin: EdgeInsets.only(
                          top: 20, left: 16, right: 16, bottom: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Signature(
                          color: Colors.black,
                          key: _sign,
                          onSign: () {
                            final sign = _sign.currentState;
                            debugPrint(
                                '${sign.points.length} points in the signature');
                          },
                          strokeWidth: 3.0,
                        ),
                      ),
                      color: Colors.black12,
                    ),
                    // _img.buffer.lengthInBytes == 0
                    //     ? Container()
                    //     : LimitedBox(
                    //         maxHeight: 200.0,
                    //         child:
                    //             Image.memory(_img.buffer.asUint8List())),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 16, right: 16, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                              color: Color(0xFFC3C3C3),
                              onPressed: () {
                                final sign = _sign.currentState;
                                sign.clear();
                                setState(() {
                                  _img = ByteData(0);
                                });
                                debugPrint("cleared");
                              },
                              child: Text("Hapus")),
                          SizedBox(width: 10),
                          // _img.buffer.lengthInBytes == 0
                          //     ? MaterialButton(
                          //         color: Colors.green,
                          //         textColor: Colors.white,
                          //         onPressed: () async {
                          //           final sign = _sign.currentState;
                          //           //retrieve image data, do whatever you want with it (send to server, save locally...)
                          //           final image = await sign.getData();
                          //           var data = await image.toByteData(
                          //               format: ui.ImageByteFormat.png);
                          //           sign.clear();
                          //           final encoded = base64.encode(
                          //               data.buffer.asUint8List());
                          //           setState(() {
                          //             _img = data;
                          //           });
                          //           debugPrint("onPressed " + encoded);
                          //         },
                          //         child: Text("Konfirmasi"))
                          //     : Container(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                      child: Text(
                        'Bersama ini menyatakan bertanggung jawab terhadap kebenaran data tersebut dan bersedia memenuhi segala persyaratan & kewajiban yang telah ditetapkan oleh PT Perusahaan Gas Negara Tbk. Pastikan Anda telah melunasi segala kewajiban, denda, dan biaya lainnya (jika ada).',
                        style: TextStyle(
                          height: 1.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 45),
                      child: Text(
                        'Anda akan dikenakan biaya administrasi amendemen sebesar Rp50.000.',
                        style: TextStyle(
                          height: 1.5,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                visibleDataPelengkap = false;

                                visibleDataDiri = false;
                                visibleAlamat = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFEFEFEF),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 5),
                              child: Text(
                                'Kembali',
                                style: TextStyle(color: Color(0xFF828388)),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final sign = _sign.currentState;
                                if (_formKeyPelengkapSegmen.currentState
                                        .validate() &&
                                    valueKelompokPelanggan != null &&
                                    sign.hasPoints) {
                                  addFormAlert('Segmen');
                                } else if (!sign.hasPoints) {
                                  showToast('Tanda Tangan harus ada !');
                                } else if (valueKelompokPelanggan = null) {
                                  showToast('Layanan Teknis harus ada !');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF427CEF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 5),
                                child: Text('Update Pengajuan'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> addGasUsage() {
    Map<String, dynamic> addNewEquip;
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
      title: "Tambah Peralatan Gas",
      content: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            children: [
              Text('Nama '),
              Expanded(
                child: Container(
                  // width: 100,
                  // height: 40,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        addNewEquip = {"Name": value, "Value": 0};
                      });
                    },
                    decoration: InputDecoration(
                      hintText: '',
                      contentPadding: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
      buttons: [
        DialogButton(
          width: 130,
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.grey,
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          width: 130,
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              gasEquip.add(addNewEquip);
            });
          },
          color: Colors.green,
          child: Text(
            "Tambah",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }

  Future<bool> addFormAlert(String status) {
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
            "Anda yakin ingin melakukan Perubahan Segmen / Kelompok Pelanggan? ",
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
          color: Colors.grey,
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          width: 130,
          onPressed: () async {
            submitForm();
          },
          color: Colors.green,
          child: Text(
            "Kirim",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }

  void getDataCred() async {
    String custNameString = await storageCache.read(key: 'customer_id');
    String custIDString = await storageCache.read(key: 'user_name_cust');
    String emailString = await storageCache.read(key: 'user_email');
    String userPhoneString = await storageCache.read(key: 'user_mobile_otp');
    String custGroupString = await storageCache.read(key: 'customer_groupId');

    setState(() {
      custID = custNameString;
      custName = custIDString;
      email = emailString;
      phoneNumb = userPhoneString;
      custGroup = custGroupString;
      if (custGroupString == '3') {
        custGroup = 'RT';
      } else if (custGroupString == '1') {
        custGroup = 'KI';
      } else if (custGroupString == '2') {
        custGroup = 'Bulk';
      }
    });
  }

  void _nextLokasiPesangan(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapPoint()));
    print('INI RESULT LAT LANG $result');
    setState(() {
      locationCtrl.text = result;
    });
  }

  void getData() async {
    print('ID Nya ${widget.id}');
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var response = await http.get(
        '${UrlCons.mainDevUrl}customer-service/change-segment/${widget.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang,
        });
    print('GET DETAIL PEMASANGAN KEMBALI ${response.body}');
    DetailData detailData = DetailData.fromJson(json.decode(response.body));
    // print('IMAGENYA  ${detailBerhetiBerlanggananData.sign}');
    // var splitString = detailBerhetiBerlanggananData.sign.split(',');
    setState(() {
      detailDatas = detailData;
      detailData.custEquip.datasEquip.forEach((e) {
        gasEquip.add({"Name": e.name, "Value": e.val});
      });
      jenisPemakianGas = detailData.jenisPemakianGas;
      // _byteImage = base64.decode(splitString[1]);
    });
    nikCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.nik))
        .value;
    tempatLahirCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.bPlace))
        .value;
    valueChoose = detailData.gender;
    selected = DateTime.parse(detailData.bDate).toLocal();
    alamatCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.address))
        .value;
    perumahanCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.street))
        .value;
    rtCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.rt))
        .value;
    rwCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.rw))
        .value;
    kelurahanCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.kelurahan))
        .value;
    kecamatanCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.kecamatan))
        .value;
    // kabupatenCtrl.value = new TextEditingController.fromValue(
    //         new TextEditingValue(text: detailBerhetiBerlangganan.kabupaten))
    // .value;
    provinsiCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.prov))
        .value;
    kodeposCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.postalCode))
        .value;
    locationCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: '${detailData.lat},${detailData.long}'))
        .value;
    statusLokasi = detailData.locStat;
    selectedPengajuan = DateTime.parse(detailData.subDate).toLocal();
    alasanCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.reason))
        .value;
    ktpAddressCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.ktpAddress))
        .value;
    nomorNpwpCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.npwpNumb))
        .value;
    valueKelompokPelanggan = detailData.custSubGroup;
    volumeMinCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.minMonth.toString()))
        .value;
    volumeMaxCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.maxMonth.toString()))
        .value;
    pemakaianPerBulanCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.avgMonth.toString()))
        .value;
    jamperHariCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.hourDay.toString()))
        .value;
    hariperMingguCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.dayWeek.toString()))
        .value;
    kabupatenCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.kabupaten.toString()))
        .value;
  }

  void submitForm() async {
    final sign = _sign.currentState;
    final image = await sign.getData();
    var data = await image.toByteData(format: ui.ImageByteFormat.png);
    sign.clear();
    final encoded = base64.encode(data.buffer.asUint8List());
    setState(() {
      _img = data;
    });
    var location = locationCtrl.text.split(',');
    var lat = location[0].trim();
    var long = location[1].trim();
    print('INI LAT $lat');
    print('INI LONG $long');
    print('GAMBARNYA  data:image/png;base64,$encoded} ');
    String accessToken = await storageCache.read(key: 'access_token');
    var body = json.encode({
      "customer_id": custID,
      "customer_name": custName,
      "gender": valueChoose,
      "birth_place": tempatLahirCtrl.text,
      "birth_date": DateFormat('yyy-MM-dd').format(selected),
      "id_card_number": nikCtrl.text,
      "email": email,
      "phone_number": phoneNumb,
      "address": alamatCtrl.text,
      "street": perumahanCtrl.text,
      "rt": rwCtrl.text,
      "rw": rtCtrl.text,
      "kelurahan": kelurahanCtrl.text,
      "kecamatan": kecamatanCtrl.text,
      "province": provinsiCtrl.text,
      "postal_code": kodeposCtrl.text,
      "kota_kabupaten": kabupatenCtrl.text,
      "longitude": long,
      "latitude": lat,
      "person_in_location_status": statusLokasi,
      "info_media": valueMediaType,
      "customer_group": custGroup,
      "submission_date": DateFormat('yyy-MM-dd').format(selectedPengajuan),
      "submission_customer_group": valueKelompokPelanggan,
      "minimum_volume_month": int.parse(volumeMinCtrl.text),
      "maximum_volume_month": int.parse(volumeMaxCtrl.text),
      "average_volume_month": int.parse(pemakaianPerBulanCtrl.text),
      "operational_hour_day": int.parse(jamperHariCtrl.text),
      "operational_day_week": int.parse(hariperMingguCtrl.text),
      "customer_equipments": gasEquip,
      "submission_gas_usage": jenisPemakianGas,
      "reason": alasanCtrl.text,
      "npwp_file": "url String",
      "npwp_number": nomorNpwpCtrl.text,
      "ktp_address": ktpAddressCtrl.text,
      "customer_signature": 'data:image/png;base64,$encoded',
    });
    print('SEGMEN BODY POST $body');
    var response = await http.put(
        '${UrlCons.mainProdUrl}customer-service/change-segment/$id',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);
    print('SEGMEN EQUIP LIST ${json.encode(gasEquip)}');
    print('INI HASIL POST CREATE SEGMEN ${response.body}');
    Create create = Create.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      successAlert(create.dataCreate.message);
    } else {
      Navigator.pop(context);
      showToast(create.dataCreate.message);
    }
  }

  Future<List<DataProvinces>> getOwnerTypes() async {
    var responseTokenBarrer =
        await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'client_credentials'
    });
    AuthSalesRegit _auth =
        AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

    var responseOwnerType =
        await http.get('${UrlCons.prodRelyonUrl}v1/location-status', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_auth.accessToken}'
    });
    GetProvinces getProvinces;
    getProvinces = GetProvinces.fromJson(json.decode(responseOwnerType.body));
    var dataOwnerTypes = getProvinces.data;
    return dataOwnerTypes;
  }

  void _pickFiles(String status) async {
    _resetState();
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      if (status == 'rekListrik') {
        // setState(() {
        //   _fileNameRekListrik = result.names.single;
        //   print('NAMA FILE : $_fileName');
        // });
      } else {
        setState(() {
          _fileName = result.names.single;
          print('NAMA FILE : $_fileName');
        });
      }
    } else {
      // User canceled the picker
    }
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _fileName = null;
    });
  }

  Future<bool> successAlert(String message) {
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
            message,
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
            Navigator.pop(context);
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
}
