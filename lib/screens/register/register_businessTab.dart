import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/register/widgets/jenis_peralatan.dart';
import 'package:pgn_mobile/services/register_residential.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:pgn_mobile/models/provinces_model.dart';
import 'package:pgn_mobile/screens/register/widgets/dropdown.dart';
import 'package:provider/provider.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class RegisterBusinesTab extends StatefulWidget {
  final DataProvinces data;
  RegisterBusinesTab({this.data});
  @override
  RegisterBusinesTabState createState() => RegisterBusinesTabState(data);
}

class RegisterBusinesTabState extends State<RegisterBusinesTab>
    with TickerProviderStateMixin {
  TextEditingController fullNameCtrl = new TextEditingController();
  TextEditingController sektorIndustriCtrl = new TextEditingController();
  TextEditingController ccPersonCtrl = new TextEditingController();
  TextEditingController noPonselCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();

  TextEditingController alamatCtrl = new TextEditingController();
  TextEditingController provinceCtrl = new TextEditingController();
  TextEditingController cityCtrl = new TextEditingController();
  TextEditingController districtCtrl = new TextEditingController();
  TextEditingController villageCtrl = new TextEditingController();
  TextEditingController rtCtrl = new TextEditingController();
  TextEditingController rwCtrl = new TextEditingController();
  TextEditingController portalCodeCtrl = new TextEditingController();
  TextEditingController buildingConditionCtrl = new TextEditingController();

  TextEditingController ownerCtrl = new TextEditingController();

  TextEditingController datePickerCtrl = new TextEditingController();
  TextEditingController mTanahCtrl = new TextEditingController();
  TextEditingController bBaraCtrl = new TextEditingController();
  TextEditingController gasolineCtrl = new TextEditingController();
  TextEditingController karoseneCtrl = new TextEditingController();
  TextEditingController solarCtrl = new TextEditingController();
  TextEditingController idoCtrl = new TextEditingController();
  TextEditingController mfoCtrol = new TextEditingController();
  TextEditingController gasBumiCtrl = new TextEditingController();
  TextEditingController rPemanfaatanGasCtrl = new TextEditingController();
  TextEditingController jKerjaPerMingguCtrl = new TextEditingController();
  TextEditingController jKerjaPerHariCtrl = new TextEditingController();
  String dateTimeSelected;
  DateTime selected;
  List<Map<String, dynamic>> fuelUsageIndustrial = [];
  List<Map<String, dynamic>> gasToolUsageIndustrial = [];
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
      dateTimeSelected = new DateFormat('yyyy-MM-dd').format(selected);
    });
  }

  DataProvinces data;
  RegisterBusinesTabState(this.data);
  // var _index = 0;
  String _province = 'select';
  String switchIsSameOficeAddress = "1";
  String switchGasTools = "1";
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSwitched = true;
  bool isSwitchedLokasiKantor = true;
  // int _countLpj3Kg = 0;
  // int _countLpj12Kg = 0;
  // int _countLpj50Kg = 0;
  // int _countMinyakTanah = 0;
  // int _countGasBumi = 0;
  // int _countKompor1 = 0;
  // int _countKOmpor2 = 0;
  // int _countKompor3 = 0;
  // int _countKompor4 = 0;
  // int _countKomporOven = 0;
  // int _countDrayerGas = 0;
  // int _countWaterHeater = 0;
  // final listGasUsage = List<GasUsageModel>();
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'KI Registration',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: <Widget>[
            DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: TabBar(
                          indicatorColor: Color(0xff427CEF),
                          controller: _tabController,
                          labelColor: Colors.white,
                          unselectedLabelColor: Color(0xff427CEF),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF4578EF),
                          ),
                          isScrollable: false,
                          tabs: <Widget>[
                            Tab(
                              text: 'Profile',
                            ),
                            Tab(
                              text: 'Address',
                            ),
                            Tab(
                              child: Text(
                                'Gas Usage',
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Tab(text: 'Review'),
                          ],
                          onTap: (index) {
                            _tabController.index = 0;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[
                    _profileResi(context),
                    _addressResi(context),
                    _gasUsage(context),
                    _reviewResi(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileResi(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 15),
      child: Form(
        // key: _formKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: fullNameCtrl,
                decoration: InputDecoration(
                  labelText: 'Nama Perusahaan / Group',
                ),
              ),
            ),
            InkWell(
              onTap: () {
                fetchPostReg(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchDropDown(data: getProvinces(context))));
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: 5.0,
                  left: 10,
                  right: 10,
                ),
                // width: 295,
                child: TextFormField(
                  enabled: true,
                  controller: sektorIndustriCtrl,
                  // initialValue: _prov.toString() ?? _province,
                  decoration: InputDecoration(
                    labelText: 'Sektor Industri',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle,
                          color: Color(0XFF427CEF)),
                      onPressed: () {
                        _nextScreenSectorIndustri(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: ccPersonCtrl,
                decoration: InputDecoration(
                  labelText: 'Orang yang dapat dihubungi',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0, left: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 35.0,
                    child: TextFormField(
                      enabled: false,
                      initialValue: '+62',
                      decoration: InputDecoration(
                        labelText: 'INA',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Expanded(
                    child: Container(
                      // width: 295,m
                      margin: EdgeInsets.only(right: 10),
                      child: TextFormField(
                        controller: noPonselCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input valid email!';
                  }
                },
              ),
            ),
            Container(
                height: 50.0,
                margin: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFF427CEF),
                ),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (fullNameCtrl.text != "" &&
                        sektorIndustriCtrl.text != "" &&
                        ccPersonCtrl.text != "" &&
                        noPonselCtrl.text != "" &&
                        emailCtrl.text != "") {
                      setState(() {
                        _tabController.index = 1;
                      });
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _addressResi(BuildContext context) {
    final _prov = Provider.of<RegistResidential>(context);
    setState(
      () {
        provinceCtrl.text = _prov.province_name ?? '';
        cityCtrl.text = _prov.townName ?? '';
        districtCtrl.text = _prov.districtName ?? '';
        villageCtrl.text = _prov.villageName ?? '';
        buildingConditionCtrl.text = _prov.buildingTypeNameBisnis ?? '';
        ownerCtrl.text = _prov.ownershipName ?? '';
        //print("");
      },
    );
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Form(
        // key: _formKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: alamatCtrl,
                decoration: InputDecoration(
                  labelText: 'Location Address',
                ),
              ),
            ),
            InkWell(
              onTap: () {
                fetchPostReg(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchDropDown(data: getProvinces(context))));
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: 5.0,
                  left: 10,
                  right: 10,
                ),
                child: TextFormField(
                  enabled: true,
                  controller: provinceCtrl,
                  decoration: InputDecoration(
                    labelText: 'Province',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle,
                          color: Color(0XFF427CEF)),
                      onPressed: () {
                        //print('ini data dari regis: $getProvinces');
                        _nextScreen(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(
                  top: 5.0,
                  left: 10,
                  right: 10,
                ),
                // width: 295,
                child: TextFormField(
                  controller: cityCtrl,
                  decoration: InputDecoration(
                    labelText: 'City/Region',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle,
                          color: Color(0XFF427CEF)),
                      onPressed: () {
                        _nextScreenCity(context, _prov.province_id);
                      },
                    ),
                  ),
                ),
              ),
              onTap: () {
                _nextScreenCity(context, _prov.province_id);
              },
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: districtCtrl,
                decoration: InputDecoration(
                  labelText: 'District',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down_circle,
                        color: Color(0XFF427CEF)),
                    onPressed: () {
                      _nextScreenDistrict(context, _prov.townID);
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: villageCtrl,
                decoration: InputDecoration(
                  labelText: 'Kelurahan',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down_circle,
                        color: Color(0XFF427CEF)),
                    onPressed: () {
                      _nextScreenVillage(context, _prov.districtId);
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0, left: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 35.0,
                    child: TextFormField(
                      controller: rtCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'RT',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 35.0,
                    child: TextFormField(
                      controller: rwCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'RW',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      // width: 268,
                      margin: EdgeInsets.only(right: 10),
                      child: TextFormField(
                        controller: portalCodeCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Portal Code',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: buildingConditionCtrl,
                decoration: InputDecoration(
                  labelText: 'Building Condition',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down_circle,
                        color: Color(0XFF427CEF)),
                    onPressed: () {
                      _nextScreenBuildingType(context);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                          'Apakah lokasi pemasangan sama dengan lokasi kantor? '),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CustomSwitch(
                    activeColor: Color(0xFF427CEF),
                    value: isSwitchedLokasiKantor,
                    onChanged: (value) {
                      //print("VALUE : $value");
                      setState(() {
                        isSwitchedLokasiKantor = value;
                        if (isSwitchedLokasiKantor == true) {
                          switchIsSameOficeAddress = "1";
                        } else if (isSwitchedLokasiKantor == false) {
                          switchIsSameOficeAddress = "0";
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                    height: 50.0,
                    width: 140,
                    margin: EdgeInsets.fromLTRB(10.0, 25.0, 35.0, 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF427CEF),
                    ),
                    child: MaterialButton(
                      child: Text(
                        'Prev',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _tabController.index = 0;
                        });
                      },
                    )),
                Expanded(
                  child: Container(
                    height: 50.0,
                    width: 140,
                    margin: EdgeInsets.fromLTRB(35.0, 25.0, 10.0, 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF427CEF),
                    ),
                    child: MaterialButton(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (alamatCtrl.text != "" &&
                            provinceCtrl.text != "" &&
                            cityCtrl.text != "" &&
                            districtCtrl.text != "" &&
                            villageCtrl.text != "" &&
                            rtCtrl.text != "" &&
                            rwCtrl.text != "" &&
                            portalCodeCtrl.text != "" &&
                            buildingConditionCtrl.text != "") {
                          setState(() {
                            _tabController.index = 2;
                          });
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _gasUsage(BuildContext context) {
    // final _prov = Provider.of<RegistResidential>(context);
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Form(
        // key: _formKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10),
              child: Text(
                'Data Oprasional',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Divider(color: Colors.black),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: rPemanfaatanGasCtrl,
                decoration: InputDecoration(
                  labelText: 'Rencana Pemanfaatan Gas',
                  suffixIcon: IconButton(
                    icon: Image.asset(
                      'assets/icon_dropdown.png',
                      height: 20.0,
                    ),
                    // iconSize: 5.0,
                    onPressed: () {
                      _showDialogRPemanfaatanGas(context);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: jKerjaPerHariCtrl,
                decoration: InputDecoration(
                  labelText: 'Jumlah Jam Kerja per-Hari',
                  suffixIcon: IconButton(
                    icon: Image.asset(
                      'assets/icon_dropdown.png',
                      height: 20.0,
                    ),
                    // iconSize: 5.0,
                    onPressed: () {
                      _showDialogJKerjaPerHari(context);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.only(
                top: 5.0,
                left: 10,
                right: 10,
              ),
              // width: 295,
              child: TextFormField(
                controller: jKerjaPerMingguCtrl,
                decoration: InputDecoration(
                  labelText: 'Jumlah Jam Kerja per Minggu',
                  suffixIcon: IconButton(
                    icon: Image.asset(
                      'assets/icon_dropdown.png',
                      height: 20.0,
                    ),
                    // iconSize: 5.0,
                    onPressed: () {
                      _showDialogJKerjaPerMinggu(context);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10.0),
              child: Text(
                'Fuel Usage',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    margin: EdgeInsets.only(left: 10, right: 15),
                    child:
                        Text("Minyak Tanah", style: TextStyle(fontSize: 17))),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        Map<String, dynamic> minyakTanah = {
                          "fuel_id": "4",
                          "amount": "$value"
                        };
                        fuelUsageIndustrial
                            .removeWhere((item) => item['fuel_id'] == "4");
                        fuelUsageIndustrial.add(minyakTanah);
                      });
                    },
                    controller: mTanahCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Liter',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    margin: EdgeInsets.only(right: 15, left: 10),
                    child: Text("Batu Bara", style: TextStyle(fontSize: 17))),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        Map<String, dynamic> batuBara = {
                          "fuel_id": "5",
                          "amount": "$value"
                        };
                        fuelUsageIndustrial
                            .removeWhere((item) => item['fuel_id'] == "5");
                        fuelUsageIndustrial.add(batuBara);
                      });
                    },
                    controller: bBaraCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Kg',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    margin: EdgeInsets.only(right: 15, left: 10),
                    child: Text("Gasoline 88", style: TextStyle(fontSize: 17))),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        Map<String, dynamic> gasoline = {
                          "fuel_id": "6",
                          "amount": "$value"
                        };
                        fuelUsageIndustrial
                            .removeWhere((item) => item['fuel_id'] == "6");
                        fuelUsageIndustrial.add(gasoline);
                      });
                    },
                    controller: gasolineCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Liter',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    margin: EdgeInsets.only(right: 15, left: 10),
                    child: Text("Karosene", style: TextStyle(fontSize: 17))),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        Map<String, dynamic> karosene = {
                          "fuel_id": "7",
                          "amount": "$value"
                        };
                        fuelUsageIndustrial
                            .removeWhere((item) => item['fuel_id'] == "7");
                        fuelUsageIndustrial.add(karosene);
                      });
                    },
                    controller: karoseneCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Liter',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    margin: EdgeInsets.only(right: 15, left: 10),
                    child: Text("HSD (Solar)", style: TextStyle(fontSize: 17))),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        Map<String, dynamic> solar = {
                          "fuel_id": "8",
                          "amount": "$value"
                        };
                        fuelUsageIndustrial
                            .removeWhere((item) => item['fuel_id'] == "8");
                        fuelUsageIndustrial.add(solar);
                      });
                    },
                    controller: solarCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Liter',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    margin: EdgeInsets.only(right: 15, left: 10),
                    child: Text("IDO/MDF/MDO", style: TextStyle(fontSize: 17))),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        Map<String, dynamic> ido = {
                          "fuel_id": "9",
                          "amount": "$value"
                        };
                        fuelUsageIndustrial
                            .removeWhere((item) => item['fuel_id'] == "9");
                        fuelUsageIndustrial.add(ido);
                      });
                    },
                    controller: idoCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Liter',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    margin: EdgeInsets.only(right: 15, left: 10),
                    child: Text("MFO 180", style: TextStyle(fontSize: 17))),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        Map<String, dynamic> mfo = {
                          "fuel_id": "10",
                          "amount": "$value"
                        };
                        fuelUsageIndustrial
                            .removeWhere((item) => item['fuel_id'] == "10");
                        fuelUsageIndustrial.add(mfo);
                      });
                    },
                    controller: mfoCtrol,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Liter',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    margin: EdgeInsets.only(right: 15, left: 10),
                    child: Text("Gas Bumi", style: TextStyle(fontSize: 17))),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        Map<String, dynamic> gasBumi = {
                          "fuel_id": "11",
                          "amount": "$value"
                        };
                        fuelUsageIndustrial
                            .removeWhere((item) => item['fuel_id'] == "11");
                        fuelUsageIndustrial.add(gasBumi);
                      });
                    },
                    controller: gasBumiCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'm3',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              child: Divider(color: Colors.black),
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 30.0,
                left: 10,
                right: 10,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                          'Saya mengetahui jenis peralatan yang akan menggunakan gas'),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CustomSwitch(
                    activeColor: Color(0xFF427CEF),
                    value: isSwitched,
                    onChanged: (value) {
                      //print("VALUE : $value");
                      setState(() {
                        if (isSwitched = true) {
                          switchGasTools = "1";
                          isSwitched = value;
                        } else {
                          switchGasTools = "0";
                          isSwitched = value;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            if (isSwitched == false)
              InkWell(
                onTap: () {
                  _showDateTimePicker();
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 15.0,
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    enabled: true,
                    controller: datePickerCtrl,
                    decoration: InputDecoration(
                      labelText: 'Perkiraan Tanggal Dimulai',
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
            if (isSwitched == false)
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10.0),
                child: Text(
                  'Tanggal Gas pertama kali diserahkan di Lokasi Pemasangan',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                ),
              ),
            if (isSwitched == true)
              Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                    left: 10,
                    right: 10,
                  ),
                  // width: 295,
                  child: Row(
                    children: <Widget>[
                      Text('List Peralatan Menggunakan Gas'),
                      SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _screenPeralatanGas(context);
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.add),
                          ),
                        ),
                      )
                    ],
                  )),
            Row(
              children: <Widget>[
                Container(
                    height: 50.0,
                    width: 140,
                    margin: EdgeInsets.fromLTRB(10.0, 25.0, 35.0, 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF427CEF),
                    ),
                    child: MaterialButton(
                      child: Text(
                        'Prev',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _tabController.index = 1;
                        });
                      },
                    )),
                Expanded(
                  child: Container(
                      height: 50.0,
                      width: 140,
                      margin: EdgeInsets.fromLTRB(35.0, 25.0, 10.0, 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF427CEF),
                      ),
                      child: MaterialButton(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          if (rPemanfaatanGasCtrl.text != "" &&
                                  jKerjaPerHariCtrl.text != "" &&
                                  jKerjaPerMingguCtrl.text != "" ||
                              mTanahCtrl.text != "" ||
                              bBaraCtrl.text != "" ||
                              gasolineCtrl.text != "" ||
                              solarCtrl.text != "" ||
                              idoCtrl.text != "" ||
                              mfoCtrol.text != "" ||
                              gasBumiCtrl.text != "") {
                            setState(
                              () {
                                _tabController.index = 3;
                              },
                            );
                          }
                        },
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _reviewResi(BuildContext context) {
    final _prov = Provider.of<RegistResidential>(context);
    //print('ini hasil backnya: ${_prov.province_name ?? _province} ');
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Form(
        // key: _formKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(top: 10, left: 5, right: 5),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'Customer Data',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFF427CEF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Nama Perusahaan / Grup",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, right: 5),
                          child: Text(
                            fullNameCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Sektor Industri",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, top: 0, right: 5),
                          child: Text(
                            sektorIndustriCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Orang yang dapat dihubungi",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, right: 5),
                          child: Text(
                            ccPersonCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Phone Number",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            noPonselCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            emailCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(top: 10, left: 5, right: 5),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFF427CEF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Location Address",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            alamatCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Province",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, top: 0),
                          child: Text(
                            provinceCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "City/Region",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            cityCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "District",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            districtCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Village",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            villageCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "RT / RW / Postal Code",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "${rtCtrl.text} / ${rwCtrl.text} / ${portalCodeCtrl.text}",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Building Status",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 5.0,
                          ),
                          child: Text(
                            buildingConditionCtrl.text ?? " ",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(top: 10, left: 5, right: 5),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'Operational Data',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFF427CEF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 10),
                        child: Text(
                          "Usage Planning",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, top: 10),
                          child: Text(
                            rPemanfaatanGasCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 0),
                        child: Text(
                          "Working Hours Per Day",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, top: 0),
                          child: Text(
                            jKerjaPerHariCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "Days Per Week",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 5.0,
                            top: 8,
                          ),
                          child: Text(
                            jKerjaPerMingguCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(top: 10, left: 5, right: 5),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'Monthly Fuel Usage',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFF427CEF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  if (mTanahCtrl.text != "")
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            "Minyak Tanah",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, top: 8),
                            child: Text(
                              mTanahCtrl.text ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (bBaraCtrl.text != "")
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            "Batu Bara",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, top: 8),
                            child: Text(
                              bBaraCtrl.text ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (gasolineCtrl.text != "")
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            "Gasoline 88",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, top: 8),
                            child: Text(
                              gasolineCtrl.text ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (karoseneCtrl.text != "")
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            "Karosene",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, top: 8),
                            child: Text(
                              karoseneCtrl.text ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (solarCtrl.text != "")
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            "HSD (Solar)",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, top: 8),
                            child: Text(
                              solarCtrl.text ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (idoCtrl.text != "")
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            "IDO/MDF/MDO",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, top: 8),
                            child: Text(
                              idoCtrl.text ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (mfoCtrol.text != "")
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            "MFO 180",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, top: 8),
                            child: Text(
                              mfoCtrol.text ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (gasBumiCtrl.text != "")
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            "Gas Bumi",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            ':',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, top: 8),
                            child: Text(
                              gasBumiCtrl.text ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(top: 10, left: 5, right: 5),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'Gas Equipment List',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFF427CEF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: gasToolUsageIndustrial.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return i < gasToolUsageIndustrial.length
                          ? _buildRowGasEquip(gasToolUsageIndustrial[i])
                          : SizedBox(
                              height: 10.0,
                            );
                    },
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 5, right: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                          'Apakah lokasi pemasangan sama dengan lokasi kantor?'),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 55.0,
                    child: Transform.scale(
                      scale: 1.50,
                      child: Switch(
                        value: isSwitchedLokasiKantor,
                        activeTrackColor: Colors.blue[400],
                        activeColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 5, right: 5),
              child: TextFormField(
                enabled: false,
                controller: datePickerCtrl,
                decoration: InputDecoration(
                  labelText: 'Perkiraan Tanggal Dimulai',
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 0,
              color: Color(0xFFD3D3D3),
              margin: EdgeInsets.only(top: 20, left: 5, right: 5),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 5),
                  Icon(
                    Icons.error,
                    size: 45,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(right: 15, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            Translations.of(context).text(
                                'ff_residential_review_tv_terms_and_condition_message'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                        Text(
                            Translations.of(context).text(
                                'ff_residential_review_tv_terms_and_condition_item_1'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                        Text(
                            Translations.of(context).text(
                                'ff_residential_review_tv_terms_and_condition_item_2'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                    height: 50.0,
                    width: 140,
                    margin: EdgeInsets.fromLTRB(5.0, 25.0, 35.0, 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF427CEF),
                    ),
                    child: MaterialButton(
                      // minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        'Prev',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _tabController.index = 2;
                        });
                      },
                    )),
                Expanded(
                  child: Container(
                    height: 50.0,
                    margin: EdgeInsets.fromLTRB(0.0, 25.0, 5.0, 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF427CEF),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        'SEND',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        postRegisterIndustri(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////
  Widget _showDialogRPemanfaatanGas(BuildContext cotext) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              content: Container(
                  child: SingleChildScrollView(
                      child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Rencana Pemanfaatan Gas'),
                  Divider(),
                  InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text('Bahan Bakar'),
                        ),
                        Divider(),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        rPemanfaatanGasCtrl.text = 'Bahan Bakar';
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text('Bahan Baku'),
                        ),
                        Divider(),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        rPemanfaatanGasCtrl.text = 'Bahan Baku';
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                ],
              ))));
        });
  }

  Widget _showDialogJKerjaPerHari(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
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

  Widget _showDialogJKerjaPerMinggu(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
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
                        });
                        Navigator.pop(context, 'hhh');
                      },
                    ),
                ],
              ))));
        });
  }

  void _screenPeralatanGas(BuildContext context) async {
    final gasToolUsageIndustrialVal = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JenisPeralatan(
                gasToolUsageIndustrialVal: gasToolUsageIndustrial)));
    setState(() {
      if (gasToolUsageIndustrialVal != null) {
        gasToolUsageIndustrial.add(gasToolUsageIndustrialVal);
      } else {
        gasToolUsageIndustrial.remove(null);
      }
    });
  }

  void _nextScreenSectorIndustri(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchDropDown(
                data: getSectorIndustry(context), title: 'Sector Industri')));
    setState(() {
      sektorIndustriCtrl.text = result;
    });
  }

  void _nextScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchDropDown(
                data: getProvinces(context), title: 'Province')));
    setState(() {
      provinceCtrl.text = result;
    });
  }

  void _nextScreenCity(BuildContext context, String provId) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SearchDropDown(data: getCity(context, provId), title: 'City')));
    setState(() {
      cityCtrl.text = result;
    });
  }

  void _nextScreenDistrict(BuildContext context, String townId) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchDropDown(
                data: getDistrict(context, townId), title: 'District')));
    setState(() {
      districtCtrl.text = result;
    });
  }

  void _nextScreenVillage(BuildContext context, String distId) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchDropDown(
                data: getVillage(context, distId), title: 'Village')));
    setState(() {
      villageCtrl.text = result;
    });
  }

  void _nextScreenBuildingType(BuildContext context) async {
    //print('RESULt');
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchDropDown(
                data: getBuildingType(context), title: 'Building Type')));

    setState(() {
      buildingConditionCtrl.text = result;
    });
  }

  Widget _buildRowGasEquip(gasToolUsageIndustrialVal) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 15.0),
              child: CircleAvatar(
                radius: 7,
                backgroundColor: Color(0xFF4578EF),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(gasToolUsageIndustrialVal['name']),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                      gasToolUsageIndustrialVal['fuel_consumption_per_month'] ??
                          ""),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                      "${gasToolUsageIndustrialVal['total_work_days']} hari @ ${gasToolUsageIndustrialVal['total_work_hours']} jam"),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(gasToolUsageIndustrialVal['fuel_id']),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(gasToolUsageIndustrialVal['pressure'] ?? ""),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                        gasToolUsageIndustrialVal['estimation_start_date'] ??
                            ""),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<PostRegisterResidential> postRegisterIndustri(
      BuildContext context) async {
    final _provRegResidential = Provider.of<RegistResidential>(context);
    var responseTokenBarrer = await http
        .post('https://relyon-api.pgn.co.id/oauth/access_token', body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'client_credentials'
    });
    //print('LOKASI $switchIsSameOficeAddress');
    AuthSalesRegit _auth =
        AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));
    var body = json.encode({
      "communication_media_id": "1",
      "status_location_id": "2",
      "building_type_id": "${_provRegResidential.buildingTypeId}",
      "electrical_power_id": "",
      "geo_province_id": "${_provRegResidential.province_id}",
      "geo_town_id": "${_provRegResidential.townID}",
      "geo_district_id": "${_provRegResidential.districtId}",
      "geo_village_id": "${_provRegResidential.villageId}",
      "idcard_number": "",
      "name": "${fullNameCtrl.text}",
      "mobile_phone": "+62${noPonselCtrl.text}",
      "address": "${alamatCtrl.text}",
      "rt": "${rtCtrl.text}",
      "rw": "${rwCtrl.text}",
      "email": "${emailCtrl.text}",
      "postal_code": "${portalCodeCtrl.text}",
      "building_area": "1",
      "idcard_type_id": "1",
      "idcard_url":
          "images/idcard/1473489068-7feef760-34b8-4be7-b05e-f31fa836c7c2.png",
      "signature_url":
          "/images/signature/1479548092-e9ffabf8-2b22-4d22-bae6-a343d915e822.png",
      "electricity_bill_url": "",
      "is_governance_property": "1",
      "registered_by": "1",
      "registered_date": "${DateTime.now().millisecondsSinceEpoch}",
      "latitude": "",
      "longitude": "",
      "status_location_other": "",
      "building_type_other": "",
      "sector_industry_id": "1",
      "building_condition_id": "${_provRegResidential.buildingTypeIdBisnis}",
      "gas_usage_plan_id": "1",
      "pic_name": "${ccPersonCtrl.text}",
      "pic_email": "${emailCtrl.text}",
      "pic_mobile_phone": "+62${noPonselCtrl.text}",
      "total_work_hours_per_day": "${jKerjaPerHariCtrl.text}",
      "total_work_days_per_week": "${jKerjaPerMingguCtrl.text}",
      "estimation_start_date": "${dateTimeSelected ?? DateTime.now()}",
      "is_same_office_address": switchIsSameOficeAddress,
      "is_gas_tool_filled": "1",
      "fuel_usages": fuelUsageIndustrial,
      "custom_gas_tool_usages": gasToolUsageIndustrial,
    });
    //print("BODY REGISTER Industrial: $body");
    //print("BODY GAS TOOLS Industrial: $gasToolUsageIndustrial");
    //print("BODY FUEL USAGE Industrial: $fuelUsageIndustrial");
    var responseRegisIndustrial = await http.post(
        'https://relyon-api.pgn.co.id/v1/industry-registration-forms',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_auth.accessToken}'
        },
        body: body);
    //print("Hasil REGISTER Industrial: ${responseRegisIndustrial.body}");
    if (responseRegisIndustrial.statusCode == 200) {
      PostRegisterResidential postRegisterResidential =
          PostRegisterResidential.fromJson(
              json.decode(responseRegisIndustrial.body));
      successAlert(context, postRegisterResidential.formId);
    } else {
      PostRegisterResidential postRegisterResidential =
          PostRegisterResidential.fromJson(
              json.decode(responseRegisIndustrial.body));
      failedAlert(context, postRegisterResidential.message);
    }
  }
}

Future<bool> failedAlert(BuildContext context, String message) {
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
    title: "Failed",
    content: Column(
      children: <Widget>[
        SizedBox(height: 5),
        Text(
          message ?? '',
          style: TextStyle(
              color: Color(0xFF707070),
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
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.red,
        child: Text(
          "OK",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )
    ],
  ).show();
}

Future<bool> successAlert(BuildContext context, String formID) {
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
    title: "Success",
    content: Column(
      children: <Widget>[
        SizedBox(height: 5),
        Text(
          Translations.of(context).text('ff_login_dialog_success_text') ?? '',
          style: TextStyle(
              color: Color(0xFF707070),
              fontSize: 17,
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          Translations.of(context).text('f_residential_thank_you_message') ??
              '',
          style: TextStyle(color: Color(0xFF707070), fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          "Form Id : ${formID ?? ''}",
          style: TextStyle(
              color: Color(0xFF707070),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10)
      ],
    ),
    buttons: [
      DialogButton(
        width: 130,
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        color: Colors.green,
        child: Text(
          "OK",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )
    ],
  ).show();
}

class GasUsageModel {
  final String title;
  final String value;
  GasUsageModel(this.title, this.value);
}

Future<AuthSales> fetchPostReg(BuildContext context) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });

  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('access_token_regis', _auth.accessToken);
  prefs.setString('token_type', _auth.tokenType);

  return AuthSales.fromJson(json.decode(responseTokenBarrer.body));
}

Future<GetProvinces> getSectorIndustry(BuildContext context) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  //print('Response _auth sales ${responseTokenBarrer.body}');
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseProvinces =
      await http.get('${UrlCons.prodRelyonUrl}v1/sector-industry', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseProvinces.body));
}

Future<GetProvinces> getProvinces(BuildContext context) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  //print('Response _auth sales ${responseTokenBarrer.body}');
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseProvinces =
      await http.get('${UrlCons.prodRelyonUrl}v1/provinces', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseProvinces.body));
}

Future<GetProvinces> getCity(BuildContext context, String provID) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseCity = await http
      .get('${UrlCons.prodRelyonUrl}v1/provinces/$provID/towns', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseCity.body));
}

Future<GetProvinces> getDistrict(BuildContext context, String townID) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseDistrict = await http
      .get('${UrlCons.prodRelyonUrl}v1/towns/$townID/districts', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseDistrict.body));
}

Future<GetProvinces> getVillage(BuildContext context, String distID) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseVillage = await http
      .get('${UrlCons.prodRelyonUrl}v1/districts/$distID/villages', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseVillage.body));
}

Future<GetProvinces> getBuildingType(BuildContext context) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseBuildingType =
      await http.get('${UrlCons.prodRelyonUrl}v1/building-condition', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseBuildingType.body));
}
