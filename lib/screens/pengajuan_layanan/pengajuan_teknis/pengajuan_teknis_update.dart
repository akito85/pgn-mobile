import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/pengajuan_teknis_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;
import 'package:file_picker/file_picker.dart';
import 'package:pgn_mobile/screens/otp/otp.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/widgets/widget_biaya_pemasangan_kembali.dart';
import 'package:pgn_mobile/screens/register/widgets/map_point.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PengajuanTeknisUpdate extends StatefulWidget {
  final int id;
  final int techId;
  final String techName;
  PengajuanTeknisUpdate({this.id, this.techId, this.techName});
  @override
  _PengajuanTeknisUpdateState createState() =>
      _PengajuanTeknisUpdateState(id: id, techId: techId, techName: techName);
}

class _PengajuanTeknisUpdateState extends State<PengajuanTeknisUpdate> {
  final int id;
  final int techId;
  final String techName;
  _PengajuanTeknisUpdateState({this.id, this.techId, this.techName});
  DetailData detailDatas = DetailData();
  var splitString;
  var splitStringKTP;
  Uint8List image = base64.decode(
      "iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAMAAACahl6sAAACzVBMVEUAAAAAAAAAAAAAAABAQEAzMzMrKyskJCQgICAcHBwaGhouLi4rKysnJyckJCQiIiIgICAtLS0rKysoKCgmJiYkJCQjIyMhISErKyspKSknJycmJiYkJCQjIyMiIiIpKSkoKCgnJycmJiYkJCQjIyMpKSkoKCgnJycmJiYlJSUkJCQkJCQpKSkoKCgnJycmJiYlJSUkJCQkJCQoKCgnJycmJiYmJiYlJSUkJCQkJCQoKCgnJycmJiYmJiYlJSUkJCQoKCgnJycmJiYmJiYlJSUkJCQoKCgnJycmJiYmJiYlJSUlJSUnJycnJycmJiYmJiYlJSUlJSUnJycnJycmJiYmJiYlJSUlJSUnJycnJycmJiYmJiYlJSUnJycnJycmJiYmJiYmJiYlJSUlJSUnJycmJiYmJiYmJiYlJSUnJycnJycmJiYmJiYmJiYlJSUlJSUnJycnJycmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYnJycnJycmJiYmJiYmJiYlJSUnJycnJycmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYlJSUlJSUnJycmJiYmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYmJiYlJSUmJiYmJiYmJiYmJiYnJycmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYnJycmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYlJSUmJiYmJiYmJiYmJiYmJiYmJiYnJycmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYnJycmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJib///9SC2xrAAAA7XRSTlMAAQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiMkJSYnKCkqKywtLi8wMTIzNDU2Nzg5Ojs8PT4/QEFDREVGR0hJSktMTk9QUVJTVFVXWFlaW1xdXmFiY2RlZmdoaWprbG5vcHFyc3R1dnd4eXp7fX5/gIOEhoeIiYqL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");
  Uint8List imageKTP = base64.decode(
      "iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAMAAACahl6sAAACzVBMVEUAAAAAAAAAAAAAAABAQEAzMzMrKyskJCQgICAcHBwaGhouLi4rKysnJyckJCQiIiIgICAtLS0rKysoKCgmJiYkJCQjIyMhISErKyspKSknJycmJiYkJCQjIyMiIiIpKSkoKCgnJycmJiYkJCQjIyMpKSkoKCgnJycmJiYlJSUkJCQkJCQpKSkoKCgnJycmJiYlJSUkJCQkJCQoKCgnJycmJiYmJiYlJSUkJCQkJCQoKCgnJycmJiYmJiYlJSUkJCQoKCgnJycmJiYmJiYlJSUkJCQoKCgnJycmJiYmJiYlJSUlJSUnJycnJycmJiYmJiYlJSUlJSUnJycnJycmJiYmJiYlJSUlJSUnJycnJycmJiYmJiYlJSUnJycnJycmJiYmJiYmJiYlJSUlJSUnJycmJiYmJiYmJiYlJSUnJycnJycmJiYmJiYmJiYlJSUlJSUnJycnJycmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYnJycnJycmJiYmJiYmJiYlJSUnJycnJycmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYlJSUlJSUnJycmJiYmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYlJSUnJycmJiYmJiYmJiYmJiYmJiYlJSUmJiYmJiYmJiYmJiYnJycmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYnJycmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYlJSUmJiYmJiYmJiYmJiYmJiYmJiYnJycmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYnJycmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJib///9SC2xrAAAA7XRSTlMAAQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiMkJSYnKCkqKywtLi8wMTIzNDU2Nzg5Ojs8PT4/QEFDREVGR0hJSktMTk9QUVJTVFVXWFlaW1xdXmFiY2RlZmdoaWprbG5vcHFyc3R1dnd4eXp7fX5/gIOEhoeIiYqL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");
  List listGenderType = [
    "Laki-Laki",
    "Perempuan",
  ];
  List listStatusKepemilikan = [
    "Pemilik",
    "Penyewa",
    "Lain-lain",
  ];
  DateTime selected = DateTime.now();
  DateTime selectedPengajuan = DateTime.now();
  String valueChoose;
  String valueMediaType;
  String teknisType;
  bool visibleDataDiri = true;
  bool visibleAlamat = false;
  bool visibleDataPelengkap = false;
  bool visibleReview = false;
  String _fileName;
  String _fileNameKtp;
  String nik = '';

  String custName = '';
  String custID = '';
  String email = '';
  String phoneNumb = '';
  String statusLokasi;
  File imgNPWP;
  File imgKTP;

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
  TextEditingController numberNpwpCtrl = new TextEditingController();
  TextEditingController ktpAddressCtrl = new TextEditingController();
  final storageCache = FlutterSecureStorage();
  ByteData _img = ByteData(0);
  final _sign = GlobalKey<SignatureState>();
  final _formKeyDataDiri = GlobalKey<FormState>();
  final _formKeyAlamat = GlobalKey<FormState>();
  final _formKeyPelengkap = GlobalKey<FormState>();

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

    // getDataCred();
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
          'Update ${this.techName}',
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
                          hintText: detailDatas.custId,
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
                                hintText: detailDatas.custName,
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
                          hintText: detailDatas.email,
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
                          hintText: '+${detailDatas.phoneNumb}',
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
                          hintText: detailDatas.custId,
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
              key: _formKeyPelengkap,
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
                          hintText: detailDatas.custId,
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
                          detailDatas.ktpFile == ""
                              ? GestureDetector(
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
                                )
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      detailDatas.ktpFile = "";
                                    });
                                    _pickFiles('KTP');
                                  },
                                  child: Text(
                                    'Ubah',
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
                        child: detailDatas.ktpFile == ""
                            ? Container(
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
                              )
                            : Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: MemoryImage(imageKTP)))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Text(
                        'Nomor NPWP',
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
                        controller: numberNpwpCtrl,
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
                          detailDatas.npwpFile == ""
                              ? GestureDetector(
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
                                )
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      detailDatas.npwpFile = "";
                                    });
                                    _pickFiles('NPWP');
                                  },
                                  child: Text(
                                    'Ubah',
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
                        child: detailDatas.npwpFile == ""
                            ? Container(
                                height: 60,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      _pickFiles('NPWP');
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
                              )
                            : Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: MemoryImage(image)))),
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
                        'Layanan Teknis',
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
                          hintText: this.techName,
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
                        'Tanggal Pekerjaan',
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
                          Text(selectedPengajuan != null
                              ? DateFormat('d MMM yyy')
                                  .format(selectedPengajuan)
                              : DateFormat('d MMM yyy').format(
                                  DateTime.parse(detailDatas.subDate)
                                      .toLocal())),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetReferensiBiayaTeknis(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, bottom: 10, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Color(0xFF427CEF),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Referensi Biaya',
                                style: TextStyle(
                                    color: Color(0xFF427CEF),
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
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
                            hintText: ''),
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
                    //         child: Image.memory(_img.buffer.asUint8List())),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 16, right: 16, bottom: 40),
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
                          //           final encoded =
                          //               base64.encode(data.buffer.asUint8List());
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
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 45),
                      child: Text(
                        'Bersama ini menyatakan bertanggung jawab terhadap kebenaran data tersebut dan bersedia memenuhi segala persyaratan & kewajiban yang telah ditetapkan oleh PT Perusahaan Gas Negara Tbk.',
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
                                if (_formKeyPelengkap.currentState.validate() &&
                                    sign.hasPoints) {
                                  addFormAlert();
                                } else if (!sign.hasPoints) {
                                  showToast('Tanda Tangan harus ada !');
                                } else if (teknisType == null) {
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
            "Anda yakin ingin perbarui pengajuan layanan teknis ? ",
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

  void getData() async {
    print('ID Nya ${widget.id}');
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var response = await http.get(
        '${UrlCons.mainDevUrl}customer-service/technical-service/${widget.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang,
        });
    print('GET DETAIL PEMASANGAN KEMBALI ${response.body}');
    DetailData detailData = DetailData.fromJson(json.decode(response.body));
    if (detailData.npwpFile != "" && detailData.npwpFile != null) {
      splitString = detailData.npwpFile.split(',');
      image = base64.decode(splitString[1]);
    }
    if (detailData.ktpFile != "") {
      splitStringKTP = detailData.ktpFile.split(',');
      imageKTP = base64.decode(splitStringKTP[1]);
    }
    setState(() {
      detailDatas = detailData;
      nik = detailData.nik;
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
    numberNpwpCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.npwpNumb))
        .value;
    kabupatenCtrl.value = new TextEditingController.fromValue(
            new TextEditingValue(text: detailData.kabupaten))
        .value;
  }

  void _nextLokasiPesangan(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapPoint()));
    print('INI RESULT LAT LANG $result');
    setState(() {
      locationCtrl.text = result;
    });
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
      encodedImageNPWP = detailDatas.npwpFile;
    }
    if (_fileNameKtp != null) {
      Uint8List imageUnit8;
      imageUnit8 = imgKTP.readAsBytesSync();
      String fileExt = imgKTP.path.split('.').last;
      encodedImageKTP =
          'data:image/$fileExt;base64,${base64Encode(imageUnit8)}';
    } else {
      encodedImageKTP = detailDatas.ktpFile;
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
    print('INI LAT $lat');
    print('INI LONG $long');
    print('GAMBARNYA  data:image/png;base64,$encoded} ');
    String accessToken = await storageCache.read(key: 'access_token');
    var body = json.encode({
      "customer_id": detailDatas.custId,
      "customer_name": detailDatas.custName,
      "gender": valueChoose,
      "birth_place": tempatLahirCtrl.text,
      "birth_date": selected != null
          ? DateFormat('yyy-MM-dd').format(selected)
          : DateFormat('yyy-MM-dd').format(DateTime.now()),
      "id_card_number": nikCtrl.text,
      "email": detailDatas.email,
      "phone_number": detailDatas.phoneNumb,
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
      "technical_type": this.techName,
      'technical_type_id': this.techId,
      "info_media": '',
      "submission_date": selectedPengajuan != null
          ? DateFormat('yyy-MM-dd').format(selectedPengajuan)
          : detailDatas.subDate,
      "reason": alasanCtrl.text,
      "npwp_number": numberNpwpCtrl.text,
      "ktp_address": ktpAddressCtrl.text,
      "ktp_file": encodedImageKTP,
      "npwp_file": encodedImageNPWP,
      "customer_signature": 'data:image/png;base64,$encoded',
    });
    var response = await http.put(
        '${UrlCons.mainProdUrl}customer-service/technical-service/$id',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);
    print('INI HASIL POST Tech Type${response.body}');
    Create create = Create.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      successAlert(create.dataCreate.message);
    } else {
      Navigator.pop(context);
      showToast(create.dataCreate.message);
    }
  }

  Future<List<DataTechType>> getTechTypes() async {
    String accessToken = await storageCache.read(key: 'access_token');
    var responseTechType = await http.get(
        '${UrlCons.mainProdUrl}customer-service/technical-service-job-type',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    GetTechTypes getTechType;
    getTechType = GetTechTypes.fromJson(json.decode(responseTechType.body));
    var dataTechTypes = getTechType.data;
    return dataTechTypes;
  }

  void _pickFiles(String status) async {
    _resetState();
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result != null) {
      File file = File(result.files.single.path.toString());
      if (status == "NPWP") {
        setState(() {
          _fileName = result.names.single;
          imgNPWP = file;
          print('NAMA FILE : $_fileName');
        });
      } else {
        setState(() {
          _fileNameKtp = result.names.single;
          imgKTP = file;
          print('NAMA FILE KTP : $_fileNameKtp');
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
