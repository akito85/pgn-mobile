import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/subscription_progress_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/services/app_localizations.dart';

class ProgressSubsDetail extends StatelessWidget {
  final String formID;
  ProgressSubsDetail({this.formID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF427CEF),
      appBar: AppBar(
        backgroundColor: Color(0xFF427CEF),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          Translations.of(context).text('pb_tab_title'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<SubsProgDetail>(
        future: getFutureSubsProgDetail(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
              child: LinearProgressIndicator(),
            );
          if (snapshot.data.code != null)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    snapshot.data.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            );
          DateTime dateFormatedFRBG =
              DateTime.parse(snapshot.data.dataDetailProg[0].regDate);

          DateTime dateFormatedVRBG =
              snapshot.data.dataDetailProg[0].verDate != null
                  ? DateTime.parse(snapshot.data.dataDetailProg[0].verDate)
                  : DateTime.parse('2000-01-01 00:00:00');
          DateTime dateFormatedBBG =
              snapshot.data.dataDetailProg[0].bbgDate != null
                  ? DateTime.parse(snapshot.data.dataDetailProg[0].bbgDate)
                  : DateTime.parse('2000-01-01 00:00:00');
          DateTime dateFormatedCons =
              snapshot.data.dataDetailProg[0].jarfasDate != null
                  ? DateTime.parse(snapshot.data.dataDetailProg[0].jarfasDate)
                  : DateTime.parse('2000-01-01 00:00:00');
          DateTime dateFormatedGasIn =
              snapshot.data.dataDetailProg[0].gasDate != null
                  ? DateTime.parse(snapshot.data.dataDetailProg[0].gasDate)
                  : DateTime.parse('2000-01-01 00:00:00');
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 18, right: 18, top: 20),
                height: 150,
                color: Color(0xFF427CEF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          snapshot.data.dataDetailProg[0].name,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                        Container(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(snapshot.data.dataDetailProg[0].status,
                              style: TextStyle(
                                  color: Color(0xFF427CEF),
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Reg No. ${snapshot.data.dataDetailProg[0].formId}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(
                        Translations.of(context).text('pb_tab_phase'),
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF427CEF),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FRBG
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 21,
                                backgroundColor: Color(0xFF81C153),
                                child: Icon(
                                  Icons.check,
                                  size: 25,
                                  color: Colors.white,
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatDate(dateFormatedFRBG,
                                        [dd, ' ', MM, ' ', yyyy]),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    Translations.of(context)
                                        .text('f_title_porg_subs_stat_frbg'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    snapshot.data.dataDetailProg[0].regBy,
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          width: 2,
                          height: 25,
                          color: Colors.grey,
                        ),
                        // EVALUASI
                        snapshot.data.dataDetailProg[0].regBy != null
                            ? Row(
                                children: [
                                  snapshot.data.dataDetailProg[0].verBy != null
                                      ? CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF81C153),
                                          child: Icon(
                                            Icons.check,
                                            size: 25,
                                            color: Colors.white,
                                          ))
                                      : CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF427CEF),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatDate(dateFormatedFRBG,
                                              [dd, ' ', MM, ' ', yyyy]),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          Translations.of(context).text(
                                              'f_title_porg_subs_stat_evaluation'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          snapshot.data.dataDetailProg[0].regBy,
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 4),
                                    child: CircleAvatar(
                                      radius: 21,
                                      backgroundColor: Colors.grey,
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '-',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          Translations.of(context).text(
                                              'f_title_porg_subs_stat_evaluation'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '-',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          width: 2,
                          height: 25,
                          color: Colors.grey,
                        ),
                        // VRBG
                        snapshot.data.dataDetailProg[0].verBy != null
                            ? Row(
                                children: [
                                  snapshot.data.dataDetailProg[0].custId != null
                                      ? CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF81C153),
                                          child: Icon(
                                            Icons.check,
                                            size: 25,
                                            color: Colors.white,
                                          ))
                                      : CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF427CEF),
                                          child: Text(
                                            '3',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatDate(dateFormatedVRBG,
                                              [dd, ' ', MM, ' ', yyyy]),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'VRBG',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          snapshot.data.dataDetailProg[0]
                                                  .verBy ??
                                              '-',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 4),
                                    child: CircleAvatar(
                                      radius: 21,
                                      backgroundColor: Colors.grey,
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'VRBG',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          width: 2,
                          height: 25,
                          color: Colors.grey,
                        ),
                        // BBG
                        snapshot.data.dataDetailProg[0].custId != null
                            ? Row(
                                children: [
                                  snapshot.data.dataDetailProg[0].jarfasBy !=
                                          null
                                      ? CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF81C153),
                                          child: Icon(
                                            Icons.check,
                                            size: 25,
                                            color: Colors.white,
                                          ))
                                      : CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF427CEF),
                                          child: Text(
                                            '4',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatDate(dateFormatedBBG,
                                              [dd, ' ', MM, ' ', yyyy]),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'BBG',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Cust ID : ${snapshot.data.dataDetailProg[0].custId}',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 4),
                                    child: CircleAvatar(
                                      radius: 21,
                                      backgroundColor: Colors.grey,
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'BBG',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          width: 2,
                          height: 25,
                          color: Colors.grey,
                        ),
                        // KONS Jaringan
                        snapshot.data.dataDetailProg[0].jarfasBy != null
                            ? Row(
                                children: [
                                  snapshot.data.dataDetailProg[0].gasInBy !=
                                          null
                                      ? CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF81C153),
                                          child: Icon(
                                            Icons.check,
                                            size: 25,
                                            color: Colors.white,
                                          ))
                                      : CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF427CEF),
                                          child: Text(
                                            '5',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatDate(dateFormatedCons,
                                              [dd, ' ', MM, ' ', yyyy]),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          Translations.of(context).text(
                                              'f_title_porg_subs_stat_construction'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          snapshot.data.dataDetailProg[0]
                                                  .jarfasBy ??
                                              '-',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 4),
                                    child: CircleAvatar(
                                      radius: 21,
                                      backgroundColor: Colors.grey,
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Translations.of(context).text(
                                              'f_title_porg_subs_stat_construction'),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                        // GAS IN
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          width: 2,
                          height: 25,
                          color: Colors.grey,
                        ),
                        snapshot.data.dataDetailProg[0].gasInBy != null
                            ? Row(
                                children: [
                                  snapshot.data.dataDetailProg[0].gasInBy !=
                                          null
                                      ? CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF81C153),
                                          child: Icon(
                                            Icons.check,
                                            size: 25,
                                            color: Colors.white,
                                          ))
                                      : CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xFF427CEF),
                                          child: Text(
                                            '6',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatDate(dateFormatedGasIn,
                                              [dd, ' ', MM, ' ', yyyy]),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Gas In',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          snapshot.data.dataDetailProg[0]
                                                  .gasInBy ??
                                              '-',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, left: 0.5),
                                    child: CircleAvatar(
                                      radius: 21,
                                      backgroundColor: Colors.grey,
                                      child: Text(
                                        '6',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Gas In',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                      ],
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<SubsProgDetail> getFutureSubsProgDetail() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetSubsProgDetail = await http.get(
        '${UrlCons.mainDevUrl}prospective_customer_progress/$formID',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang,
        });
    return SubsProgDetail.fromJson(json.decode(responseGetSubsProgDetail.body));
  }
}
