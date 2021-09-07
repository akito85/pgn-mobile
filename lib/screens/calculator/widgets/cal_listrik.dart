import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/calculators.dart';
import 'package:pgn_mobile/screens/calculator/widgets/result.dart';

class CalListrict extends StatefulWidget {
  @override
  CalListrictState createState() => CalListrictState();
}

class CalListrictState extends State<CalListrict> {
  TextEditingController _oneCtrl = new TextEditingController();
  TextEditingController _twoCtrl = new TextEditingController();
  TextEditingController _triCtrl = new TextEditingController();
  TextEditingController _fourCtrl = new TextEditingController();
  TextEditingController _fiveCtrl = new TextEditingController();
  TextEditingController _sixCtrl = new TextEditingController();
  TextEditingController _sevenCtrl = new TextEditingController();
  TextEditingController _tenCtrl = new TextEditingController();
  TextEditingController _elevenCtrl = new TextEditingController();
  TextEditingController _eightCtlr = new TextEditingController();
  TextEditingController _nineCtlr = new TextEditingController();
  TextEditingController _kursCtlr = new TextEditingController();
  String _tenHintVal, _nineUnit, _tenUnit;
  double dayaListrik,
      terhdapDaya,
      hargaLWBP,
      hargaWBP,
      jamOprasi,
      hariOprasi,
      jmlhJamBbnPuncak,
      kaloriKonversi,
      hargaKonversi,
      kurs,
      efesiensiMesin;
  String titleKonversi;

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<CalculatorsEnergy>(context);
    print('ni hasil provnya : ${_prov.nineListVal}');
    setState(() {
      // _oneCtrl.text = _prov.oneLisVal;
      _eightCtlr.text = _prov.eightLisVal ?? 'Batu Bara';
      _nineCtlr.text = _prov.nineListVal ?? '5100';
      _tenHintVal = _prov.tenListVal ?? 'Harga Batu Bara';
      _nineUnit = _prov.nineListUnit ?? 'Volume Batu Bara';
      _tenUnit = _prov.tenListUnit ?? 'Harga Gas USD';
      _kursCtlr.text = "Kurs";
    });

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          height: 50,
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          padding: EdgeInsets.only(top: 5.0),
          child: TextField(
            controller: _oneCtrl,
            onChanged: (value) {
              setState(() {
                dayaListrik = double.parse(_oneCtrl.text);
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: 'Daya Listrik',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    'KVA',
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
            controller: _twoCtrl,
            onChanged: (value) {
              setState(() {
                terhdapDaya = double.parse(_twoCtrl.text);
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: 'Persentase Terhadap Daya',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    '%',
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
            controller: _triCtrl,
            onChanged: (value) {
              setState(() {
                hargaLWBP = double.parse(_triCtrl.text);
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: 'Harga LWBP',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    'Rp/Kwh',
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
            controller: _fourCtrl,
            onChanged: (value) {
              setState(() {
                hargaWBP = double.parse(_fourCtrl.text);
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: 'Harga WBP',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    'Rp/Kwh',
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
            controller: _fiveCtrl,
            onChanged: (value) {
              setState(() {
                if (int.parse(_fiveCtrl.text) > 24 ||
                    int.parse(_fiveCtrl.text) < 1) {
                  hariOprasi = double.parse("1");
                  _fiveCtrl.text = "1";
                } else {
                  hariOprasi = double.parse(_fiveCtrl.text);
                  print('HARI OPRASI: $hariOprasi');
                }
                jamOprasi = double.parse(_fiveCtrl.text);
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: 'Jam Operasi',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    'Jam/Hari',
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
            controller: _sixCtrl,
            onChanged: (value) {
              setState(() {
                if (int.parse(_sixCtrl.text) > 7 ||
                    int.parse(_sixCtrl.text) < 1) {
                  hariOprasi = double.parse("1");
                  _sixCtrl.text = "1";
                } else {
                  hariOprasi = double.parse(_sixCtrl.text);
                }
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: 'Hari Operasi',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    'Hari/Minggu',
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
            controller: _sevenCtrl,
            onChanged: (value) {
              setState(() {
                jmlhJamBbnPuncak = double.parse(_sevenCtrl.text);
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: 'Jumlah Jam Beban Puncak',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    'Jam/Hari',
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
            controller: _eightCtlr,
            onChanged: (value) {
              setState(() {
                titleKonversi = _eightCtlr.text;
              });
            },
            decoration: InputDecoration(
              hintText: 'Batu Bara',
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
            controller: _nineCtlr,
            onChanged: (value) {
              setState(() {
                kaloriKonversi = double.parse(_nineCtlr.text);
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: '5100',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    'Kkal/Kg',
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
            controller: _tenCtrl,
            onChanged: (value) {
              setState(() {
                hargaKonversi = double.parse(_tenCtrl.text);
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              hintText: _tenHintVal ?? 'Harga Batu Bata',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    _tenUnit ?? 'Rp/Kg',
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
        if (_eightCtlr.text == "Elpiji")
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            padding: EdgeInsets.only(top: 5.0),
            child: TextField(
              // controller: _eightCtlr,
              onChanged: (value) {
                setState(() {
                  kurs = double.parse(value);
                  print('KURS: $kurs');
                });
              },
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: _kursCtlr.text.toString(),
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
        Container(
          height: 50,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
          padding: EdgeInsets.only(top: 5.0),
          child: TextField(
            controller: _elevenCtrl,
            onChanged: (value) {
              setState(() {
                efesiensiMesin = double.parse(_elevenCtrl.text);
                print('HARGA KONVERSI: $efesiensiMesin');
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              hintText: 'Efisiensi Mesin',
              hintStyle: TextStyle(
                color: Color(0xFFADADAD),
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 13, right: 15),
                  child: Text(
                    '%',
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
                            builder: (context) => ResultsListrik(
                                _eightCtlr.text,
                                dayaListrik,
                                terhdapDaya,
                                hargaLWBP,
                                hargaWBP,
                                jamOprasi,
                                hariOprasi,
                                jmlhJamBbnPuncak,
                                double.parse(_nineCtlr.text),
                                hargaKonversi,
                                kurs,
                                efesiensiMesin)));
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
            borderRadius: BorderRadius.circular(10.0),
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
                    Provider.of<CalculatorsEnergy>(context).listrict(
                      eightLisVal: 'Elpiji',
                      nineListVal: '11200',
                      tenListVal: 'Harga Elpiji',
                      nineListUnit: 'Kkal/Kg',
                      tenListUnit: 'Rp/Kg',
                    );
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
                    Provider.of<CalculatorsEnergy>(context).listrict(
                      eightLisVal: 'Solar',
                      nineListVal: '9063',
                      tenListVal: 'Harga Solar',
                      nineListUnit: 'Kkal/liter',
                      tenListUnit: 'Rp/liter',
                    );
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
                    Provider.of<CalculatorsEnergy>(context).listrict(
                      eightLisVal: 'Premium',
                      nineListVal: '7840',
                      tenListVal: 'Harga Premium',
                      nineListUnit: 'Kkal/liter',
                      tenListUnit: 'Rp/liter',
                    );
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
                    Provider.of<CalculatorsEnergy>(context).listrict(
                      eightLisVal: 'Minyak Tanah',
                      nineListVal: '8840',
                      tenListVal: 'Harga Minyak Tanah',
                      nineListUnit: 'Kkal/liter',
                      tenListUnit: 'Rp/liter',
                    );
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
                    Provider.of<CalculatorsEnergy>(context).listrict(
                      eightLisVal: 'Residu',
                      nineListVal: '8958',
                      tenListVal: 'Harga Residu',
                      nineListUnit: 'Kkal/liter',
                      tenListUnit: 'Rp/liter',
                    );
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
                    Provider.of<CalculatorsEnergy>(context).listrict(
                      eightLisVal: 'Gas Bumi (CNG/LNG)',
                      nineListVal: '8900',
                      tenListVal: 'Harga Gas Bumi (CNG/LNG)',
                      nineListUnit: 'Kkal/liter',
                      tenListUnit: 'Rp/liter',
                    );
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
                    Provider.of<CalculatorsEnergy>(context).listrict(
                      eightLisVal: 'Batu Bara',
                      nineListVal: '5100',
                      tenListVal: 'Harga Batu Bara',
                      nineListUnit: 'Kkal/Kg',
                      tenListUnit: 'Rp/Kg',
                    );
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
                    Provider.of<CalculatorsEnergy>(context).listrict(
                      eightLisVal: 'Kayu Bakar',
                      nineListVal: '4541',
                      tenListVal: 'Harga Kayu Bakar',
                      nineListUnit: 'Kkal/Kg',
                      tenListUnit: 'Rp/Kg',
                    );
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
                    Provider.of<CalculatorsEnergy>(context).listrict(
                      eightLisVal: 'Sekam Padi',
                      nineListVal: '2400',
                      tenListVal: 'Harga Sekam Padi',
                      nineListUnit: 'Kkal/Kg',
                      tenListUnit: 'Rp/Kg',
                    );
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
