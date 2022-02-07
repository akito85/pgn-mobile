import 'dart:ffi';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class ResultsConversion extends StatelessWidget {
  String titleIndex, _fourUnit;
  int kaloriIndex,
      hargaIndex,
      volumeIndex,
      hargaGasUSD,
      hargaGasIDR,
      kaloriGasBumi,
      kurs;
  ResultsConversion(
    this.titleIndex,
    this.kaloriIndex,
    this.hargaIndex,
    this.volumeIndex,
    this.hargaGasUSD,
    this.hargaGasIDR,
    this.kaloriGasBumi,
    this.kurs,
    this._fourUnit,
  );

  @override
  Widget build(BuildContext context) {
    int biaya = (hargaIndex * volumeIndex);
    double gasVolume = (kaloriIndex * volumeIndex) / kaloriGasBumi;
    double gasPriceId = (gasVolume * hargaGasIDR);
    double mmbtu = gasVolume * kaloriGasBumi / 252000;
    double gasPriceUsd = mmbtu * hargaGasUSD * kurs;
    double totalGasPrice = gasPriceId + gasPriceUsd;
    // int gasINTVOLUM = int.parse(gasVolume);
    double selisihBiaya = (biaya - totalGasPrice);
    final formatCurrency = new NumberFormat.currency(
        locale: "en_US", symbol: " ", decimalDigits: 0);

    //print('INI Kalori Gas Bumi: ${biaya.toInt()}');
    //print('INI harga Gas Bumi: $totalGasPrice');
    //print('INI Kalori Gas Bumi: $kaloriGasBumi');
    //print('INI harga Gas Bumi: $gasVolume');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          Translations.of(context).text('title_bar_calculator_result'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 15, left: 20),
                  child: Text(
                    '${Translations.of(context).text('f_calculator_conversion_tv_title')} $titleIndex ke Gas Bumi',
                    style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 2,
                  width: 55,
                  margin: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 10.0),
                  decoration: new BoxDecoration(
                    color: Colors.blue[300],
                    shape: BoxShape.rectangle,
                  ),
                  child: Text('            '),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 130,
                      margin: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        '$volumeIndex $_fourUnit $titleIndex',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 15),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0, top: 15),
                        child: Text(
                          ' ${formatCurrency.format(gasVolume)} m3 Gas Bumi',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 130,
                      margin: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        'Biaya $titleIndex',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 15),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0, top: 15),
                        child: Text(
                          ' Rp. ${formatCurrency.format(biaya)}',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 130,
                      margin: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        'Biaya Gas Bumi',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 15),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0, top: 15),
                        child: Text(
                          ' Rp. ${formatCurrency.format(totalGasPrice)}',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 130,
                      margin: EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                      child: Text(
                        'Selisih Biaya',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0, top: 15, bottom: 15),
                        child: Text(
                          ' Rp. ${formatCurrency.format(selisihBiaya)}',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//RESULT BOILER
class ResultsBoiler extends StatelessWidget {
  final String titleIndex, kategoriIndex, tekananUap, suhuAir;
  final double kaloriIndex, masaUap, efisiensi, pDefault, volumeElpiji;
  ResultsBoiler(
    this.titleIndex,
    this.kategoriIndex,
    this.tekananUap,
    this.suhuAir,
    this.kaloriIndex,
    this.masaUap,
    this.efisiensi,
    this.pDefault,
    this.volumeElpiji,
  );
  double hg,
      massaIndexA,
      massaIndexB,
      hf,
      hasilHG,
      hasilEfisiensi,
      hasilMasaUap,
      ghv;
  double gff = 0;
  String endTitle;
  String unit;
  double outputD;
  var f = NumberFormat('#,##0.0#', 'en_US');
  @override
  Widget build(BuildContext context) {
    if (titleIndex == 'Elpiji' ||
        titleIndex == 'Batu Bara' ||
        titleIndex == 'Kayi Bakar' ||
        titleIndex == 'Sekam Padi') {
      unit = 'Kkal/Kg';
    } else if (titleIndex == 'Gas Bumi (CNG/LNG)') {
      unit = 'Kkal/m3';
    } else {
      unit = 'Kkal/liter';
    }
    hgTable();
    hg = hg;
    hfTable();
    hf = hf;

    if (kategoriIndex == 'Volume') {
      if (unit == 'Kkal/Kg') {
        ghv = kaloriIndex;
        gff = (masaUap * (hg - hf)) / ((efisiensi / 100 * ghv));
        hasilEfisiensi = (efisiensi / 100) * kaloriIndex;
        massaIndexA = gff;
      } else if (unit == 'Kkal/liter') {
        ghv = kaloriIndex / pDefault * 1000;
        gff =
            ((masaUap * (hg - hf)) / (efisiensi / 100 * ghv)) / pDefault * 1000;
        hasilEfisiensi = (efisiensi / 100) * kaloriIndex;
        massaIndexA = (gff / 1000) * pDefault;
      } else {
        ghv = kaloriIndex / pDefault;
        gff = (masaUap * (hg - hf)) / ((efisiensi / 100 * ghv)) / pDefault;
        hasilEfisiensi = (efisiensi / 100) * kaloriIndex;
        massaIndexA = gff * pDefault;
      }
    } else if (kategoriIndex == 'Efisiensi') {
      if (unit == 'Kkal/Kg') {
        ghv = kaloriIndex;
        massaIndexA = efisiensi;
      } else if (unit == 'Kkal/liter') {
        ghv = kaloriIndex / pDefault * 1000;
        massaIndexA = (efisiensi / 1000) * pDefault;
      } else {
        ghv = kaloriIndex / pDefault;
        massaIndexA = efisiensi * pDefault;
      }
      outputD = ((masaUap * (hg - hf))) / (massaIndexA * ghv) * 100;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('title_bar_calculator_result'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 15, left: 20),
                  child: Text(
                    Translations.of(context)
                        .text('f_calculator_boiler_result_tv_volume_title'),
                    style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 2,
                  width: 55,
                  margin: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 10.0),
                  decoration: new BoxDecoration(
                    color: Colors.blue[300],
                    shape: BoxShape.rectangle,
                  ),
                  child: Text('            '),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 130,
                      margin: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        '$titleIndex Mass',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 15),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0, top: 15),
                        child: Text(
                          '${f.format(massaIndexA)}  Kg',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 130,
                      margin: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        Translations.of(context)
                            .text('f_calculator_boiler_result_tv_hg_label'),
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 15),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0, top: 15),
                        child: Text(
                          '${f.format(hg)} Kkal/Kg',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 130,
                      margin: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        Translations.of(context)
                            .text('f_calculator_boiler_result_tv_hf_label'),
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 15),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0, top: 15),
                        child: Text(
                          '$hf Kkal/Kg',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                if (kategoriIndex == 'Efisiensi')
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 130,
                        margin:
                            EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                        child: Text(
                          'Boiler\'s Eficiency',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 5.0, top: 15, bottom: 15),
                          child: Text(
                            '${f.format(outputD)} %',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                      )
                    ],
                  ),
                if (kategoriIndex == 'Volume')
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 130,
                        margin:
                            EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                        child: Text(
                          'Volume $titleIndex Needed',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 5.0, top: 15, bottom: 15),
                          child: Text(
                            '${f.format(gff)} $unit',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  hgTable() {
    if (tekananUap == '1 bar') {
      hg = 638.885058;
    } else if (tekananUap == '2 bar') {
      hg = 646.3559732;
    } else if (tekananUap == '3 bar') {
      hg = 650.8103392;
    } else if (tekananUap == '4 bar') {
      hg = 653.955862;
    } else if (tekananUap == '5 bar') {
      hg = 656.3585924;
    } else if (tekananUap == '6 bar') {
      hg = 658.2764776;
    } else if (tekananUap == '7 bar') {
      hg = 659.85521;
    } else if (tekananUap == '8 bar') {
      hg = 661.180772;
    } else if (tekananUap == '9 bar') {
      hg = 662.3104852;
    } else if (tekananUap == '10 bar') {
      hg = 663.2849524;
    } else if (tekananUap == '11 bar') {
      hg = 664.130446;
    } else if (tekananUap == '12 bar') {
      hg = 664.8684616;
    } else if (tekananUap == '13 bar') {
      hg = 665.5181064;
    } else if (tekananUap == '14 bar') {
      hg = 666.088934;
    } else if (tekananUap == '15 bar') {
      hg = 666.5928864;
    }
  }

  hfTable() {
    if (suhuAir == '0 Celsius') {
      hf = 5.02;
    } else if (suhuAir == '5 Celsius') {
      hf = 5.02;
    } else if (suhuAir == '10 Celsius') {
      hf = 10.04;
    } else if (suhuAir == '15 Celsius') {
      hf = 15.04;
    } else if (suhuAir == '20 Celsius') {
      hf = 20.04;
    } else if (suhuAir == '25 Celsius') {
      hf = 25.04;
    } else if (suhuAir == '30 Celsius') {
      hf = 30.3;
    } else if (suhuAir == '35 Celsius') {
      hf = 35.02;
    } else if (suhuAir == '40 Celsius') {
      hf = 40.01;
    } else if (suhuAir == '45 Celsius') {
      hf = 45.01;
    } else if (suhuAir == '50 Celsius') {
      hf = 50.0;
    } else if (suhuAir == '55 Celsius') {
      hf = 54.99;
    } else if (suhuAir == '60 Celsius') {
      hf = 59.99;
    } else if (suhuAir == '65 Celsius') {
      hf = 64.99;
    } else if (suhuAir == '70 Celsius') {
      hf = 70.0;
    } else if (suhuAir == '75 Celsius') {
      hf = 75.0;
    } else if (suhuAir == '80 Celsius') {
      hf = 80.01;
    } else if (suhuAir == '85 Celsius') {
      hf = 85.03;
    } else if (suhuAir == '90 Celsius') {
      hf = 90.05;
    } else if (suhuAir == '95 Celsius') {
      hf = 95.08;
    }
  }
}

//RESULT  LISTRIK
class ResultsListrik extends StatelessWidget {
  var f = NumberFormat('#,##0.0#', 'en_US');
  final String titleIndex;
  String satuan;
  final double dayaListrik,
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
  ResultsListrik(
    this.titleIndex,
    this.dayaListrik,
    this.terhdapDaya,
    this.hargaLWBP,
    this.hargaWBP,
    this.jamOprasi,
    this.hariOprasi,
    this.jmlhJamBbnPuncak,
    this.kaloriKonversi,
    this.hargaKonversi,
    this.kurs,
    this.efesiensiMesin,
  );

  @override
  Widget build(BuildContext context) {
    //print("XXXX");
    double a,
        b,
        c,
        conversion,
        genset,
        volumeIndexs,
        biayaIndex,
        biayaPerKwh,
        perbedaanHarga;
    a = jamOprasi - jmlhJamBbnPuncak;
    b = a * ((hariOprasi * 4) + 2) * (terhdapDaya / 100) * dayaListrik;
    c = jmlhJamBbnPuncak *
        ((hariOprasi * 4) + 2) *
        (terhdapDaya / 100) *
        dayaListrik;

    double totalHargaLWBP = (b * hargaLWBP);
    double totalHargaWBP = (c * hargaWBP);
    double totalHarga = (totalHargaLWBP + totalHargaWBP);
    double hargaPerKwh = totalHarga / (b + c);
    conversion = kaloriKonversi / 900;
    genset = 1 / conversion / (efesiensiMesin / 100);
    volumeIndexs = genset * (b + c);
    biayaIndex = volumeIndexs * hargaKonversi;
    biayaPerKwh = biayaIndex / (b + c);

    perbedaanHarga = totalHarga - biayaIndex;
    if (titleIndex == 'Elpiji' ||
        titleIndex == 'Batu Bara' ||
        titleIndex == 'Kayu Bakar') {
      satuan = 'Kg';
    } else if (titleIndex == 'Gas Bumi (CNG/LNG)') {
      satuan = 'm3';
    } else {
      satuan = 'liter';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('title_bar_calculator_result'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 15, left: 20),
                  child: Text(
                    Translations.of(context)
                        .text('f_calculator_electricity_result_tv_title'),
                    style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 2,
                  width: 55,
                  margin: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    shape: BoxShape.rectangle,
                  ),
                  child: Text('            '),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 15),
                  child: Text(
                    Translations.of(context)
                        .text('f_calculator_electricity_result_tv_lwbp_label'),
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10, bottom: 10.0),
                  child: Text(
                    '${f.format(b)} Kwh X ${f.format(hargaLWBP)} = Rp.${f.format(totalHargaLWBP)}',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    Translations.of(context)
                        .text('f_calculator_electricity_result_tv_wbp_label'),
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                  child: Text(
                    '${f.format(b)} Kwh X ${f.format(hargaWBP)} = Rp.${f.format(totalHargaWBP)}',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    Translations.of(context).text(
                        'f_calculator_electricity_result_tv_total_price_label'),
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                  child: Text(
                    'RP.${f.format(totalHarga)} ( Rp.${f.format(hargaPerKwh)} /Kwh)',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    'Volume $titleIndex',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                  child: Text(
                    '${f.format(volumeIndexs)} $satuan',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    'Biaya $titleIndex',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                  child: Text(
                    'Rp.${f.format(biayaIndex)} (Rp.${f.format(biayaPerKwh)} /Kwh)',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    Translations.of(context).text(
                        'f_calculator_electricity_result_tv_difference_label'),
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue[300]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10, bottom: 15),
                  child: Text(
                    'Rp. ${f.format(perbedaanHarga)}',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue[300]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
