import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/cmm_model.dart';
import 'package:pgn_mobile/models/cust_invoice_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:http/http.dart' as http;

class CMM extends StatefulWidget {
  CMM({this.custID, this.data, this.userid});
  final Future<CustomerInvoice> data;
  final String custID;
  final String userid;

  @override
  CMMState createState() => CMMState(data, custID, userid);
}

class CMMState extends State<CMM> with SingleTickerProviderStateMixin {
  Future<CustomerInvoice> data;
  String custID;
  String userid;
  String currentLang;
  String statusCMM;
  CMMState(this.data, this.custID, this.userid);
  var prevMonth1, prevMonth2, prevMonth3;
  var currentDate = new DateTime.now();

  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 2);

    super.initState();
  }

  Widget build(BuildContext context) {
    prevMonth1 = currentDate.month - 1;
    prevMonth2 = new DateTime(currentDate.month - 2);
    prevMonth3 = new DateTime(currentDate.month - 3);
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int month2 = currentMonth - 1;
    int month3 = currentMonth - 2;
    String sNull = "0";
    String month3S, month2S, currentMonthS;

    if (currentMonth == 2) {
      int currentYears = DateTime.now().year - 1;
      String y1 = "01";
      int y2 = 12;

      String cal2 = '$currentYear$y1';
      String cal1 = '$currentYears$y2';
      currentMonthS = '02';
      month2S = cal2;
      month3S = cal1;
    } else if (currentMonth == 1) {
      int currentYears = DateTime.now().year - 1;
      int y1 = 12;
      int y2 = 11;
      String cal2 = '$currentYears$y1';
      String cal1 = '$currentYears$y2';
      currentMonthS = '01';
      month2S = cal2;
      month3S = cal1;
    } else {
      currentYear = DateTime.now().year;
      if (currentMonth < 10) {
        currentMonthS = '0$currentMonth';
      } else {
        currentMonthS = currentMonth.toString();
      }
      if (month2 < 10) {
        month2S = '$currentYear$sNull$month2';
      } else {
        month2S = '$currentYear$month2';
      }

      if (month3 < 10) {
        month3S = '$currentYear$sNull$month3';
      } else {
        month3S = '$currentYear$month3';
      }
    }
    String dateformatCurrent =
        '${currentYear.toString()}${currentMonthS.toString()}10';
    String dateformatCurrent2 = '${month2S.toString()}10';

    String dateformatCurrent3 = '${month3S.toString()}10';

    String formatDate =
        DateFormat("MMM-yyy").format(DateTime.parse(dateformatCurrent));
    String formatDate2 =
        DateFormat("MMM-yyy").format(DateTime.parse(dateformatCurrent2));
    String formatDate3 =
        DateFormat("MMM-yyy").format(DateTime.parse(dateformatCurrent3));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Histori Pencatatan',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          // backgroundColor: Colors.S,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    // border: Border.all(color: Colors.blue[300]),
                  ),
                  height: 45,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Color(0xff427CEF),
                    indicatorWeight: 1,
                    indicatorPadding: EdgeInsets.only(left: 15, right: 15),
                    labelColor: Colors.white,
                    unselectedLabelColor: Color(0xff427CEF),
                    indicator: ShapeDecoration(
                        color: Color(0xff427CEF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                              color: Color(0xff427CEF),
                            ))),
                    tabs: [
                      Tab(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent3))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent3))}',
                          style: TextStyle(fontSize: 15),
                        ),
                      )),
                      Tab(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent2))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent2))}',
                          style: TextStyle(fontSize: 15),
                        ),
                      )),
                      Tab(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent))}',
                          style: TextStyle(fontSize: 15),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/new_backgound.jpeg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TabBarView(
                controller: _tabController,
                children: [
                  _buildContent2(
                      context,
                      getCMMList(context, formatDate3),
                      custID,
                      DateFormat("MMMM")
                          .format(DateTime.parse(dateformatCurrent3)),
                      DateFormat("yyy")
                          .format(DateTime.parse(dateformatCurrent3))),
                  _buildContent2(
                      context,
                      getCMMList(context, formatDate2),
                      custID,
                      DateFormat("MMMM")
                          .format(DateTime.parse(dateformatCurrent2)),
                      DateFormat("yyy")
                          .format(DateTime.parse(dateformatCurrent2))),
                  _buildContent2(
                      context,
                      getCMMList(context, formatDate),
                      custID,
                      DateFormat("MMMM")
                          .format(DateTime.parse(dateformatCurrent)),
                      DateFormat("yyy")
                          .format(DateTime.parse(dateformatCurrent))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent2(BuildContext context, Future<CMMModel> getCMMList,
      String custID, String dateMonth, String year) {
    return FutureBuilder<CMMModel>(
      future: getCMMList,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: [
              LinearProgressIndicator(),
            ],
          );
        if (snapshot.data.message != null)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                child: Image.asset('assets/penggunaan_gas.png'),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  snapshot.data.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              // Positioned(
              //   bottom: 0.1,
              //   child: Container(
              //     height: 45.0,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5.0),
              //       color: Color(0xFF427CEF),
              //     ),
              //     child: MaterialButton(
              //       minWidth: MediaQuery.of(context).size.width,
              //       child: Text(
              //         'CATAT METER MANDIRI',
              //         style: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //       onPressed: () {
              //         Navigator.pushNamed(context, '/cmmForm');
              //       },
              //     ),
              //   ),
              // )
            ],
          );
        print('STATCMM : ${snapshot.data.statusCMM}');
        print(
            'INI STATUS CMMMMMMM :${DateFormat("MMMM").format(DateTime.parse(DateTime.now().toString()))}');
        print('CURRENT MONTH ${snapshot.data.dataListCMM.length}');
        return Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
              child: ListView(
                children: <Widget>[
                  _buildRow(snapshot.data.dataListCMM, snapshot.data.message,
                      snapshot.data.statusCMM, dateMonth, year)
                ],
              ),
            ),
            dateMonth ==
                        DateFormat("MMMM").format(
                            DateTime.parse(DateTime.now().toString())) &&
                    statusCMM == 'Belum CMM'
                ? Positioned(
                    bottom: 0.1,
                    child: Container(
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xFF427CEF),
                      ),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          'CATAT METER MANDIRI',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cmmForm');
                        },
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 0.1,
                    child: Container(
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xFFD3D3D3),
                      ),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          'CATAT METER MANDIRI',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(context, '/cmmForm');
                        },
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }

  Widget _buildRow(List<DataListCMM> data, String message, String statusCMM,
      String dateMonth, String year) {
    print('STATUS CMM : $statusCMM');
    DateTime dateTime;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    print('MASUK: ${data.length} ');
    if (data.length == 0)
      return Container(
        margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0, bottom: 10.0),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(top: 10),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 150,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text('cmm_stand_awal'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25.0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            '-',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
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
                        alignment: Alignment.topLeft,
                        width: 150,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text('cmm_stand_akhir'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25.0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            '-',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
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
                        alignment: Alignment.topLeft,
                        width: 150,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text('cmm_selisih_stand'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25.0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            '-',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
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
                        alignment: Alignment.topLeft,
                        width: 150,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text('cmm_time_noted'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25.0),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            '-',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
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
                        width: 150,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20.0, bottom: 20),
                        child: Text(
                          Translations.of(context).text('cmm_input_method'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25.0, bottom: 20),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, bottom: 20),
                          child: Text(
                            '-',
                            style: TextStyle(
                                fontSize: 15.0,
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
            currentLang != 'id'
                ? Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    elevation: 5,
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: AssetImage("assets/CMMeng.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    elevation: 5,
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: AssetImage("assets/CMMindo.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
          ],
        ),
      );
    else
      return Container(
        margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0, bottom: 10.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  dateTime = data[i].tanggal != ''
                      ? dateFormat.parse(data[i].tanggal)
                      : DateTime.now();
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(top: 10),
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 150,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20.0),
                              child: Text(
                                Translations.of(context).text('cmm_stand_awal'),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25.0),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5, right: 20.0),
                                child: Text(
                                  data[i].standAwal.toString() ?? '',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
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
                              alignment: Alignment.topLeft,
                              width: 150,
                              margin: EdgeInsets.only(left: 20.0),
                              child: Text(
                                Translations.of(context)
                                    .text('cmm_stand_akhir'),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25.0),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, right: 20),
                                child: Text(
                                  data[i].standAkhir.toString() ?? '',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
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
                              alignment: Alignment.topLeft,
                              width: 150,
                              margin: EdgeInsets.only(left: 20.0),
                              child: Text(
                                Translations.of(context)
                                    .text('cmm_selisih_stand'),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25.0),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, right: 20),
                                child: Text(
                                  data[i].selisih != '' ? data[i].selisih : '-',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
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
                              alignment: Alignment.topLeft,
                              width: 150,
                              margin: EdgeInsets.only(left: 20.0),
                              child: Text(
                                Translations.of(context).text('cmm_time_noted'),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25.0),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, right: 20),
                                child: Text(
                                  '${DateFormat('dd MMMM yyyy').format(dateTime)}',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
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
                              width: 150,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20.0, bottom: 20),
                              child: Text(
                                Translations.of(context)
                                    .text('cmm_input_method'),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25.0, bottom: 20),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 5.0, bottom: 20, right: 20),
                                child: Text(
                                  data[i].source ?? '',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            currentLang != 'id'
                ? Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    elevation: 5,
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: AssetImage("assets/CMMeng.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    elevation: 5,
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: AssetImage("assets/CMMindo.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
          ],
        ),
      );
  }

  Future<CMMModel> getCMMList(BuildContext context, String period) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    currentLang = await storageCache.read(key: 'lang');
    print("ACCESS TOKEN: ${period.toUpperCase()}");
    var responseCMMList = await http.get(
        '${UrlCons.mainProdUrl}giore?P_PERIOD=${period.toUpperCase()}',
        headers: {
          // .get('http://192.168.105.184/pgn-mobile-api/v2/customers/me/invoices', headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': currentLang,
          // 'Authorization': 'Bearer 0Dz4C3O9flOerWWYUaFFFQXYbwKr9tlHc60k4MVa',
        });
    // print(
    //     'ALAMAT CMM LIST :ttps://devapi-mobile.pgn.co.id/v2/giore?P_PERIOD=${period.toUpperCase()}');
    print('Data CMM LIST : ${responseCMMList.body}');
    CMMModel _cmmList = CMMModel.fromJson(json.decode(responseCMMList.body));
    if (responseCMMList.statusCode == 200) {
      _cmmList.dataListCMM.forEach((x) {
        x.timeStamp = dateFormat.parse(x.tanggal).millisecondsSinceEpoch;
        if (x.source == 'CMM') {
          _cmmList.statusCMM = 'Sudah CMM';
          statusCMM = 'Sudah CMM';
        } else if (x.source == 'Catat Meter Mandiri') {
          _cmmList.statusCMM = 'Sudah CMM';
          statusCMM = 'Sudah CMM';
        } else {
          _cmmList.statusCMM = 'Belum CMM';
          statusCMM = 'Belum CMM';
        }
      });
      if (_cmmList.dataListCMM.length == null ||
          _cmmList.dataListCMM.length == 0) {
        statusCMM = 'Belum CMM';
      }
      _cmmList.dataListCMM.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
    } else {
      // _cmmList ;
    }

    return _cmmList;
  }
}
