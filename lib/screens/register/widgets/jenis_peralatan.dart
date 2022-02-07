import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:pgn_mobile/models/provinces_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/register/widgets/dropdown.dart';
import 'package:pgn_mobile/services/register_residential.dart';
import 'package:provider/provider.dart';
// import 'package:calendarro/calendarro.dart';
import 'package:pgn_mobile/services/calculators.dart';
import 'package:intl/intl.dart';

class JenisPeralatan extends StatefulWidget {
  List<Map<String, dynamic>> gasToolUsageIndustrialVal = [];
  @override
  JenisPeralatan({this.gasToolUsageIndustrialVal});
  JenisPeralatanState createState() =>
      JenisPeralatanState(gasToolUsageIndustrialVal);
}

class JenisPeralatanState extends State<JenisPeralatan> {
  List<Map<String, dynamic>> gasToolUsageIndustrialVal = [];
  JenisPeralatanState(this.gasToolUsageIndustrialVal);
  TextEditingController jenisBahanBakarCtrl = new TextEditingController();
  TextEditingController satuanBBakarCtrl = new TextEditingController();
  TextEditingController datePickerCtrl = new TextEditingController();
  TextEditingController perMonthCtrl = new TextEditingController();
  TextEditingController jKerjaPerMingguCtrl = new TextEditingController();
  TextEditingController jKerjaPerHariCtrl = new TextEditingController();
  TextEditingController satuanTekananOprasiCtrl = new TextEditingController();
  TextEditingController tekananOprasiCtrl = new TextEditingController();
  TextEditingController nameToolCtrl = new TextEditingController();
  // List<Map<String, dynamic>> gasToolUsageIndustrialVal=[];
  DateTime selected;
  String selectedDate;
  String valTekananOprasi;
  List<EquipmentData> equipmentData;

  _showDateTimePicker() async {
    selected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    setState(() {
      datePickerCtrl.text = new DateFormat('dd MMM yyyy').format(selected);
      selectedDate = new DateFormat('yyyy-MM-dd').format(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Jenis Peralatan",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(children: [
        Container(
          margin: EdgeInsets.only(top: 15, left: 15),
          child: Text("Jenis Peralatan yang Menggunakan Gas"),
        ),
        Container(
          padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
          // width: 295,
          child: TextField(
            controller: nameToolCtrl,
            decoration: InputDecoration(
              labelText: 'Nama peralatan',
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _nextScreen(context);
          },
          child: Container(
            padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
            child: TextField(
              enabled: false,
              // onChanged: (value){
              //   setState(() {
              //     Map<String, dynamic> fuelID = {"fuel_id":"1"};
              //     // gasToolUsageIndustrialVal.removeWhere((item) => item['fuel_id']);
              //     gasToolUsageIndustrialVal.add(fuelID);
              //     //print("Isi Usage Tool INDUSTRIAL Fuel ID: $gasToolUsageIndustrialVal");
              //   });
              // },
              controller: jenisBahanBakarCtrl,
              decoration: InputDecoration(
                labelText: 'Jenis Bahan Bakar',
                suffixIcon: IconButton(
                  icon: Image.asset(
                    'assets/icon_dropdown.png',
                    height: 20.0,
                  ),
                  onPressed: () {
                    //   Map<String, dynamic> fuelID = {"fuel_id":"1"};
                    // // gasToolUsageIndustrialVal.removeWhere((item) => item['fuel_id']);
                    // gasToolUsageIndustrialVal.add(fuelID);

                    // //print("Isi Usage Tool INDUSTRIAL Fuel ID: $gasToolUsageIndustrialVal");
                    _nextScreen(context);
                    //print('FUEL ID');
                  },
                ),
              ),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              width: 240,
              padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
              child: TextField(
                // onChanged: (value){
                //   setState(() {
                //     Map<String, dynamic> fuelID = {"fuel_id":"1"};
                //   // gasToolUsageIndustrialVal.removeWhere((item) => item['fuel_id']);
                //   gasToolUsageIndustrialVal.add(fuelID);
                //     Map<String, dynamic> fuelPerMonth = {"fuel_consumption_per_month":"$value"};
                //     // gasToolUsageIndustrialVal.removeWhere((item) => item['fuel_consumption_per_month']);
                //     gasToolUsageIndustrialVal.add(fuelPerMonth);
                //     //print("Isi Usage Tool INDUSTRIAL Fuel Per Month: $gasToolUsageIndustrialVal");
                //   });
                // },
                controller: perMonthCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Konsumsi Bahan Bakar per-Bulan',
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                child: TextField(
                  // onChanged: (value){
                  //   setState(() {
                  //     Map<String, dynamic> fuelPerMonth = {"fuel_consumption_per_month":"$value"};
                  //     gasToolUsageIndustrialVal.removeWhere((item) => item['fuel_consumption_per_month']);
                  //     gasToolUsageIndustrialVal.add(fuelPerMonth);
                  //     //print("Isi Usage Tool INDUSTRIAL Tekanan: $gasToolUsageIndustrialVal");
                  //   });
                  // },
                  controller: satuanBBakarCtrl,
                  decoration: InputDecoration(
                    labelText: 'Satuan',
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              width: 240,
              padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
              child: TextField(
                // onChanged: (value){
                //   setState(() {
                //     Map<String, dynamic> tekanan = {"pressure":"$value"};
                //     // gasToolUsageIndustrialVal.removeWhere((item) => item['pressure']);
                //     gasToolUsageIndustrialVal.add(tekanan);
                //     //print("Isi Usage Tool INDUSTRIAL Tekanan: $gasToolUsageIndustrialVal");
                //   });
                // },
                controller: tekananOprasiCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tekanan Operasi',
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  _showDialogsatuanTekananOprasi(context);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (satuanTekananOprasiCtrl.text == "BarG") {
                          valTekananOprasi = "11";
                          // Map<String, dynamic> tekananID = {"pressure_unit_id":"11"};
                          // // gasToolUsageIndustrialVal.removeWhere((item) => item['pressure_unit_id']);
                          // gasToolUsageIndustrialVal.add(tekananID);
                          // //print("Isi Usage Tool INDUSTRIAL Tekanan ID: $gasToolUsageIndustrialVal");
                        } else {
                          valTekananOprasi = "12";
                          // Map<String, dynamic> tekananID = {"pressure_unit_id":"12"};
                          // // gasToolUsageIndustrialVal.removeWhere((item) => item['pressure_unit_id']);
                          // gasToolUsageIndustrialVal.add(tekananID);
                          // //print("Isi Usage Tool INDUSTRIAL Tekanan ID: $gasToolUsageIndustrialVal");
                        }
                      });
                    },
                    enabled: false,
                    controller: satuanTekananOprasiCtrl,
                    decoration: InputDecoration(
                      labelText: 'Satuan',
                      suffixIcon: IconButton(
                        icon: Image.asset(
                          'assets/icon_dropdown.png',
                          height: 20.0,
                        ),
                        onPressed: () {
                          _showDialogsatuanTekananOprasi(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        InkWell(
          onTap: () {
            _showDialogBulan(context);
          },
          child: Container(
            padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
            child: TextField(
              // onChanged: (value){
              //   setState(() {
              //     Map<String, dynamic> workPerDays = {"total_work_days":"$value"};
              //     // gasToolUsageIndustrialVal.removeWhere((item) => item['total_work_days']);
              //     gasToolUsageIndustrialVal.add(workPerDays);
              //     //print("Isi Usage Tool INDUSTRIAL Work Per Days: $gasToolUsageIndustrialVal");
              //   });
              // },
              enabled: true,
              controller: jKerjaPerHariCtrl,
              decoration: InputDecoration(
                labelText: 'Jumlah Jam Kerja per-Hari',
                suffixIcon: IconButton(
                  icon: Image.asset(
                    'assets/icon_dropdown.png',
                    height: 20.0,
                  ),
                  onPressed: () {
                    _showDialogBulan(context);
                  },
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _showDialogMinggu(context);
          },
          child: Container(
            padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
            child: TextField(
              enabled: true,
              onChanged: (value) {
                setState(() {
                  Map<String, dynamic> workPerDays = {
                    "total_work_hours": "$value"
                  };
                  // gasToolUsageIndustrialVal.removeWhere((item) => item['total_work_hours']);
                  gasToolUsageIndustrialVal.add(workPerDays);
                  //print(
                  // "Isi Usage Tool INDUSTRIAL Work Per Hours: $gasToolUsageIndustrialVal");
                });
              },
              controller: jKerjaPerMingguCtrl,
              decoration: InputDecoration(
                labelText: 'Jumlah Hari kerja per-Minggu',
                suffixIcon: IconButton(
                  icon: Image.asset(
                    'assets/icon_dropdown.png',
                    height: 20.0,
                  ),
                  onPressed: () {
                    _showDialogMinggu(context);
                  },
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _showDateTimePicker();
          },
          child: Container(
            padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
            child: TextFormField(
              enabled: true,
              controller: datePickerCtrl,
              decoration: InputDecoration(
                labelText: 'DateTime',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    size: 25,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    _showDateTimePicker();
                  },
                ),
              ),
            ),
          ),
        ),
        Container(
            height: 50.0,
            margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).primaryColor,
            ),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              child: Text(
                'Lanjut',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                // equipmentData.add(EquipmentData(
                //     "${nameToolCtrl.text}",
                //     "1",
                //     "${perMonthCtrl.text}",
                //     "${tekananOprasiCtrl.text}",
                //     "11",
                //     "${jKerjaPerHariCtrl.text}",
                //     "${jKerjaPerMingguCtrl.text}",
                //     "$selectedDate"));
                // // gasToolUsageIndustrialVal.clear();
                // // gasToolUsageIndustrialVal.removeWhere((item) => item['name'] == latest);
                // //print(
                //     "INI GAS USAGE TOOL JENIS PERALATAN: ${equipmentData.length}");
                if (satuanTekananOprasiCtrl.text == "BarG") {
                  valTekananOprasi = "11";
                } else {
                  valTekananOprasi = "12";
                }
                final _provRegIndustrial =
                    Provider.of<RegistResidential>(context);
                Map<String, dynamic> namaPeralatan = {
                  "name": "${nameToolCtrl.text}",
                  "fuel_id": "${_provRegIndustrial.jenisBahanBakarBisnisId}",
                  "fuel_consumption_per_month": "${perMonthCtrl.text}",
                  "pressure": "${tekananOprasiCtrl.text}",
                  "pressure_unit_id": "$valTekananOprasi",
                  "total_work_hours": "${jKerjaPerHariCtrl.text}",
                  "total_work_days": "${jKerjaPerMingguCtrl.text}",
                  "estimation_start_date": "$selectedDate"
                };

                // gasToolUsageIndustrialVal.add(namaPeralatan);

                Navigator.pop(context, namaPeralatan);
                // Navigator.pop(context, equipmentData);
              },
            )),
      ]),
    );
  }

  void _nextScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchDropDown(
                data: getJenisBahanBakar(context),
                title: 'Jenis bahan bakar')));
    setState(() {
      jenisBahanBakarCtrl.text = result;
      satuanBBakarCtrl.text = result;
    });
    final _provRegIndustrial = Provider.of<RegistResidential>(context);
    //print("ini${_provRegIndustrial.jenisBahanBakarBisnisId}");
  }

  Widget _showDialogMinggu(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                  child: SingleChildScrollView(
                      child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Jumlah Jam Kerja per Minggu'),
              Divider(),
              for (var i = 1; i <= 7; i++)
                InkWell(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text('$i'),
                      ),
                      Divider(),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      jKerjaPerMingguCtrl.text = '$i';
                      Provider.of<CalculatorsEnergy>(context).boiler(
                        sixBoiHintVal: '$i',
                      );
                    });
                    Navigator.pop(context, 'hhh');
                  },
                ),
            ],
          ))));
        });
  }

  Widget _showDialogsatuanTekananOprasi(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                  child: SingleChildScrollView(
                      child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Satuan Tekanan Oprasi'),
              Divider(),
              InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text('BarG'),
                    ),
                    Divider(),
                  ],
                ),
                onTap: () {
                  setState(() {
                    satuanTekananOprasiCtrl.text = 'BarG';
                  });
                  Navigator.pop(context, 'hhh');
                },
              ),
              InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text('PSI'),
                    ),
                    Divider(),
                  ],
                ),
                onTap: () {
                  setState(() {
                    satuanTekananOprasiCtrl.text = 'PSI';
                  });
                  Navigator.pop(context, 'hhh');
                },
              ),
            ],
          ))));
        });
  }

  Widget _showDialogBulan(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                  child: SingleChildScrollView(
                      child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Jumlah Jam Kerja per Hari'),
              Divider(),
              for (var i = 1; i <= 24; i++)
                InkWell(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text('$i'),
                      ),
                      Divider(),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      jKerjaPerHariCtrl.text = '$i';
                    });
                    Navigator.pop(context, 'hhh');
                  },
                ),
            ],
          ))));
        });
  }
}

Future<GetProvinces> getJenisBahanBakar(BuildContext context) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseProvinces = await http
      .get('${UrlCons.prodRelyonUrl}v1/fuel-types-industry', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseProvinces.body));
}
