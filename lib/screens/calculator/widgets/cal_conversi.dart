import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/calculators.dart';
import 'package:pgn_mobile/screens/calculator/widgets/result.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/language.dart';

class CalConversion extends StatefulWidget {
  final String sendBackData;
  final BuildContext context;

  @override
  CalConversion(this.sendBackData, this.context);
  CalConversionState createState() => CalConversionState(sendBackData, context);
}

class CalConversionState extends State<CalConversion> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _oneCtlr = TextEditingController();
  TextEditingController _twoCtlr = TextEditingController();
  TextEditingController _triCtlr = TextEditingController();
  TextEditingController _fourCtlr = TextEditingController();
  TextEditingController _fiveCtlr = TextEditingController();
  TextEditingController _sixCtlr = TextEditingController();
  TextEditingController _sevenCtlr = TextEditingController();
  TextEditingController _eightCtlr = TextEditingController();

  String _twoUnit,
      _triUnit,
      _fourUnit,
      _fiveUnit,
      _sixUnit,
      _sevenUnit,
      _eightUnit;
  String sendBackData;
  BuildContext context;
  String titleIndex;
  int kaloriIndex,
      hargaIndex,
      volumeIndex,
      hargaGasUSD,
      hargaGasIDR,
      kaloriGasBumi,
      kurs;
  CalConversionState(this.sendBackData, this.context);

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<CalculatorsEnergy>(context);
    final _lang = Provider.of<Language>(context);
    print('ni hasil provnya : ${_prov.twoValConv}');
    setState(() {
      _oneCtlr.text = _prov.oneValConv ?? 'Batu Bara';
      _twoCtlr.text = _prov.twoValConv ?? '5100';
      _triCtlr.text = _prov.triHintConv ?? 'Harga Batu Bara';
      _fourCtlr.text = _prov.fourHintConv ?? 'Volume Batu Bara';
      _fiveCtlr.text = _prov.fiveHintConv ?? 'Harga Gas USD';
      _sixCtlr.text = _prov.sixHintVal ?? 'Harga Gas IDR';
      _sevenCtlr.text = _prov.sevenHIntConv ?? 'Kalori Gas Bumi';
      _twoUnit = _prov.twoUnit;
      _triUnit = _prov.triUnit;
      _fourUnit = _prov.fourUnit;
      _fiveUnit = _prov.fiveUnit;
      _sixUnit = _prov.sixUnit;
      _sevenUnit = _prov.sevenUnit;
      _eightUnit = _prov.eightUnit;
      _eightCtlr.text = "Kurs";
      print('ininininin : $sendBackData');
    });

    return Form(
      key: _formKey,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            padding: EdgeInsets.only(top: 5.0),
            child: TextField(
              controller: _oneCtlr,
              onChanged: (value) {
                setState(() {
                  titleIndex = _oneCtlr.text;
                });
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Color(0xFFADADAD),
                ),
                suffixIcon: IconButton(
                  icon: Image.asset(
                    'assets/icon_dropdown.png',
                    height: 20.0,
                  ),
                  // iconSize: 5.0,
                  onPressed: () {
                    _showDialogs(context);
                  },
                ),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFADADAD), width: 1.5),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            padding: EdgeInsets.only(top: 5.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  kaloriIndex = int.parse(value) ?? _twoCtlr.text;
                });
              },
              keyboardType: TextInputType.numberWithOptions(),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                hintText: _twoCtlr.text,
                hintStyle: TextStyle(
                  color: Color(0xFFADADAD),
                ),
                suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 13, right: 15),
                    child: Text(
                      _twoUnit ?? 'Kkal/Kg',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFADADAD), width: 1.5),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            padding: EdgeInsets.only(top: 5.0),
            child: TextField(
              // controller: _triCtlr,
              // onFieldSubmitted: _onSubmitted,
              onChanged: (value) {
                setState(() {
                  hargaIndex = int.parse(value);
                });
              },
              keyboardType: TextInputType.numberWithOptions(),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                hintText: _triCtlr.text.toString(),
                hintStyle: TextStyle(
                  color: Color(0xFFADADAD),
                ),
                suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 13, right: 15),
                    child: Text(
                      _triUnit ?? '/Kg',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFADADAD), width: 1.5),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            padding: EdgeInsets.only(top: 5.0),
            child: TextField(
              // controller: _fourCtlr,
              onChanged: (value) {
                setState(() {
                  volumeIndex = int.parse(value);
                });
              },
              keyboardType: TextInputType.numberWithOptions(),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                hintText: _fourCtlr.text.toString(),
                hintStyle: TextStyle(
                  color: Color(0xFFADADAD),
                ),
                suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 13, right: 15),
                    child: Text(
                      _fourUnit ?? 'kg',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFADADAD), width: 1.5),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            padding: EdgeInsets.only(top: 5.0),
            child: TextField(
              // controller: _fiveCtlr,
              onChanged: (value) {
                setState(() {
                  hargaGasUSD = int.parse(value);
                });
              },
              keyboardType: TextInputType.numberWithOptions(),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                hintText: _fiveCtlr.text.toString(),
                hintStyle: TextStyle(
                  color: Color(0xFFADADAD),
                ),
                suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 13, right: 15),
                    child: Text(
                      _fiveUnit ?? 'USD/MMBTU',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFADADAD), width: 1.5),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            padding: EdgeInsets.only(top: 5.0),
            child: TextField(
              // controller: _sixCtlr,
              onChanged: (value) {
                setState(() {
                  hargaGasIDR = int.parse(value);
                });
              },
              keyboardType: TextInputType.numberWithOptions(),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                hintText: _sixCtlr.text.toString(),
                hintStyle: TextStyle(
                  color: Color(0xFFADADAD),
                ),
                suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 13, right: 15),
                    child: Text(
                      _sixUnit ?? 'Rp/m3',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFADADAD), width: 1.5),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            padding: EdgeInsets.only(top: 5.0),
            child: TextField(
              // controller: _sevenCtlr,
              onChanged: (value) {
                setState(() {
                  kaloriGasBumi = int.parse(value);
                });
              },
              keyboardType: TextInputType.numberWithOptions(),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                hintText: _sevenCtlr.text.toString(),
                suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 13, right: 15),
                    child: Text(
                      _sevenUnit ?? 'Kkal/m3',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFADADAD), width: 1.5),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            padding: EdgeInsets.only(top: 5.0),
            child: TextField(
              // controller: _eightCtlr,
              onChanged: (value) {
                setState(() {
                  kurs = int.parse(value);
                });
              },
              keyboardType: TextInputType.numberWithOptions(),
              // textInputAction: TextInputAction.next,
              // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                hintText: _eightCtlr.text.toString(),
                hintStyle: TextStyle(
                  color: Color(0xFFADADAD),
                ),
                suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 13, right: 15),
                    child: Text(
                      'Rp/USD',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFADADAD), width: 1.5),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Text('reset',
                      style: TextStyle(
                          color: Color(0xFF427CEF),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50.0,
                  margin: EdgeInsets.fromLTRB(25.0, 30.0, 10.0, 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xFF427CEF),
                  ),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      Translations.of(context)
                          .text('ff_calculator_boiler_bt_submit'),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsConversion(
                              _oneCtlr.text,
                              kaloriIndex ?? int.parse(_twoCtlr.text),
                              hargaIndex,
                              volumeIndex,
                              hargaGasUSD,
                              hargaGasIDR,
                              kaloriGasBumi,
                              kurs,
                              _fourUnit),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _showDialogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Fuel Type',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                'Select your fuel type',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  child: Text(
                    'Elpiji',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Provider.of<CalculatorsEnergy>(context).conversion(
                        oneValConv: 'Elpiji',
                        twoValConv: '11200',
                        triHintConv: 'Harga Elpiji',
                        fourHintConv: 'Volume Elpiji',
                        fiveHintConv: 'Harga Gas USD',
                        sixHintVal: 'Harga Gas IDR',
                        sevenHIntConv: 'Kalori Gas Bumi',
                        twoUnit: 'Kkal/Kg',
                        triUnit: '/Kg',
                        fourUnit: 'Kg',
                        fiveUnit: 'USD/MMBTU',
                        sixUnit: 'Rp/m3',
                        sevenUnit: 'Kkal/m3');
                  });
                  Navigator.pop(context, 'hhh');
                },
              ),
              Divider(color: Colors.grey[500]),
              InkWell(
                child: Container(
                  child: Text(
                    'Solar',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Provider.of<CalculatorsEnergy>(context).conversion(
                        oneValConv: 'Solar',
                        twoValConv: '9063',
                        triHintConv: 'Harga Solar',
                        fourHintConv: 'Volume Solar',
                        fiveHintConv: 'Harga Gas USD',
                        sixHintVal: 'Harga Gas IDR',
                        sevenHIntConv: 'Kalori Gas Bumi',
                        twoUnit: 'Kkal/liter',
                        triUnit: '/liter',
                        fourUnit: 'liter',
                        fiveUnit: 'USD/MMBTU',
                        sixUnit: 'Rp/m3',
                        sevenUnit: 'Kkal/m3');
                  });
                  Navigator.pop(context, 'hhh');
                },
              ),
              Divider(color: Colors.grey[500]),
              InkWell(
                child: Container(
                  child: Text(
                    'Premium',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Provider.of<CalculatorsEnergy>(context).conversion(
                        oneValConv: 'Premium',
                        twoValConv: '7840',
                        triHintConv: 'Harga Premium',
                        fourHintConv: 'Volume Premium',
                        fiveHintConv: 'Harga Gas USD',
                        sixHintVal: 'Harga Gas IDR',
                        sevenHIntConv: 'Kalori Gas Bumi',
                        twoUnit: 'Kkal/liter',
                        triUnit: '/liter',
                        fourUnit: 'liter',
                        fiveUnit: 'USD/MMBTU',
                        sixUnit: 'Rp/m3',
                        sevenUnit: 'Kkal/m3');
                  });
                  Navigator.pop(context, 'hhh');
                },
              ),
              Divider(color: Colors.grey[500]),
              InkWell(
                child: Container(
                  child: Text(
                    'Minyak Tanah',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Provider.of<CalculatorsEnergy>(context).conversion(
                        oneValConv: 'Minyak Tanah',
                        twoValConv: '8840',
                        triHintConv: 'Harga Minyak Tanah',
                        fourHintConv: 'Volume Minyak Tanah',
                        fiveHintConv: 'Harga Gas USD',
                        sixHintVal: 'Harga Gas IDR',
                        sevenHIntConv: 'Kalori Gas Bumi',
                        twoUnit: 'Kkal/liter',
                        triUnit: '/liter',
                        fourUnit: 'liter',
                        fiveUnit: 'USD/MMBTU',
                        sixUnit: 'Rp/m3',
                        sevenUnit: 'Kkal/m3');
                  });
                  Navigator.pop(context, 'hhh');
                },
              ),
              Divider(color: Colors.grey[500]),
              InkWell(
                child: Container(
                  child: Text(
                    'Residu',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Provider.of<CalculatorsEnergy>(context).conversion(
                        oneValConv: 'Residu',
                        twoValConv: '8958',
                        triHintConv: 'Harga Residu',
                        fourHintConv: 'Volume Residu',
                        fiveHintConv: 'Harga Gas USD',
                        sixHintVal: 'Harga Gas IDR',
                        sevenHIntConv: 'Kalori Gas Bumi',
                        twoUnit: 'Kkal/liter',
                        triUnit: '/liter',
                        fourUnit: 'liter',
                        fiveUnit: 'USD/MMBTU',
                        sixUnit: 'Rp/m3',
                        sevenUnit: 'Kkal/m3');
                  });
                  Navigator.pop(context, 'hhh');
                },
              ),
              Divider(color: Colors.grey[500]),
              InkWell(
                child: Container(
                  child: Text(
                    'Batu Bara',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Provider.of<CalculatorsEnergy>(context).conversion(
                        oneValConv: 'Batu Bara',
                        twoValConv: '5100',
                        triHintConv: 'Harga Batu Bara',
                        fourHintConv: 'Volume Batu Bara',
                        fiveHintConv: 'Harga Gas USD',
                        sixHintVal: 'Harga Gas IDR',
                        sevenHIntConv: 'Kalori Gas Bumi',
                        twoUnit: 'Kkal/Kg',
                        triUnit: '/Kg',
                        fourUnit: 'Kg',
                        fiveUnit: 'USD/MMBTU',
                        sixUnit: 'Rp/m3',
                        sevenUnit: 'Kkal/m3');
                  });
                  Navigator.pop(context, 'hhh');
                },
              ),
              Divider(color: Colors.grey[500]),
              InkWell(
                child: Container(
                  child: Text(
                    'Kayu Bakar',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Provider.of<CalculatorsEnergy>(context).conversion(
                        oneValConv: 'Kayu Bakar',
                        twoValConv: '4541',
                        triHintConv: 'Harga Kayu Bakar',
                        fourHintConv: 'Volume Kayu Bakar',
                        fiveHintConv: 'Harga Gas USD',
                        sixHintVal: 'Harga Gas IDR',
                        sevenHIntConv: 'Kalori Gas Bumi',
                        twoUnit: 'Kkal/Kg',
                        triUnit: '/Kg',
                        fourUnit: 'Kg',
                        fiveUnit: 'USD/MMBTU',
                        sixUnit: 'Rp/m3',
                        sevenUnit: 'Kkal/m3');
                  });
                  Navigator.pop(context, 'hhh');
                },
              ),
              Divider(color: Colors.grey[500]),
              InkWell(
                child: Container(
                  child: Text(
                    'Sekam Padi',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Provider.of<CalculatorsEnergy>(context).conversion(
                        oneValConv: 'Sekam Padi',
                        twoValConv: '2400',
                        triHintConv: 'Harga Sekam Padi',
                        fourHintConv: 'Volume Sekam Padi',
                        fiveHintConv: 'Harga Gas USD',
                        sixHintVal: 'Harga Gas IDR',
                        sevenHIntConv: 'Kalori Gas Bumi',
                        twoUnit: 'Kkal/Kg',
                        triUnit: '/Kg',
                        fourUnit: 'Kg',
                        fiveUnit: 'USD/MMBTU',
                        sixUnit: 'Rp/m3',
                        sevenUnit: 'Kkal/m3');
                  });
                  Navigator.pop(context, 'hhh');
                },
              )
            ],
          ),
        );
      },
    );
  }
}
