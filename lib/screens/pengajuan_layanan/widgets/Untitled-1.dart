import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:pgn_mobile/models/berhenti_berlangganan_model.dart';
import 'package:pgn_mobile/models/provinces_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:pgn_mobile/screens/otp/otp.dart';
import 'dart:ui' as ui;

import 'package:pgn_mobile/screens/register/widgets/map_point.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BerhentiBerlanggananForm extends StatefulWidget {
  @override
  _BerhentiBerlanggananFormState createState() =>
      _BerhentiBerlanggananFormState();
}

class _BerhentiBerlanggananFormState extends State<BerhentiBerlanggananForm> {
  List listGenderType = [
    "Laki-Laki",
    "Perempuan",
  ];
  DateTime selected = DateTime.now();
  DateTime selectedPengajuan = DateTime.now();
  String valueChoose;
  bool visibleDataDiri = true;
  bool visibleAlamat = false;
  bool visibleDataPelengkap = false;
  bool visibleReview = false;
  String custName = '';
  String custID = '';
  String email = '';
  String phoneNumb = '';
  String statusLokasi = '';
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
  TextEditingController alasanCtrl = new TextEditingController();
  final storageCache = FlutterSecureStorage();
  ByteData _img = ByteData(0);
  final _sign = GlobalKey<SignatureState>();
  final _formKeyDataDiri = GlobalKey<FormState>();
  final _formKeyAlamat = GlobalKey<FormState>();
  Future _showDatePicker() async {
    dynamic selectedPicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
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
          'Pengajuan Berhenti Berlangganan',
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
                                if (_formKeyDataDiri.currentState.validate()) {
                                  setState(() {
                                    visibleDataDiri = false;
                                    visibleAlamat = true;
                                  });
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
                          hintText: '1232424',
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
                          top: 10, left: 16, right: 16, bottom: 40),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFD3D3D3))),
                      child: DropdownSearch<DataProvinces>(
                        mode: Mode.MENU,

                        onFind: (String filter) => getOwnerTypes(),
                        itemAsString: (DataProvinces u) => u.name,
                        // onChanged: (DataRejectType data) => //print(data),
                        onChanged: (DataProvinces data) {
                          setState(() {
                            statusLokasi = data.name;
                          });
                          //print(data);
                        },
                        label: "",
                        hint: "Pilih Status Kepemilikan",

                        dropdownSearchDecoration: InputDecoration(
                          contentPadding:
                              new EdgeInsets.only(left: 15, right: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
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
                                    statusLokasi != '') {
                                  setState(() {
                                    visibleDataDiri = false;
                                    visibleAlamat = false;
                                    visibleDataPelengkap = true;
                                  });
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
                        hintText: '1232424',
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 15.0),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: Color(0xFFF4F4F4), width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: Color(0xFFF4F4F4), width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 16, right: 16),
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
                        Text(DateFormat('d MMM yyy').format(
                            selectedPengajuan != null
                                ? selectedPengajuan
                                : DateTime.now())),
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC3C3C3)),
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
                  _img.buffer.lengthInBytes == 0
                      ? Container()
                      : LimitedBox(
                          maxHeight: 200.0,
                          child: Image.memory(_img.buffer.asUint8List())),
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
                        _img.buffer.lengthInBytes == 0
                            ? MaterialButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                onPressed: () async {
                                  final sign = _sign.currentState;
                                  //retrieve image data, do whatever you want with it (send to server, save locally...)
                                  final image = await sign.getData();
                                  var data = await image.toByteData(
                                      format: ui.ImageByteFormat.png);
                                  sign.clear();
                                  final encoded =
                                      base64.encode(data.buffer.asUint8List());
                                  setState(() {
                                    _img = data;
                                  });
                                  debugPrint("onPressed " + encoded);
                                },
                                child: Text("Konfirmasi"))
                            : Container(),
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
                      'Pastikan Anda telah melunasi segala kewajiban, denda, dan biaya lainnya (jika ada).',
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
                              addFormAlert();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF427CEF),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)))),
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
        ],
      ),
    );
  }

  Future<bool> addFormAlert() {
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
            "Anda yakin ingin melakukan pengajuan berhenti berlangganan ? ",
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
    setState(() {
      custID = custNameString;
      custName = custIDString;
      email = emailString;
      phoneNumb = userPhoneString;
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

  void submitForm() async {
    final sign = _sign.currentState;
    //retrieve image data, do whatever you want with it (send to server, save locally...)
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
      "longitude": locationCtrl.text,
      "latitude": locationCtrl.text,
      "person_in_location_status": statusLokasi,
      "info_media": '',
      "submission_date": DateFormat('yyy-MM-dd').format(selectedPengajuan),
      "reason": alasanCtrl.text,
      "customer_signature": 'data:image/png;base64,$encoded',
    });
    var responseCreateBerhentiBerlangganan = await http.post(
        '${UrlCons.mainProdUrl}customer-service/unsubscribe',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);
    //print(
    // 'INI HASIL POST CREATE BERLANGGANAN ${responseCreateBerhentiBerlangganan.body}');
    CreateBerhentiBerlangganan createBerhentiBerlangganan =
        CreateBerhentiBerlangganan.fromJson(
            json.decode(responseCreateBerhentiBerlangganan.body));

    if (responseCreateBerhentiBerlangganan.statusCode == 200) {
      showToast(createBerhentiBerlangganan.dataCreate.message);
      Navigator.pop(context);
    } else {
      showToast(createBerhentiBerlangganan.dataCreate.message);
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
}
