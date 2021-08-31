import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/calculators.dart';
import 'package:pgn_mobile/screens/calculator/widgets/result.dart';

class CalBoiler extends StatefulWidget {
  @override
  CalBoilerState createState() => CalBoilerState();
}

class CalBoilerState extends State<CalBoiler> {
  TextEditingController _oneCtlr = new TextEditingController();
  TextEditingController _twoCtlr = new TextEditingController();
  TextEditingController _triCtlr = new TextEditingController();
  TextEditingController _fourCtlr = new TextEditingController();
  TextEditingController _fiveCtlr = new TextEditingController();
  TextEditingController _sixCtlr = new TextEditingController();
  TextEditingController _sevenCtlr = new TextEditingController();
  TextEditingController _eightCtlr = new TextEditingController();
  String _oneUnit,
      _twoUnit,
      _triUnit,
      _fourUnit,
      _fiveUnit,
      _sixUnit,
      _sevenUnit,
      _eightHint,
      _eightUnit;
  String titleIndex, kategoriIndex, tekananUap, suhuAir;
  double kaloriIndex, masaUap, efisiensi, pDefault, volumeElpiji;
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<CalculatorsEnergy>(context);
    setState(() {
      _oneCtlr.text = _prov.oneBoiValConv;
      _twoCtlr.text = _prov.twoBoiValConv;
      _triCtlr.text = _prov.triBoiHintConv;
      // _fourCtlr.text = _prov.fourBoiHintConv;
      // _fiveCtlr.text = _prov.fiveBoiHintConv;
      _sixCtlr.text = _prov.sixBoiHintVal;
      _sevenCtlr.text = _prov.sevenBoiHIntConv;
      _eightHint = _prov.eightBoiHintConv;
      _oneUnit = _prov.oneBoiUnit;
      _twoUnit = _prov.twoBoiUnit;
      _triUnit = _prov.triBoiUnit;
      _fourUnit = _prov.fourBoiUnit;
      _fiveUnit = _prov.fiveBoiUnit;
      _sixUnit = _prov.sixBoiUnit;
      _sevenUnit = _prov.sevenBoiUnit;
      _eightUnit = _prov.eightBoiUnit;
    });
    return ListView(
      shrinkWrap: true,
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
                kategoriIndex = _oneCtlr.text;
              });
            },
            decoration: InputDecoration(
              hintText: 'Volume',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              suffixIcon: IconButton(
                icon: Image.asset(
                  'assets/icon_dropdown.png',
                  height: 20.0,
                ),
                onPressed: () {
                  _showDialogType(context);
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
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          padding: EdgeInsets.only(top: 5.0),
          child: TextField(
            controller: _twoCtlr,
            onChanged: (value) {
              setState(() {
                titleIndex = _twoCtlr.text;
              });
            },
            decoration: InputDecoration(
              hintText: 'Solar',
              labelStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
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
            // controller: _triCtlr,
            onChanged: (value) {
              setState(() {
                kaloriIndex =
                    double.parse(value) ?? double.parse(_triCtlr.text);
              });
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: _triCtlr.text,
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    _triUnit ?? 'Kkal/Kg',
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
            controller: _fourCtlr,
            onChanged: (value) {
              setState(() {
                // masaUap = double.parse(_fourCtlr.text);
                // print('MASA UAP: $titleIndex');
              });
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: 'Masa Uap',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    _fourUnit ?? 'Kg/Jam',
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
            controller: _fiveCtlr,
            onChanged: (value) {
              setState(() {
                // if (_oneCtlr.text == 'Volume')
                // efisiensi = double.parse(_fiveCtlr.text);
                // else if(_oneCtlr.text == 'Efisiensi')
                // efisiensi = double.parse(_fiveCtlr.text);
                // print('MASA UAP: $titleIndex');
              });
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: _prov.fiveBoiHintConv ?? 'Volume',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    _fiveUnit ?? '%',
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
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          padding: EdgeInsets.only(top: 5.0),
          child: TextField(
            controller: _sixCtlr,
            onChanged: (value) {
              setState(() {
                tekananUap = _sixCtlr.text;
              });
            },
            decoration: InputDecoration(
              hintText: 'Pilih Tekanan Uap',
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
                  _showDialogTekananUap(context);
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
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          padding: EdgeInsets.only(top: 5.0),
          child: TextField(
            controller: _sevenCtlr,
            onChanged: (value) {
              setState(() {
                suhuAir = _sevenCtlr.text;
                print('SUHU AIR: $suhuAir');
              });
            },
            decoration: InputDecoration(
              hintText: 'Pilih Suhu Air',
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
                  _showDialogSuhuAir(context);
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
            controller: _eightCtlr,
            onChanged: (value) {
              setState(() {
                // pDefault = double.parse(_eightCtlr.text);
                // print('P DEFAULT: $pDefault');
              });
            },
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: '${_eightHint ?? 860}',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    'Kg/m3',
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
                        color: Color(0xFF427CEF), fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(25.0, 30.0, 10.0, 30.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Color(0xFF427CEF),
                ),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text(
                    'HITUNG',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print('A: ${_fiveCtlr.text}');
                    _oneCtlr.text.isEmpty
                        ? _validate = true
                        : _validate = false;
                    if (_fiveCtlr.text != '' ||
                        _oneCtlr.text != '' ||
                        _twoCtlr.text != '' ||
                        _triCtlr.text != '' ||
                        _fourCtlr.text != '')
                      print('INI UNITNAY : ${_prov.triBoiUnit}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsBoiler(
                          _twoCtlr.text,
                          _oneCtlr.text,
                          _sixCtlr.text,
                          _sevenCtlr.text,
                          double.parse(_triCtlr.text),
                          double.parse(_fourCtlr.text),
                          double.parse(_fiveCtlr.text),
                          double.parse(_eightCtlr.text ?? 860),
                          volumeElpiji,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ],
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
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Bahan Bakar'),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Elpiji'),
                    ),
                    onTap: () {
                      setState(() {
                        if (_oneCtlr.text == 'Volume')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Elpiji',
                              triBoiHintConv: '11200',
                              fiveBoiHintConv: 'Efisiensi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '493',
                              triBoiUnit: 'Kkal/Kg',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: '%',
                              eightBoiUnit: 'Kg/m3');
                        else if (_oneCtlr.text == 'Efisiensi')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Elpiji',
                              triBoiHintConv: '11200',
                              fiveBoiHintConv: 'Volume Elpiji',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '493',
                              triBoiUnit: 'Kkal/Kg',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: 'Kg',
                              eightBoiUnit: 'Kg/m3');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Solar'),
                    ),
                    onTap: () {
                      setState(() {
                        if (_oneCtlr.text == 'Volume')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Solar',
                              triBoiHintConv: '9063',
                              fiveBoiHintConv: 'Efisiensi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '860',
                              triBoiUnit: 'Kkal/liter',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: '%',
                              eightBoiUnit: 'Kg/m3');
                        else if (_oneCtlr.text == 'Efisiensi')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Solar',
                              triBoiHintConv: '9063',
                              fiveBoiHintConv: 'Volume Solar',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '860',
                              triBoiUnit: 'Kkal/liter',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: 'liter',
                              eightBoiUnit: 'Kg/m3');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Premium'),
                    ),
                    onTap: () {
                      setState(() {
                        if (_oneCtlr.text == 'Volume')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Premium',
                              triBoiHintConv: '7840',
                              fiveBoiHintConv: 'Efisiensi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '750',
                              triBoiUnit: 'Kkal/liter',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: '%',
                              eightBoiUnit: 'Kg/m3');
                        else if (_oneCtlr.text == 'Efisiensi')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Premium',
                              triBoiHintConv: '7840',
                              fiveBoiHintConv: 'Volume Premium',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '750',
                              triBoiUnit: 'Kkal/liter',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: 'liter',
                              eightBoiUnit: 'Kg/m3');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Minyak Tanah'),
                    ),
                    onTap: () {
                      setState(() {
                        if (_oneCtlr.text == 'Volume')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Minyak Tanah',
                              triBoiHintConv: '8840',
                              fiveBoiHintConv: 'Efisiensi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '830',
                              triBoiUnit: 'Kkal/liter',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: '%',
                              eightBoiUnit: 'Kg/m3');
                        else if (_oneCtlr.text == 'Efisiensi')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Minyak Tanah',
                              triBoiHintConv: '8840',
                              fiveBoiHintConv: 'Volume Minyak Tanah',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '830',
                              triBoiUnit: 'Kkal/liter',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: 'liter',
                              eightBoiUnit: 'Kg/m3');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Residu'),
                    ),
                    onTap: () {
                      setState(() {
                        if (_oneCtlr.text == 'Volume')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Residu',
                              triBoiHintConv: '8958',
                              fiveBoiHintConv: 'Efisiensi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '850',
                              triBoiUnit: 'Kkal/liter',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: '%',
                              eightBoiUnit: 'Kg/m3');
                        else if (_oneCtlr.text == 'Efisiensi')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Residu',
                              triBoiHintConv: '8958',
                              fiveBoiHintConv: 'Volume Residu',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '850',
                              triBoiUnit: 'Kkal/liter',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: 'liter',
                              eightBoiUnit: 'Kg/m3');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Gas Bumi (CNG/LNG)'),
                    ),
                    onTap: () {
                      setState(() {
                        if (_oneCtlr.text == 'Volume')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Gas Bumi (CNG/LNG)',
                              triBoiHintConv: '8900',
                              fiveBoiHintConv: 'Efisiensi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '0.6787',
                              triBoiUnit: 'Kkal/m3',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: '%',
                              eightBoiUnit: 'Kg/m3');
                        else if (_oneCtlr.text == 'Efisiensi')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Gas Bumi (CNG/LNG)',
                              triBoiHintConv: '8900',
                              fiveBoiHintConv: 'Volume Gas Bumi CNG/LNG)',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '0.6787',
                              triBoiUnit: 'Kkal/m3',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: 'm3',
                              eightBoiUnit: 'Kg/m3');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Batu Bara'),
                    ),
                    onTap: () {
                      setState(() {
                        if (_oneCtlr.text == 'Volume')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Batu Bara',
                              triBoiHintConv: '5100',
                              fiveBoiHintConv: 'Efisiensi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '1105',
                              triBoiUnit: 'Kkal/Kg',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: '%',
                              eightBoiUnit: 'Kg/m3');
                        else if (_oneCtlr.text == 'Efisiensi')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Batu Bara',
                              triBoiHintConv: '5100',
                              fiveBoiHintConv: 'Volume Batu Bara',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '1105',
                              triBoiUnit: 'Kkal/Kg',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: 'Kg',
                              eightBoiUnit: 'Kg/m3');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Kayu Bakar'),
                    ),
                    onTap: () {
                      setState(() {
                        if (_oneCtlr.text == 'Volume')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Kayu Bakar',
                              triBoiHintConv: '4541',
                              fiveBoiHintConv: 'Efisiensi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '720',
                              triBoiUnit: 'Kkal/Kg',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: '%',
                              eightBoiUnit: 'Kg/m3');
                        else if (_oneCtlr.text == 'Efisiensi')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Kayu Bakar',
                              triBoiHintConv: '4541',
                              fiveBoiHintConv: 'Volume Kayu Bakar',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '720',
                              triBoiUnit: 'Kkal/Kg',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: 'Kg',
                              eightBoiUnit: 'Kg/m3');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Sekam Padi'),
                    ),
                    onTap: () {
                      setState(() {
                        if (_oneCtlr.text == 'Volume')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Sekam Padi',
                              triBoiHintConv: '2400',
                              fiveBoiHintConv: 'Efisiensi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '122',
                              triBoiUnit: 'Kkal/Kg',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: '%',
                              eightBoiUnit: 'Kg/m3');
                        else if (_oneCtlr.text == 'Efisiensi')
                          Provider.of<CalculatorsEnergy>(context).boiler(
                              twoBoiValConv: 'Sekam Padi',
                              triBoiHintConv: '2400',
                              fiveBoiHintConv: 'Volume Sekam Padi',
                              sixBoiHintVal: 'Pilih Tekanan Uap',
                              sevenBoiHIntConv: 'Pilih Suhu Air',
                              eightBoiHintConv: '122',
                              triBoiUnit: 'Kkal/Kg',
                              fourBoiUnit: 'Kg/Jam',
                              fiveBoiUnit: 'Kg',
                              eightBoiUnit: 'Kg/m3');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  )
                ],
              ));
        });
  }

  Widget _showDialogType(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Perhitungan'),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Volume'),
                    ),
                    onTap: () {
                      setState(() {
                        Provider.of<CalculatorsEnergy>(context).boiler(
                            oneBoiValConv: 'Volume',
                            fiveBoiUnit: 'Kg',
                            fiveBoiHintConv: 'Efisiensi');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      child: Text('Efisiensi'),
                    ),
                    onTap: () {
                      setState(() {
                        Provider.of<CalculatorsEnergy>(context).boiler(
                            oneBoiValConv: 'Efisiensi',
                            fiveBoiUnit: '%',
                            fiveBoiHintConv: 'Volume Solar');
                      });
                      Navigator.pop(context, 'hhh');
                    },
                  ),
                ],
              ));
        });
  }

  Widget _showDialogTekananUap(BuildContext context) {
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
                  Text('Pilih Tekanan Uap'),
                  Divider(),
                  for (var i = 1; i <= 15; i++)
                    InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text('$i bar'),
                          ),
                          Divider(),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          Provider.of<CalculatorsEnergy>(context).boiler(
                            sixBoiHintVal: '$i bar',
                          );
                        });
                        Navigator.pop(context, 'hhh');
                      },
                    ),
                ],
              ))));
        });
  }

  Widget _showDialogSuhuAir(BuildContext context) {
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
                  Text('Pilih Tekanan Uap'),
                  Divider(),
                  for (var i = 0; i <= 19; i++)
                    InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text('${i * 5} Celsius'),
                          ),
                          Divider(),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          Provider.of<CalculatorsEnergy>(context).boiler(
                            sevenBoiHIntConv: '${i * 5} Celsius',
                          );
                        });
                        Navigator.pop(context, 'hhh');
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
