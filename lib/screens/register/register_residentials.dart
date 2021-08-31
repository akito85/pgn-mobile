import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/register_residential.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pgn_mobile/models/auth_model.dart';
import 'package:pgn_mobile/models/provinces_model.dart';
import 'package:pgn_mobile/screens/register/widgets/dropdown.dart';
import 'package:provider/provider.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class RegisterResidentials extends StatefulWidget {
  final DataProvinces data;
  RegisterResidentials({this.data});
  @override
  RegisterResidentialsState createState() => RegisterResidentialsState(data);
}

class RegisterResidentialsState extends State<RegisterResidentials>
    with TickerProviderStateMixin {
  TextEditingController provinceCtrl = new TextEditingController();
  TextEditingController cityCtrl = new TextEditingController();
  TextEditingController districtCtrl = new TextEditingController();
  TextEditingController villageCtrl = new TextEditingController();
  TextEditingController buildingTypeCtrl = new TextEditingController();
  TextEditingController ownerCtrl = new TextEditingController();
  TextEditingController revFulNameCtrl = new TextEditingController();
  TextEditingController revIdCardNumCtrl = new TextEditingController();
  TextEditingController revPhoneNumCtrl = new TextEditingController();
  TextEditingController revEmailCtrl = new TextEditingController();
  TextEditingController revAlamatCtrl = new TextEditingController();
  TextEditingController revLBangunanCtrl = new TextEditingController();
  TextEditingController revTBangunanCtrl = new TextEditingController();
  TextEditingController revStatPemilikCtrl = new TextEditingController();
  TextEditingController rtCtrl = new TextEditingController();
  TextEditingController rwCtrl = new TextEditingController();
  TextEditingController postalCodeCtrl = new TextEditingController();
  TextEditingController revWatCtrl = new TextEditingController();

  DataProvinces data;
  RegisterResidentialsState(this.data);
  var _index = 0;
  String _province = 'select';
  String valueSwitch = "1";
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSwitched = true;
  //OLD STYLE USING COUNTER
  int _countLpj3Kg = 0;
  int _countLpj12Kg = 0;
  int _countLpj50Kg = 0;
  int _countMinyakTanah = 0;
  int _countGasBumi = 0;
  int _countKompor1 = 0;
  int _countKOmpor2 = 0;
  int _countKompor3 = 0;
  int _countKompor4 = 0;
  int _countKomporOven = 0;
  int _countDrayerGas = 0;
  int _countWaterHeater = 0;

  //NEW STYLE
  TextEditingController _countLpj3KgCtrl = new TextEditingController();
  TextEditingController _countLpj12KgCtrl = new TextEditingController();
  TextEditingController _countLpj50KgCtrl = new TextEditingController();
  TextEditingController _countMinyakTanahCtrl = new TextEditingController();
  TextEditingController _countGasBumiCtrl = new TextEditingController();
  TextEditingController _countKompor1Ctrl = new TextEditingController();
  TextEditingController _countKOmpor2Ctrl = new TextEditingController();
  TextEditingController _countKompor3Ctrl = new TextEditingController();
  TextEditingController _countKompor4Ctrl = new TextEditingController();
  TextEditingController _countKomporOvenCtrl = new TextEditingController();
  TextEditingController _countDrayerGasCtrl = new TextEditingController();
  TextEditingController _countWaterHeaterCtrl = new TextEditingController();
  List<Map<String, dynamic>> fuelUsage = [];
  List<Map<String, dynamic>> gasToolUsage = [];
  final listGasUsage = List<GasUsageModel>();
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
          title: Text('Register Residential'),
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
                            // setState(() {
                            _tabController.index = 0;
                            // });
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
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18, top: 15),
      child: Form(
        // key: _formKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                controller: revFulNameCtrl,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: revIdCardNumCtrl,
                decoration: InputDecoration(
                  labelText: 'ID Card Number',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
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
                      // width: 295,
                      child: TextFormField(
                        controller: revPhoneNumCtrl,
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
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                controller: revEmailCtrl,
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
                margin: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
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
                    if (revFulNameCtrl.text != "" &&
                        revIdCardNumCtrl.text != "" &&
                        revPhoneNumCtrl.text != "" &&
                        revEmailCtrl.text != "") {
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
    print('ini hasil backnya: ${_prov.province_name ?? _province} ');
    setState(
      () {
        provinceCtrl.text = _prov.province_name ?? '';
        cityCtrl.text = _prov.townName ?? '';
        districtCtrl.text = _prov.districtName ?? '';
        villageCtrl.text = _prov.villageName ?? '';
        buildingTypeCtrl.text = _prov.buildingTypeName ?? '';
        ownerCtrl.text = _prov.ownershipName ?? '';
        print("");
      },
    );
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18, top: 10),
      child: Form(
        // key: _formKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                controller: revAlamatCtrl,
                decoration: InputDecoration(
                  labelText: 'Location Address',
                ),
              ),
            ),
            InkWell(
              onTap: () {
                fetchPostReg(context);
                print('ini data dari regis: $getProvinces');
                _nextScreen(context);
              },
              child: Container(
                padding: EdgeInsets.only(top: 5.0),
                // width: 295,
                child: TextFormField(
                  enabled: true,
                  controller: provinceCtrl,
                  decoration: InputDecoration(
                    labelText: 'Province',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle,
                          color: Color(0XFF427CEF)),
                      iconSize: 28.0,
                      onPressed: () {
                        print('ini data dari regis: $getProvinces');
                        _nextScreen(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.only(top: 5.0),
                // width: 295,
                child: TextFormField(
                  controller: cityCtrl,
                  decoration: InputDecoration(
                    labelText: 'City/Region',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle,
                          color: Color(0XFF427CEF)),
                      iconSize: 28.0,
                      onPressed: () {
                        print("NEXT CITY");
                        _nextScreenCity(context, _prov.province_id);
                      },
                    ),
                  ),
                ),
              ),
              onTap: () {
                print("NEXT CITY");
                _nextScreenCity(context, _prov.province_id);
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                controller: districtCtrl,
                decoration: InputDecoration(
                  labelText: 'District',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down_circle,
                        color: Color(0XFF427CEF)),
                    iconSize: 28.0,
                    onPressed: () {
                      _nextScreenDistrict(context, _prov.townID);
                    },
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                controller: villageCtrl,
                decoration: InputDecoration(
                  labelText: 'Kelurahan',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down_circle,
                        color: Color(0XFF427CEF)),
                    iconSize: 28.0,
                    onPressed: () {
                      _nextScreenVillage(context, _prov.districtId);
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 35.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: rtCtrl,
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
                      keyboardType: TextInputType.number,
                      controller: rwCtrl,
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
                      child: TextFormField(
                        controller: postalCodeCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: revLBangunanCtrl,
                decoration: InputDecoration(
                  labelText: 'Building Size (m2)',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                controller: buildingTypeCtrl,
                decoration: InputDecoration(
                  labelText: 'Building Type',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down_circle,
                        color: Color(0XFF427CEF)),
                    iconSize: 28.0,
                    onPressed: () {
                      _nextScreenBuildingType(context);
                    },
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                controller: ownerCtrl,
                decoration: InputDecoration(
                  labelText: 'Ownership',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down_circle,
                        color: Color(0XFF427CEF)),
                    iconSize: 28.0,
                    onPressed: () {
                      _nextScreenOwner(context);
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        'Government Owned ?',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CustomSwitch(
                    activeColor: Color(0xFF427CEF),
                    value: isSwitched,
                    onChanged: (value) {
                      print("VALUE : $value");
                      setState(() {
                        isSwitched = value;
                        if (isSwitched == true) {
                          valueSwitch = "1";
                          print("SWITCH kepemilikan pemerintah: $valueSwitch");
                        } else {
                          valueSwitch = "0";
                          print("SWITCH kepemilikan pemerintah: $valueSwitch");
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
                    margin: EdgeInsets.fromLTRB(0.0, 25.0, 35.0, 20.0),
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
                    margin: EdgeInsets.fromLTRB(35.0, 25.0, 0.0, 20.0),
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
                        if (revAlamatCtrl.text != "" &&
                            cityCtrl.text != "" &&
                            districtCtrl.text != "" &&
                            villageCtrl.text != "" &&
                            rtCtrl.text != "" &&
                            rwCtrl.text != "" &&
                            postalCodeCtrl.text != "" &&
                            revLBangunanCtrl.text != "" &&
                            buildingTypeCtrl.text != "" &&
                            ownerCtrl.text != "") {
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
    final _prov = Provider.of<RegistResidential>(context);
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18, top: 10),
      child: Form(
        // key: _formKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 0.0, top: 10.0),
              child: Text(
                'Monthly Fuel Usage',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 8.0),
            Divider(),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Elpiji 3 kg ',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "1");
                        } else {
                          Map<String, dynamic> elpiji3Kg = {
                            "fuel_id": "1",
                            "amount": "${_countLpj3KgCtrl.text}"
                          };
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "1");
                          fuelUsage.add(elpiji3Kg);
                          _countLpj3Kg = int.parse(_countLpj3KgCtrl.text);
                          _prov.tabungVal3 = _countLpj3Kg.toString();
                          _prov.tabungName3 = 'Elpiji 3 kg (Tabung)';
                        }
                      });
                    },
                    controller: _countLpj3KgCtrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'Tabung',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Elpiji 12 kg ',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "2");
                        } else {
                          Map<String, dynamic> elpiji12Kg = {
                            "fuel_id": "2",
                            "amount": "${_countLpj12KgCtrl.text}"
                          };
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "2");
                          fuelUsage.add(elpiji12Kg);
                          _countLpj12Kg = int.parse(_countLpj12KgCtrl.text);
                          _prov.tabungVal12 = _countLpj12Kg.toString();
                          _prov.tabungName12 = 'Elpiji 12 kg (Tabung)';
                        }
                      });
                    },
                    controller: _countLpj12KgCtrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'Tabung',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Elpiji 50 kg',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "3");
                        } else {
                          Map<String, dynamic> elpiji50Kg = {
                            "fuel_id": "3",
                            "amount": "${_countLpj50KgCtrl.text}"
                          };
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "3");
                          fuelUsage.add(elpiji50Kg);
                          _countLpj50Kg = int.parse(_countLpj50KgCtrl.text);
                          _prov.tabungVal50 = _countLpj50Kg.toString();
                          _prov.tabungName50 = 'Elpiji 50 kg (Tabung)';
                        }
                      });
                    },
                    controller: _countLpj50KgCtrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'Tabung',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Minyak Tanah',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "4");
                        } else {
                          Map<String, dynamic> minyakTanah = {
                            "fuel_id": "4",
                            "amount": "${_countMinyakTanahCtrl.text}"
                          };
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "4");
                          fuelUsage.add(minyakTanah);
                          _countMinyakTanah =
                              int.parse(_countMinyakTanahCtrl.text);
                          _prov.mTanahVal = _countMinyakTanah.toString();
                          _prov.mTanahName = 'Minyak Tanah (Liter)';
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: _countMinyakTanahCtrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'Liter',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Gas Bumi',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "11");
                        } else {
                          Map<String, dynamic> gasBumi = {
                            "fuel_id": "11",
                            "amount": "${_countGasBumiCtrl.text}"
                          };
                          fuelUsage
                              .removeWhere((item) => item['fuel_id'] == "11");
                          fuelUsage.add(gasBumi);
                          _countGasBumi = int.parse(_countGasBumiCtrl.text);
                          _prov.gasBumiVal = _countGasBumi.toString();
                          _prov.gasBumiName = 'Gas Bumi (m3)';
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: _countGasBumiCtrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'm3',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 0.0, top: 10.0),
              child: Text(
                'Gas utilities',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 8.0),
            Divider(),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Kompor 1 Tungku',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          gasToolUsage
                              .removeWhere((item) => item['fuel_id'] == "7");
                        } else {
                          Map<String, dynamic> kompor1 = {
                            "gas_tool_id": "7",
                            "amount": "${_countKompor1Ctrl.text}"
                          };
                          gasToolUsage.removeWhere(
                              (item) => item['gas_tool_id'] == "7");
                          gasToolUsage.add(kompor1);
                          _countKompor1 = int.parse(_countKompor1Ctrl.text);
                          _prov.komVal1 = _countKompor1Ctrl.text;
                          _prov.komName1 = 'Kompor 1 Tungku';
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: _countKompor1Ctrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'buah',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Kompor 2 Tungku',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          gasToolUsage
                              .removeWhere((item) => item['fuel_id'] == "1");
                        } else {
                          Map<String, dynamic> kompor2 = {
                            "gas_tool_id": "1",
                            "amount": "${_countKOmpor2Ctrl.text}"
                          };
                          gasToolUsage.removeWhere(
                              (item) => item['gas_tool_id'] == "1");
                          gasToolUsage.add(kompor2);
                          _countKOmpor2 = int.parse(_countKOmpor2Ctrl.text);
                          print(
                              "Isi Gas Tool Usage Kompor 2 Min: $gasToolUsage");
                          _prov.komVal2 = _countKOmpor2.toString();
                          _prov.komName2 = 'Kompor 2 Tungku';
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: _countKOmpor2Ctrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'buah',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Kompor 3 Tungku',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          gasToolUsage
                              .removeWhere((item) => item['fuel_id'] == "3");
                        } else {
                          Map<String, dynamic> kompor3 = {
                            "gas_tool_id": "3",
                            "amount": "${_countKompor3Ctrl.text}"
                          };
                          gasToolUsage.removeWhere(
                              (item) => item['gas_tool_id'] == "3");
                          gasToolUsage.add(kompor3);
                          _countKompor3 = int.parse(_countKompor3Ctrl.text);

                          _prov.komVal3 = _countKompor3.toString();
                          _prov.komName3 = 'Kompor 3 Tungku';
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: _countKompor3Ctrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'buah',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Kompor 4 Tungku',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          gasToolUsage
                              .removeWhere((item) => item['fuel_id'] == "2");
                        } else {
                          Map<String, dynamic> kompor4 = {
                            "gas_tool_id": "2",
                            "amount": "${_countKompor4Ctrl.text}"
                          };
                          gasToolUsage.removeWhere(
                              (item) => item['gas_tool_id'] == "2");
                          gasToolUsage.add(kompor4);
                          _countKompor4 = int.parse(_countKompor4Ctrl.text);

                          _prov.komVal4 = _countKompor4.toString();
                          _prov.komName4 = 'Kompor 4 Tungku';
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: _countKompor4Ctrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'buah',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Oven',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          gasToolUsage
                              .removeWhere((item) => item['fuel_id'] == "4");
                        } else {
                          Map<String, dynamic> oven = {
                            "gas_tool_id": "4",
                            "amount": "${_countKomporOvenCtrl.text}"
                          };
                          gasToolUsage.removeWhere(
                              (item) => item['gas_tool_id'] == "4");
                          gasToolUsage.add(oven);
                          _countKomporOven =
                              int.parse(_countKomporOvenCtrl.text);

                          _prov.ovenVal = _countKomporOven.toString();
                          _prov.ovenName = 'Oven';
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: _countKomporOvenCtrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'buah',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Dryer Gas',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          gasToolUsage
                              .removeWhere((item) => item['fuel_id'] == "6");
                        } else {
                          Map<String, dynamic> drayerGas = {
                            "gas_tool_id": "6",
                            "amount": "${_countDrayerGasCtrl.text}"
                          };
                          gasToolUsage.removeWhere(
                              (item) => item['gas_tool_id'] == "6");
                          gasToolUsage.add(drayerGas);
                          _countDrayerGas = int.parse(_countDrayerGasCtrl.text);

                          _prov.dGasVal = _countDrayerGas.toString();
                          _prov.dGasName = 'Drayer Gas';
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: _countDrayerGasCtrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'buah',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    'Water Heater',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Container(
                  width: 140,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          gasToolUsage
                              .removeWhere((item) => item['fuel_id'] == "5");
                        } else {
                          Map<String, dynamic> waterHeater = {
                            "gas_tool_id": "5",
                            "amount": "${_countWaterHeaterCtrl.text}"
                          };
                          gasToolUsage.removeWhere(
                              (item) => item['gas_tool_id'] == "5");
                          gasToolUsage.add(waterHeater);
                          _countWaterHeater =
                              int.parse(_countWaterHeaterCtrl.text);

                          _prov.watHeatVal = _countWaterHeater.toString();
                          _prov.watHeatName = 'Water Heater';
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: _countWaterHeaterCtrl,
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
                    margin: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Text(
                      'buah',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              // width: 295,
              child: TextFormField(
                controller: revWatCtrl,
                decoration: InputDecoration(
                  labelText: 'Electric Power Installed',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_drop_down_circle,
                        color: Color(0XFF427CEF)),
                    onPressed: () {
                      _penggunaanListrik(context);
                    },
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                    height: 50.0,
                    width: 140,
                    margin: EdgeInsets.fromLTRB(0.0, 25.0, 35.0, 20.0),
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
                      margin: EdgeInsets.fromLTRB(35.0, 25.0, 0.0, 20.0),
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
                          if (_countLpj3KgCtrl.text != "" ||
                              _countLpj12KgCtrl.text != "" ||
                              _countLpj50KgCtrl.text != "" ||
                              _countMinyakTanahCtrl.text != "" ||
                              _countGasBumiCtrl.text != "" ||
                              _countKompor1Ctrl.text != "" ||
                              _countKOmpor2Ctrl.text != "" ||
                              _countKompor3Ctrl.text != "" ||
                              _countKompor4Ctrl.text != "" ||
                              _countKomporOvenCtrl.text != "" ||
                              _countDrayerGasCtrl.text != "" ||
                              _countWaterHeaterCtrl.text != "" ||
                              revWatCtrl.text != "") {
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
    print('ini hasil backnya: ${_prov.province_name ?? _province} ');
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Form(
        // key: _formKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 5, left: 10),
              child: Text(
                'Please make sure the data you have entered are correct',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF5C727D),
                  fontWeight: FontWeight.bold,
                ),
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
                      'Customer Data',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFF427CEF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 10),
                        child: Text(
                          "Full Name",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
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
                            revFulNameCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 0),
                        child: Text(
                          "ID Card Number",
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
                            revIdCardNumCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "Phone Number",
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
                          margin: EdgeInsets.only(left: 5.0, top: 8),
                          child: Text(
                            revPhoneNumCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "Email",
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
                          margin: EdgeInsets.only(left: 5.0, top: 8),
                          child: Text(
                            revEmailCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "Building Type",
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
                          margin: EdgeInsets.only(left: 5.0, top: 8),
                          child: Text(
                            buildingTypeCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "Ownership",
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
                            ownerCtrl.text ?? '-',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 10),
                        child: Text(
                          "Location Address",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
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
                            revAlamatCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 0),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "City/Region",
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
                            cityCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "District",
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
                            districtCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "Village",
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
                            villageCtrl.text ?? '-',
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "RT / RW / Postal Code",
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
                            "${rtCtrl.text} / ${rwCtrl.text} / ${postalCodeCtrl.text}",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "Building Size",
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
                            "${revLBangunanCtrl.text} m2",
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "Building Type",
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
                            buildingTypeCtrl.text ?? " ",
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
                  if (_countLpj3Kg != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.tabungName3,
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
                              _prov.tabungVal3 ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countLpj12Kg != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.tabungName12,
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
                              _prov.tabungVal12 ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countLpj50Kg != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.tabungName50,
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
                              _prov.tabungVal50 ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countMinyakTanah != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.mTanahName,
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
                              _prov.mTanahVal ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countGasBumi != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.gasBumiName,
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
                              _prov.gasBumiVal ?? '-',
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
                      'Gas Utilities',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFF427CEF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  if (_countKompor1 != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.komName1,
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
                              _prov.komVal1 ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countKOmpor2 != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.komName2,
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
                              _prov.komVal2 ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countKompor3 != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.komName3,
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
                              _prov.komVal3 ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countKompor4 != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.komName4,
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
                              _prov.komVal4 ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countKomporOven != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.ovenName,
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
                              _prov.ovenVal ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countDrayerGas != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.dGasName,
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
                              _prov.dGasVal ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  if (_countWaterHeater != 0)
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            _prov.watHeatName,
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
                              _prov.watHeatVal ?? '-',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 15.0, top: 8),
                        child: Text(
                          "Electric Power Installed",
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
                            "${revWatCtrl.text} Watt",
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

  void _penggunaanListrik(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchDropDownElectry(
                data: getPenggunaanListrik(context),
                title: 'Penggunaan Listrik')));
    setState(() {
      revWatCtrl.text = result;
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
    print('MASUK');
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchDropDown(
                data: getBuildingType(context), title: 'BuildingType')));

    setState(() {
      buildingTypeCtrl.text = result;
    });
  }

  void _nextScreenOwner(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SearchDropDown(data: getOwner(context), title: 'Ownership')));
    setState(() {
      ownerCtrl.text = result;
    });
  }

  Future<PostRegisterResidential> postRegisterIndustri(
      BuildContext context) async {
    final _provRegResidential = Provider.of<RegistResidential>(context);
    var responseTokenBarrer =
        await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
      'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
      'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
      'grant_type': 'client_credentials'
    });
    print('AccessTokens ${responseTokenBarrer.body}');
    AuthSalesRegit _auth =
        AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));
    var body = json.encode({
      "communication_media_id": "1",
      "status_location_id": "${_provRegResidential.ownershipId}",
      "building_type_id": "${_provRegResidential.buildingTypeId}",
      "electrical_power_id": "${_provRegResidential.powerInstalId}",
      "geo_province_id": "${_provRegResidential.province_id}",
      "geo_town_id": "${_provRegResidential.townID}",
      "geo_district_id": "${_provRegResidential.districtId}",
      "geo_village_id": "${_provRegResidential.villageId}",
      "idcard_number": "${revIdCardNumCtrl.text}",
      "name": "${revFulNameCtrl.text}",
      "mobile_phone": "+62${revPhoneNumCtrl.text}",
      "address": "${revAlamatCtrl.text}",
      "rt": "${rtCtrl.text}",
      "rw": "${rwCtrl.text}",
      "email": "${revEmailCtrl.text}",
      "postal_code": "${postalCodeCtrl.text}",
      "building_area": "1",
      "idcard_type_id": "1",
      "idcard_url":
          "images/idcard/1473489068-7feef760-34b8-4be7-b05e-f31fa836c7c2.png",
      "signature_url":
          "/images/signature/1479548092-e9ffabf8-2b22-4d22-bae6-a343d915e822.png",
      "electricity_bill_url": "",
      "is_governance_property": "$valueSwitch",
      "registered_by": "1",
      "registered_date": "${DateTime.now().millisecondsSinceEpoch}",
      "latitude": "",
      "longitude": "",
      "status_location_other": "",
      "building_type_other": "",
      "extension_zone_type_id": "1",
      "fuel_usages": fuelUsage,
      "gas_tool_usages": gasToolUsage
    });
    var responseRegisResidential =
        await http.post('${UrlCons.prodRelyonUrl}v1/registration-forms',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${_auth.accessToken}'
            },
            body: body);
    if (responseRegisResidential.statusCode == 200) {
      PostRegisterResidential postRegisterResidential =
          PostRegisterResidential.fromJson(
              json.decode(responseRegisResidential.body));
      successAlert(context, postRegisterResidential.formId);
    }
    // return PostRegisterResidential.fromJson(json.decode(responseRegisResidential.body));
  }
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
          'Your Form ID is : $formID' ?? '',
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
  print('AccessTokens ${responseTokenBarrer.body}');

  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('access_token_regis', _auth.accessToken);
  prefs.setString('token_type', _auth.tokenType);

  return AuthSales.fromJson(json.decode(responseTokenBarrer.body));
}

Future<GetProvinces> getProvinces(BuildContext context) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseProvinces =
      await http.get('${UrlCons.prodRelyonUrl}v1/provinces', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseProvinces.body));
}

Future<GetProvinces> getPenggunaanListrik(BuildContext context) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseProvinces =
      await http.get('${UrlCons.prodRelyonUrl}v1/electrical-powers', headers: {
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
  print('AccessTokens ${responseTokenBarrer.body}');
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseCity = await http
      .get('${UrlCons.prodRelyonUrl}v1/provinces/$provID/towns', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  print('Provinces ${responseCity.body}');
  return GetProvinces.fromJson(json.decode(responseCity.body));
}

Future<GetProvinces> getDistrict(BuildContext context, String townID) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  print('AccessTokens ${responseTokenBarrer.body}');
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseDistrict = await http
      .get('${UrlCons.prodRelyonUrl}v1/towns/$townID/districts', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  print('Provinces ${responseDistrict.body}');
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
  print('mASUKKAH');
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseBuildingType =
      await http.get('${UrlCons.prodRelyonUrl}v1/building-types', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseBuildingType.body));
}

Future<GetProvinces> getOwner(BuildContext context) async {
  var responseTokenBarrer =
      await http.post('${UrlCons.prodRelyonUrl}oauth/access_token', body: {
    'client_id': '0dUIDb81bBUsGDfDsYYHQ9wBujfjL9XWfH0ZoAzi',
    'client_secret': '0DTuUFYRPtWUFN2UbzSvzqZMzNsW4kAl4t4PTrtC',
    'grant_type': 'client_credentials'
  });
  AuthSalesRegit _auth =
      AuthSalesRegit.fromJson(json.decode(responseTokenBarrer.body));

  var responseBuildingType =
      await http.get('${UrlCons.prodRelyonUrl}v1/location-status', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${_auth.accessToken}'
  });

  return GetProvinces.fromJson(json.decode(responseBuildingType.body));
}
