import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:pgn_mobile/models/form_customer_cred_model.dart';
import 'package:pgn_mobile/models/pengajuan_amandemen_model.dart';
import 'package:pgn_mobile/models/provinces_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;

import 'package:pgn_mobile/screens/otp/otp.dart';
import 'package:pgn_mobile/screens/register/widgets/map_point.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PengajuanAmandemenForm extends StatefulWidget {
  @override
  _PengajuanAmandemenFormState createState() => _PengajuanAmandemenFormState();
}

class _PengajuanAmandemenFormState extends State<PengajuanAmandemenForm> {
  var splitString;
  Uint8List imageNpwp;
  Uint8List imageRek;
  Uint8List imageKTP;
  String dataListrikWat;
  DataProvinces dataListrikSelected;
  List listGenderType = [
    "Laki-Laki",
    "Perempuan",
  ];
  List listMediaType = [
    "Email",
    "WhatsApp",
    "SMS (Dikenakan biaya)",
  ];
  List listStatusKepemilikan = [
    "Pemilik",
    "Penyewa",
    "Lain-lain",
  ];

  List listKelompokPelanggan = [
    "Rumah Tangga",
    "Pelanggan Kecil",
    "Industri dan Komersial",
    "Power Plant"
  ];

  List listJenisPemakaianGas = [
    "Kebutuhan sendiri/RT",
    "Kebutuhan usaha/komersial",
    "Puskesmas, RS pemerintah, Lembaga sosial, Lembaga Pendidikan pemerintah",
  ];

  DateTime selected = DateTime.now();
  DateTime selectedPengajuan = DateTime.now();
  DateTime selectedPenerimaTglLahir = DateTime.now();
  String valueChoose;
  String valueMediaType;
  String valueKelompokPelanggan;
  String valuePenerimaGender;
  String valuePenerimaMediaType;
  DateTime selectedPenerimaPengajuan = DateTime.now();
  String penerimaDataListrik;

  bool visibleDataDiri = true;
  bool visibleAlamat = false;
  bool visibleDataPelengkap = false;
  bool visibleReview = false;
  bool pengaliranBBG = true;
  bool perubahanSegmen = false;

  String custName = '';
  String custGroup = '';
  String custID = '';
  String email = '';
  String phoneNumb = '';
  String statusLokasi;
  String jenisPemakianGas;
  File imgNPWP;
  File imgRek;
  File imgKTP;
  File penerimaImgRek;
  File penerimaImgKTP;

  List<Map<String, dynamic>> gasEquip = [
    {"Name": "Kompor 1 Tungku", "Value": 0},
    {"Name": "Kompor 2 Tungku", "Value": 0},
    {"Name": "Kompor 4 Tungku", "Value": 0},
    {"Name": "Oven", "Value": 0},
    {"Name": "Water Heater", "Value": 0},
    {"Name": "Dryer Pakaian", "Value": 0},
    {"Name": "Rice Cooker", "Value": 0}
  ];
  TextEditingController tempatLahirCtrl = new TextEditingController();
  TextEditingController nikCtrl = new TextEditingController();
  TextEditingController phoneNumbCtrl = new TextEditingController();
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

  //penerima
  TextEditingController penerimaTempatLahirCtrl = new TextEditingController();
  TextEditingController penerimaNamaCtrl = new TextEditingController();
  TextEditingController penerimaTglLahirCtrl = new TextEditingController();
  TextEditingController penerimaNikCtrl = new TextEditingController();
  TextEditingController penerimaHpCtrl = new TextEditingController();
  TextEditingController penerimaEmailCtrl = new TextEditingController();
  TextEditingController peneriamaAlasanCtrl = new TextEditingController();
  TextEditingController penerimaAlamatCtrl = new TextEditingController();

  final storageCache = FlutterSecureStorage();
  ByteData _img = ByteData(0);
  final _sign = GlobalKey<SignatureState>();
  final _penerimaSign = GlobalKey<SignatureState>();
  final _formKeyDataDiri = GlobalKey<FormState>();
  final _formKeyAlamat = GlobalKey<FormState>();
  final _formKeyPelengkapBBG = GlobalKey<FormState>();
  final _formKeyPelengkapSegmen = GlobalKey<FormState>();

  String _fileName;
  String _fileNameRekListrik;
  String _fileNameKtp;
  String _penerimaFileNameRekListrik;
  String _penerimaFileNameKtp;
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

  Future _showDatePickerPenerimaTglLahir() async {
    dynamic selectedPicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
    setState(() {
      selectedPenerimaTglLahir = selectedPicker;
    });
  }

  Future _showDatePickerPenerima() async {
    dynamic selectedPicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
    setState(() {
      selectedPenerimaPengajuan = selectedPicker;
    });
  }

  void initState() {
    super.initState();

    getDataCred();
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
          'Pengajuan Amendemen',
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
                              onTap: () {
                                setState(() {
                                  pengaliranBBG = true;
                                  perubahanSegmen = false;
                                });
                              },
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '1285125883520004',
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
                        'Nomor Handphone',
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
                        enabled: true,
                        keyboardType: TextInputType.phone,
                        controller: phoneNumbCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixStyle: TextStyle(color: Color(0xFF828388)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          hintText: '$phoneNumb',
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
                                //print('STATUS LOKASI $statusLokasi');
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
          pengaliranBBG == true
              ? Visibility(
                  visible: visibleDataPelengkap,
                  child: Form(
                    key: _formKeyPelengkapBBG,
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Customer ID',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
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

                          // Padding(
                          //   padding:
                          //       EdgeInsets.only(top: 20, left: 16, right: 16),
                          //   child: Text(
                          //     'Segmen/Kelompok Pelanggan',
                          //     style: TextStyle(
                          //         color: Color(0xFF455055),
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          // Container(
                          //   margin:
                          //       EdgeInsets.only(top: 10, left: 16, right: 16),
                          //   decoration: BoxDecoration(
                          //       color: Color(0xFFF4F4F4),
                          //       borderRadius: BorderRadius.circular(5.0),
                          //       border: Border.all(color: Color(0xFFD3D3D3))),
                          //   child: TextFormField(
                          //     enabled: false,
                          //     keyboardType: TextInputType.text,
                          //     decoration: InputDecoration(
                          //       hintText: custGroup,
                          //       hintStyle: TextStyle(color: Colors.black),
                          //       contentPadding: new EdgeInsets.symmetric(
                          //           vertical: 12.0, horizontal: 15.0),
                          //       disabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide(
                          //             color: Color(0xFFF4F4F4), width: 2.0),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide(
                          //             color: Colors.blue, width: 2.0),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide(
                          //             color: Color(0xFFF4F4F4), width: 2.0),
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Daya Listrik',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 16, right: 16, bottom: 20),
                            child: DropdownSearch<DataProvinces>(
                              mode: Mode.MENU,
                              onFind: (String filter) =>
                                  getPenggunaanListrik(context),
                              itemAsString: (DataProvinces u) =>
                                  u.value.toString(),
                              onChanged: (DataProvinces data) {
                                // setState(() {
                                dataListrikWat = data.value.toString();
                                dataListrikSelected = data;
                                // });

                                //print(data);
                              },
                              label: '',
                              hint: 'Pilih Daya Listrik',
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding: new EdgeInsets.only(
                                    left: 15, right: 15, top: 2, bottom: 2),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFC3C3C3)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFC3C3C3)),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFC3C3C3)),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Bukti Rekening Listrik',
                                    style: TextStyle(
                                        color: Color(0xFF455055),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _fileNameRekListrik = null;
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
                                      _pickFiles('rekListrik');
                                    },
                                    child: _fileNameRekListrik != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              _fileNameRekListrik,
                                              style: TextStyle(
                                                  color: Color(0xFF427CEF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Text(
                                            'Unggah Bukti Rekening Listrik',
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Alamat Sesuai KTP',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Foto KTP',
                                    style: TextStyle(
                                        color: Color(0xFF455055),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _fileNameKtp = null;
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
                                      _pickFiles('KTP');
                                    },
                                    child: _fileNameKtp != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              _fileNameKtp,
                                              style: TextStyle(
                                                  color: Color(0xFF427CEF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Text(
                                            'Unggah Foto KTP',
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Nomor NPWP',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Pilihan Media Informasi',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, right: 16, left: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color(0xFFD3D3D3), width: 1)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 8),
                              child: DropdownButton(
                                hint: Text('Media Informasi',
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
                                value: valueMediaType,
                                onChanged: (newValue) {
                                  setState(() {
                                    valueMediaType = newValue;
                                  });
                                  //print('INI MEDIA TYPE NYA $valueMediaType');
                                },
                                items: listMediaType.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList(),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Bulan Berlaku yang Diajukan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 55,
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            padding: EdgeInsets.only(left: 16, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFC3C3C3))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(selectedPengajuan != null
                                    ? DateFormat('d MMM yyy')
                                        .format(selectedPengajuan)
                                    : DateFormat('d MMM yyy')
                                        .format(DateTime.now())),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon:
                                            Icon(Icons.calendar_today_outlined),
                                        onPressed: () {
                                          _showDatePickerPengajuan();
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Alasan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
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
                                  hintText: ' '),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Identitas Penerima Pengalihan BBG',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Nama Lengkap',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: penerimaNamaCtrl,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Nama Lengkap Penerima',
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Jenis Kelamin',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, right: 16, left: 16),
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
                                value: valuePenerimaGender,
                                onChanged: (newValue) {
                                  setState(() {
                                    valuePenerimaGender = newValue;
                                  });
                                },
                                items: listGenderType.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList(),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'NIK (KTP/SIM)',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: penerimaNikCtrl,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(16),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: '1285125883520004',
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Alamat Sesuai KTP',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: penerimaAlamatCtrl,
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Tempat Lahir',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: penerimaTempatLahirCtrl,
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Tanggal Lahir',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 55,
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            padding: EdgeInsets.only(left: 16, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFC3C3C3))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(DateFormat('d MMM yyy').format(
                                    selectedPenerimaTglLahir != null
                                        ? selectedPenerimaTglLahir
                                        : DateTime.now())),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon:
                                            Icon(Icons.calendar_today_outlined),
                                        onPressed: () {
                                          _showDatePickerPenerimaTglLahir();
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'No HP/WA',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            decoration: BoxDecoration(
                                color: Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              enabled: true,
                              keyboardType: TextInputType.phone,
                              controller: penerimaHpCtrl,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixStyle: TextStyle(color: Colors.white),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                hintText: '$phoneNumb',
                                hintStyle: TextStyle(color: Colors.black),
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFD3D3D3))),
                            child: TextFormField(
                              controller: penerimaEmailCtrl,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data tidak boleh kosong!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Daya Listrik',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 16, right: 16, bottom: 20),
                            child: DropdownSearch<DataProvinces>(
                              mode: Mode.MENU,
                              onFind: (String filter) =>
                                  getPenggunaanListrik(context),
                              itemAsString: (DataProvinces u) =>
                                  u.value.toString(),
                              onChanged: (DataProvinces data) {
                                // setState(() {
                                penerimaDataListrik = data.value.toString();
                                dataListrikSelected = data;
                                // });

                                //print(data);
                              },
                              label: '',
                              hint: 'Pilih Daya Listrik',
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding: new EdgeInsets.only(
                                    left: 15, right: 15, top: 2, bottom: 2),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFC3C3C3)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFC3C3C3)),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFC3C3C3)),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Bukti Rekening Listrik',
                                    style: TextStyle(
                                        color: Color(0xFF455055),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _penerimaFileNameRekListrik = null;
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
                                      _pickPenerimaFiles('rekListrik');
                                    },
                                    child: _penerimaFileNameRekListrik != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              _penerimaFileNameRekListrik,
                                              style: TextStyle(
                                                  color: Color(0xFF427CEF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Text(
                                            'Unggah Bukti Rekening Listrik',
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Foto KTP',
                                    style: TextStyle(
                                        color: Color(0xFF455055),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _penerimaFileNameKtp = null;
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
                                      _pickPenerimaFiles('KTP');
                                    },
                                    child: _penerimaFileNameKtp != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              _penerimaFileNameKtp,
                                              style: TextStyle(
                                                  color: Color(0xFF427CEF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Text(
                                            'Unggah Foto KTP',
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
                          Container(
                            margin:
                                EdgeInsets.only(top: 20, right: 16, left: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color(0xFFD3D3D3), width: 1)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 8),
                              child: DropdownButton(
                                hint: Text('Media Informasi',
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
                                value: valuePenerimaMediaType,
                                onChanged: (newValue) {
                                  setState(() {
                                    valuePenerimaMediaType = newValue;
                                  });
                                  //print('INI MEDIA TYPE NYA $valueMediaType');
                                },
                                items: listMediaType.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList(),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Bulan Berlaku yang Diajukan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 55,
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            padding: EdgeInsets.only(left: 16, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFC3C3C3))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(selectedPenerimaPengajuan != null
                                    ? DateFormat('d MMM yyy')
                                        .format(selectedPenerimaPengajuan)
                                    : DateFormat('d MMM yyy')
                                        .format(DateTime.now())),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon:
                                            Icon(Icons.calendar_today_outlined),
                                        onPressed: () {
                                          _showDatePickerPenerima();
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Alasan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            child: TextFormField(
                              controller: penerimaAlamatCtrl,
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
                                  hintText: ' '),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'TTD Pelanggan Lama',
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
                                        dataListrikWat = dataListrikWat;
                                        _img = ByteData(0);
                                      });
                                      debugPrint("cleared");
                                    },
                                    child: Text("Hapus")),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'TTD Penerima Pengalihan BBG',
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
                                key: _penerimaSign,
                                onSign: () {
                                  final sign = _penerimaSign.currentState;
                                  debugPrint(
                                      '${sign.points.length} points in the signature');
                                },
                                strokeWidth: 3.0,
                              ),
                            ),
                            color: Colors.black12,
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 16, right: 16, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                    color: Color(0xFFC3C3C3),
                                    onPressed: () {
                                      final sign = _penerimaSign.currentState;
                                      sign.clear();
                                      setState(() {
                                        dataListrikWat = dataListrikWat;
                                        _img = ByteData(0);
                                      });
                                      debugPrint("cleared");
                                    },
                                    child: Text("Hapus")),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 20),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 20),
                            child: Text(
                              'Bersama ini menyatakan bertanggung jawab terhadap kebenaran data tersebut dan bersedia memenuhi segala persyaratan & kewajiban yang telah ditetapkan oleh PT Perusahaan Gas Negara Tbk. Pastikan Anda telah melunasi segala kewajiban, denda, dan biaya lainnya (jika ada).',
                              style: TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 45),
                            child: Text(
                              'Anda akan dikenakan biaya administrasi amendemen sebesar Rp50.000.',
                              style: TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 16, right: 16, bottom: 20),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 5),
                                    child: Text(
                                      'Kembali',
                                      style:
                                          TextStyle(color: Color(0xFF828388)),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final sign = _sign.currentState;
                                      if (_formKeyPelengkapBBG.currentState
                                              .validate() &&
                                          sign.hasPoints &&
                                          valuePenerimaMediaType != null &&
                                          dataListrikWat != null) {
                                        addFormAlert('BBG');
                                      } else if (!sign.hasPoints) {
                                        showToast('Tanda Tangan harus ada !');
                                      } else if (valuePenerimaMediaType ==
                                          null) {
                                        showToast(
                                            'Media Informasi harus ada !');
                                      } else if (dataListrikWat == null) {
                                        showToast(
                                            'Daya Listrik harus di isi !');
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
                                      child: Text('Kirim Pengajuan'),
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
                )
              : Visibility(
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Customer ID',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Alamat Sesuai KTP',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Foto KTP',
                                    style: TextStyle(
                                        color: Color(0xFF455055),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _fileNameKtp = null;
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
                                      _pickFiles('KTP');
                                    },
                                    child: _fileNameKtp != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              _fileNameKtp,
                                              style: TextStyle(
                                                  color: Color(0xFF427CEF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Text(
                                            'Unggah Foto KTP',
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Nomor NPWP',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
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
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Bulan Berlaku yang Diajukan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 55,
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
                            padding: EdgeInsets.only(left: 16, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFC3C3C3))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(selectedPengajuan != null
                                    ? DateFormat('d MMM yyy')
                                        .format(selectedPengajuan)
                                    : DateFormat('d MMM yyy')
                                        .format(DateTime.now())),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon:
                                            Icon(Icons.calendar_today_outlined),
                                        onPressed: () {
                                          _showDatePickerPengajuan();
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
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
                                border: Border.all(
                                    color: Color(0xFFD3D3D3), width: 1)),
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
                                  margin: EdgeInsets.only(
                                      top: 10, left: 16, right: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFFD3D3D3))),
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
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 5, minHeight: 5),
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
                                  margin: EdgeInsets.only(
                                      top: 10, left: 5, right: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFFD3D3D3))),
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
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 5, minHeight: 5),
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Pemakaian Rata-Rata/Bulan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
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
                                        Expanded(
                                            child: Text(gasEquip[i]['Name'])),
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
                                              hintText: gasEquip[i]['Value']
                                                  .toString(),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
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
                                        i >= 7
                                            ? IconButton(
                                                icon: Icon(Icons.delete_outline,
                                                    color: Color(0xFFFF0000)),
                                                onPressed: () {
                                                  setState(() {
                                                    gasEquip.removeWhere(
                                                        (item) =>
                                                            item['Name'] ==
                                                            gasEquip[i]
                                                                ['Name']);
                                                  });
                                                })
                                            : SizedBox(width: 50),
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
                            padding:
                                EdgeInsets.only(left: 18, right: 18, top: 10),
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
                                  margin: EdgeInsets.only(
                                      top: 10, left: 16, right: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFFD3D3D3))),
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
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 5, minHeight: 5),
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
                                  margin: EdgeInsets.only(
                                      top: 10, left: 5, right: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border:
                                          Border.all(color: Color(0xFFD3D3D3))),
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
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 5, minHeight: 5),
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Segmen/Kelompok Pelanggan',
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
                                border: Border.all(
                                    color: Color(0xFFD3D3D3), width: 1)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 8),
                              child: DropdownButton(
                                hint: Text('Segmen/Kelompok Pelangaan',
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
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
                            child: Text(
                              'Alasan',
                              style: TextStyle(
                                  color: Color(0xFF455055),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 16, right: 16),
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
                                  hintText: ' '),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 16, right: 16),
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
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 20),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 20),
                            child: Text(
                              'Bersama ini menyatakan bertanggung jawab terhadap kebenaran data tersebut dan bersedia memenuhi segala persyaratan & kewajiban yang telah ditetapkan oleh PT Perusahaan Gas Negara Tbk. Pastikan Anda telah melunasi segala kewajiban, denda, dan biaya lainnya (jika ada).',
                              style: TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 45),
                            child: Text(
                              'Anda akan dikenakan biaya administrasi amendemen sebesar Rp50.000.',
                              style: TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 16, right: 16, bottom: 20),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 5),
                                    child: Text(
                                      'Kembali',
                                      style:
                                          TextStyle(color: Color(0xFF828388)),
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
                                      } else if (valueKelompokPelanggan =
                                          null) {
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
        ],
      ),
    );
  }

  Future<List<DataProvinces>> getPenggunaanListrik(BuildContext context) async {
    var responseTokenBarrer =
        await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'client_credentials'
    });
    AuthSalesRegit _auth =
        AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

    var responseProvinces = await http
        .get('${UrlCons.prodRelyonUrl}v1/electrical-powers', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_auth.accessToken}'
    });
    GetProvinces getDayaListrik;
    getDayaListrik = GetProvinces.fromJson(json.decode(responseProvinces.body));
    var datasDayaListrik = getDayaListrik.data;
    return datasDayaListrik;
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
            status == 'BBG'
                ? "Anda yakin ingin melakukan pengalihan BBG? "
                : "Anda yakin ingin melakukan Perubahan Segmen / Kelompok Pelanggan? ",
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
            status == 'BBG' ? submitFormBBG() : submitForm();
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

    var body = json.encode({"P_CUST_NUMBER": custNameString});

    var responseDataCust =
        await http.post('https://api.pgn.co.id/customers/profile',
            headers: {
              'Content-Type': 'application/json',
              'PGN-Key': '743c3a53b47744789cb564702170c294',
              'Ocp-Apim-Trace': 'true'
            },
            body: body);
    //print('BODY GET CUSTOMER CRED $body');
    //print('HASIL GET CUSTOMER CRED ${responseDataCust.body}');

    FormCustomerCredModel formCustomerCredModel =
        FormCustomerCredModel.fromJson(json.decode(responseDataCust.body));

    setState(() {
      custID = custNameString;
      custName = custIDString;
      email = emailString;
      phoneNumb = userPhoneString;
      phoneNumbCtrl.value = new TextEditingController.fromValue(
              new TextEditingValue(text: userPhoneString))
          .value;
      custGroup = custGroupString;
      if (custGroupString == '3') {
        custGroup = 'RT';
      } else if (custGroupString == '1') {
        custGroup = 'KI';
      } else if (custGroupString == '2') {
        custGroup = 'Bulk';
      }

      if (formCustomerCredModel.custProfileDataOutput != null) {
        nikCtrl.value = new TextEditingController.fromValue(
                new TextEditingValue(
                    text: formCustomerCredModel.custProfileDataOutput[0].nik))
            .value;
        ktpAddressCtrl.value = new TextEditingController.fromValue(
                new TextEditingValue(
                    text: formCustomerCredModel
                        .custProfileDataOutput[0].addressNpwpKtp))
            .value;
        alamatCtrl.value = new TextEditingController.fromValue(
                new TextEditingValue(
                    text: formCustomerCredModel
                        .custProfileDataOutput[0].addressMeter))
            .value;
        kecamatanCtrl
            .value = new TextEditingController.fromValue(new TextEditingValue(
                text: formCustomerCredModel.custProfileDataOutput[0].kecamatan))
            .value;
        kelurahanCtrl
            .value = new TextEditingController.fromValue(new TextEditingValue(
                text: formCustomerCredModel.custProfileDataOutput[0].kelurahan))
            .value;
        kabupatenCtrl.value = new TextEditingController.fromValue(
                new TextEditingValue(
                    text: formCustomerCredModel.custProfileDataOutput[0].kota))
            .value;
      }
    });
  }

  void _nextLokasiPesangan(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapPoint()));
    //print('INI RESULT LAT LANG $result');
    setState(() {
      locationCtrl.text = result;
    });
  }

  void submitFormBBG() async {
    String encodedImageNPWP;
    String encodedImageRek;
    String encodedImageKTP;
    if (_fileName != null) {
      Uint8List imageUnit8;
      imageUnit8 = imgNPWP.readAsBytesSync();
      String fileExt = imgNPWP.path.split('.').last;
      encodedImageNPWP =
          'data:image/$fileExt;base64,${base64Encode(imageUnit8)}';
    } else {
      encodedImageNPWP = "";
    }
    if (_fileNameRekListrik != null) {
      Uint8List imageUnit8;
      imageUnit8 = imgRek.readAsBytesSync();
      String fileExt = imgRek.path.split('.').last;
      encodedImageRek =
          'data:image/$fileExt;base64,${base64Encode(imageUnit8)}';
    } else {
      encodedImageRek = "";
    }
    if (_fileNameKtp != null) {
      Uint8List imageUnit8;
      imageUnit8 = imgKTP.readAsBytesSync();
      String fileExt = imgKTP.path.split('.').last;
      encodedImageKTP =
          'data:image/$fileExt;base64,${base64Encode(imageUnit8)}';
    } else {
      encodedImageKTP = "";
    }
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
    //print('INI LAT $lat');
    //print('INI LONG $long');
    //print('GAMBARNYA  data:image/png;base64,$encoded} ');
    String accessToken = await storageCache.read(key: 'access_token');
    var body = json.encode({
      "customer_id": custID,
      "customer_name": custName,
      "gender": valueChoose,
      "birth_place": tempatLahirCtrl.text,
      "birth_date": selected != null
          ? DateFormat('yyy-MM-dd').format(selected)
          : DateFormat('yyy-MM-dd').format(DateTime.now()),
      "id_card_number": nikCtrl.text,
      "email": email,
      "phone_number": phoneNumbCtrl.text,
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
      "info_media":
          valueMediaType == 'SMS (Dikenakan biaya)' ? 'SMS' : valueMediaType,
      "submission_date": selectedPengajuan != null
          ? DateFormat('yyy-MM-dd').format(selectedPengajuan)
          : DateFormat('yyy-MM-dd').format(DateTime.now()),
      "reason": alasanCtrl.text,
      "customer_group": custGroup,
      "electrical_power": dataListrikWat,
      "electricity_bill_proof": encodedImageRek,
      "npwp_file": encodedImageNPWP,
      "npwp_number": nomorNpwpCtrl.text,
      "ktp_address": ktpAddressCtrl.text,
      "ktp_file": encodedImageKTP,
      "customer_signature": 'data:image/png;base64,$encoded',
    });
    var response = await http.post(
        '${UrlCons.mainProdUrl}customer-service/pengalihan-bbg',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);
    //print('INI HASIL POST CREATE PENGAHUAN AMANDEMEN ${response.body}');
    Create create = Create.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      successAlert(create.dataCreate.message, create.dataCreate.formId);
    } else {
      Navigator.pop(context);
      showToast(create.dataCreate.message);
    }
  }

  void submitForm() async {
    String encodedImageNPWP;
    String encodedImageKTP;
    if (_fileName != null) {
      Uint8List imageUnit8;
      imageUnit8 = imgNPWP.readAsBytesSync();
      String fileExt = imgNPWP.path.split('.').last;
      encodedImageNPWP =
          'data:image/$fileExt;base64,${base64Encode(imageUnit8)}';
    } else {
      encodedImageNPWP = "";
    }
    if (_fileNameKtp != null) {
      Uint8List imageUnit8;
      imageUnit8 = imgKTP.readAsBytesSync();
      String fileExt = imgKTP.path.split('.').last;
      encodedImageKTP =
          'data:image/$fileExt;base64,${base64Encode(imageUnit8)}';
    } else {
      encodedImageKTP = "";
    }
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
    //print('INI LAT $lat');
    //print('INI LONG $long');
    //print('GAMBARNYA  data:image/png;base64,$encoded} ');
    String accessToken = await storageCache.read(key: 'access_token');
    var body = json.encode({
      "customer_id": custID,
      "customer_name": custName,
      "gender": valueChoose,
      "birth_place": tempatLahirCtrl.text,
      "birth_date": selected != null
          ? DateFormat('yyy-MM-dd').format(selected)
          : DateFormat('yyy-MM-dd').format(DateTime.now()),
      "id_card_number": nikCtrl.text,
      "email": email,
      "phone_number": phoneNumbCtrl.text,
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
      "info_media":
          valueMediaType == 'SMS (Dikenakan biaya)' ? 'SMS' : valueMediaType,
      "customer_group": custGroup,
      "submission_date": selectedPengajuan != null
          ? DateFormat('yyy-MM-dd').format(selectedPengajuan)
          : DateFormat('yyy-MM-dd').format(DateTime.now()),
      "submission_customer_group": valueKelompokPelanggan,
      "minimum_volume_month": int.parse(volumeMinCtrl.text),
      "maximum_volume_month": int.parse(volumeMaxCtrl.text),
      "average_volume_month": int.parse(pemakaianPerBulanCtrl.text),
      "operational_hour_day": int.parse(jamperHariCtrl.text),
      "operational_day_week": int.parse(hariperMingguCtrl.text),
      "customer_equipments": gasEquip,
      "reason": alasanCtrl.text,
      "npwp_file": encodedImageNPWP,
      "npwp_number": nomorNpwpCtrl.text,
      "ktp_address": ktpAddressCtrl.text,
      "gas_usage_type_submission": jenisPemakianGas,
      "ktp_file": encodedImageKTP,
      "customer_signature": 'data:image/png;base64,$encoded',
    });
    //print('SEGMEN BODY POST $body');
    var response = await http.post(
        '${UrlCons.mainProdUrl}customer-service/change-segment',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);
    //print('SEGMEN EQUIP LIST ${json.encode(gasEquip)}');
    //print('INI HASIL POST CREATE SEGMEN ${response.body}');
    Create create = Create.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      successAlert(create.dataCreate.message, create.dataCreate.formId);
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
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result != null) {
      File file = File(result.files.single.path.toString());
      if (status == 'rekListrik') {
        setState(() {
          _fileNameRekListrik = result.names.single;
          imgRek = file;
          //print('NAMA FILE : $_fileName');
        });
      } else if (status == 'KTP') {
        setState(() {
          _fileNameKtp = result.names.single;
          imgKTP = file;
          //print('NAMA FILE KTP : $_fileNameKtp');
        });
      } else {
        setState(() {
          _fileName = result.names.single;
          imgNPWP = file;
          //print('NAMA FILE : $_fileName');
        });
      }
    } else {
      // User canceled the picker
    }
  }

  void _pickPenerimaFiles(String status) async {
    _resetState();
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result != null) {
      File file = File(result.files.single.path.toString());
      if (status == 'rekListrik') {
        setState(() {
          _penerimaFileNameRekListrik = result.names.single;
          imgRek = file;
          //print('NAMA FILE : $_fileName');
        });
      } else if (status == 'KTP') {
        setState(() {
          _penerimaFileNameKtp = result.names.single;
          imgKTP = file;
          //print('NAMA FILE KTP : $_fileNameKtp');
        });
      } else {
        setState(() {
          _fileName = result.names.single;
          imgNPWP = file;
          //print('NAMA FILE : $_fileName');
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

  Future<bool> successAlert(String message, String formID) {
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
          SizedBox(height: 5),
          Text(
            'Nomor Formulir Layanan Pelanggan Anda: $formID',
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
