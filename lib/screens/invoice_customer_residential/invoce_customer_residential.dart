import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/invoice_customer_residential/widgets/payment_method.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:pgn_mobile/models/customer_invoce_residential_model.dart';

class InvoiceCustResidential extends StatefulWidget {
  InvoiceCustResidential({this.data, this.custID});
  final Future<CustomerInvoiceResidential> data;
  final String custID;
  @override
  BillDetailState createState() => BillDetailState(data, custID);
}

class BillDetailState extends State<InvoiceCustResidential>
    with SingleTickerProviderStateMixin {
  Future<CustomerInvoiceResidential> data;
  String custID;

  BillDetailState(this.data, this.custID);
  var prevMonth1, prevMonth2, prevMonth3;
  var currentDate = new DateTime.now();
  TabController _tabController;
  List<String> listMenus = [];
  final storageCache = new FlutterSecureStorage();
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 2);
    super.initState();
    getCred(context);
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
    }
    //  else if (currentMonth == 3) {
    //   int currentYears = DateTime.now().year - 1;
    //   int yearNow = DateTime.now().year;
    //   String y1 = "02";
    //   int y2 = 01;

    //   String cal2 = '$currentYear$y1';
    //   String cal1 = '$currentYears$y2';
    //   currentMonthS = '03';
    //   month2S = cal2;
    //   month3S = cal1;
    // }
    else if (currentMonth == 1) {
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
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent));
    String formatDate2 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent2));
    String formatDate3 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent3));
//ID MENU INOVOICE RTPK 11
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
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
                      _buildContent0(context, formatDate3, custID),
                      _buildContent1(context, formatDate2, custID),
                      _buildContent2(context, formatDate, custID),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent2(BuildContext context, String title, String custID) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
          child: _buildCharContent2(
              context, getCustomerInvoice(context, custID), title),
        ),
      ],
    );
  }

  Widget _buildCharContent2(BuildContext context,
      Future<CustomerInvoiceResidential> getInvoiceData, title) {
    return FutureBuilder<CustomerInvoiceResidential>(
      future: getInvoiceData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.message != null)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset('assets/penggunaan_gas.png'),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  snapshot.data.message,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return i < 1
                    ? _buildRow(snapshot.data.data[0])
                    : SizedBox(
                        height: 10.0,
                      );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent0(BuildContext context, String title, String custID) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
          child: _buildCharContent0(
              context, getCustomerInvoice(context, custID), title),
        )
      ],
    );
  }

  Widget _buildCharContent0(BuildContext context,
      Future<CustomerInvoiceResidential> getInvoiceData, title) {
    return FutureBuilder<CustomerInvoiceResidential>(
      future: getInvoiceData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.message != null)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset('assets/penggunaan_gas.png'),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  snapshot.data.message,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return i < 1
                    ? _buildRow(snapshot.data.data[2])
                    : SizedBox(
                        height: 10.0,
                      );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent1(BuildContext context, String title, String custID) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
          child: _buildCharContent1(
              context, getCustomerInvoice(context, custID), title),
        )
      ],
    );
  }

  Widget _buildCharContent1(BuildContext context,
      Future<CustomerInvoiceResidential> getInvoiceData, title) {
    return FutureBuilder<CustomerInvoiceResidential>(
      future: getInvoiceData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.message != null)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset('assets/penggunaan_gas.png'),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  snapshot.data.message,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return i < 1
                    ? _buildRow(snapshot.data.data[1])
                    : SizedBox(
                        height: 10.0,
                      );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow(DataCustInvoiceResidential data) {
    // var invoicePeriod = DateTime.parse(data.invoicePeriod);
    // var usagePeriod = DateTime.parse(data.usagePeriod);
    // String stringInvoicePeriod =
    //     "${formatDate((invoicePeriod), [d])} ${formatDate((invoicePeriod), [
    //   MM
    // ])} ${formatDate((invoicePeriod), [yyyy])}";
    // String stringUsagePeriod =
    //     "${formatDate((usagePeriod), [d])} ${formatDate((usagePeriod), [
    //   MM
    // ])} ${formatDate((usagePeriod), [yyyy])}";
    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            color: Colors.blue[800],
            margin: EdgeInsets.only(bottom: 10.0),
            child: Center(
              child: Text(
                '${Translations.of(context).text('current_bill_date')} : ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.billDate))}',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(top: 10),
            elevation: 5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 70,
                      margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0),
                      decoration: new BoxDecoration(
                        color: Colors.blue[800],
                        shape: BoxShape.circle,
                      ),
                      child: Text('          '),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0, top: 5.0),
                        child: Text(
                          data.custInvoiceName ?? "-",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
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
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Text(
                        Translations.of(context)
                            .text('f_redeem_tv_customer_name_hint'),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 25.0),
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
                        margin: EdgeInsets.only(left: 5.0, top: 5.0, right: 10),
                        child: Text(
                          data.custInvoiceName ?? "-",
                          style: TextStyle(
                              fontSize: 15.0,
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
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context)
                            .text('f_household_invoice_form_et'),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Text(
                          data.custInvoiceId ?? "-",
                          style: TextStyle(
                              fontSize: 15.0,
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
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context).text('available_guarantee'),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                        margin:
                            EdgeInsets.only(left: 5.0, top: 10.0, right: 10),
                        child: Text(
                          '${data.availableGuarantee == null ? 0 : data.availableGuarantee.toString()} IDR',
                          style: TextStyle(
                              fontSize: 15.0,
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
                      width: 125,
                      margin:
                          EdgeInsets.only(left: 20.0, top: 10.0, bottom: 20),
                      child: Text(
                        Translations.of(context).text('payment_guarantee'),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 10.0, left: 25.0, bottom: 20),
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
                        margin: EdgeInsets.only(
                            left: 5.0, top: 10.0, bottom: 20, right: 10),
                        child: Text(
                          '${data.paymentGuatantee == null ? 0 : data.paymentGuatantee.toString()} IDR',
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(top: 10),
            elevation: 5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 130,
                      margin: EdgeInsets.only(left: 20.0, top: 21.0),
                      child: Text(
                        Translations.of(context).text('invoice_detail'),
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[600]),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 22.0),
                      child: Text(
                        Translations.of(context).text('period'),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 22.0, left: 25.0),
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
                        margin: EdgeInsets.only(left: 5.0, top: 22.0),
                        child: Text(
                          data.invoicePeriod ?? "-",
                          style: TextStyle(
                              fontSize: 15.0,
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
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context)
                            .text('f_commercial_invoice_detail_tv_duedate'),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Text(
                          data.usagePeriod != ""
                              ? DateFormat('dd MMMM yyyy').format(
                                      DateTime.parse(data.usagePeriod)) ??
                                  "-"
                              : '-',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                ListView.builder(
                  itemCount: data.cmm.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 125,
                              margin: EdgeInsets.only(left: 20.0, top: 10.0),
                              child: Text(
                                Translations.of(context)
                                    .text('cmm_record_meter'),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                                margin: EdgeInsets.only(left: 5.0, top: 10.0),
                                child: Text(
                                  data.cmm[i].metodePencatatan.toString(),
                                  style: TextStyle(
                                      fontSize: 15.0,
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
                              width: 125,
                              margin: EdgeInsets.only(left: 20.0, top: 10.0),
                              child: Text(
                                Translations.of(context)
                                    .text('cmm_record_status'),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                                margin: EdgeInsets.only(left: 5.0, top: 10.0),
                                child: Text(
                                  data.cmm[i].metodePerhitungan.toString(),
                                  style: TextStyle(
                                      fontSize: 15.0,
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
                              width: 125,
                              margin: EdgeInsets.only(left: 20.0, top: 10.0),
                              child: Text(
                                Translations.of(context).text('cmm_stand_awal'),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                                margin: EdgeInsets.only(left: 5.0, top: 10.0),
                                child: Text(
                                  data.cmm[i].standAwal.toString(),
                                  style: TextStyle(
                                      fontSize: 15.0,
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
                              width: 125,
                              margin: EdgeInsets.only(left: 20.0, top: 10.0),
                              child: Text(
                                Translations.of(context)
                                    .text('cmm_stand_akhir_end'),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                                margin: EdgeInsets.only(left: 5.0, top: 10.0),
                                child: Text(
                                  data.cmm[i].standAkhir.toString(),
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            )
                          ],
                        ),
                        data.cmm.length <= 1
                            ? SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Divider(color: Colors.grey),
                              ),
                      ],
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context)
                            .text('f_home_tv_chart_usage_volume'),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Text(
                          '${data.volumeUsage.toString()} m3',
                          style: TextStyle(
                              fontSize: 15.0,
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
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        'Volume Normal',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Text(
                          '${data.volumeNormal.toString()} m3',
                          style: TextStyle(
                              fontSize: 15.0,
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
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        'Over Usage Penalty',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Text(
                          "${data.volumeOverUsage ?? "-"} m3",
                          style: TextStyle(
                              fontSize: 15.0,
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
                      width: 125,
                      margin:
                          EdgeInsets.only(left: 20.0, top: 10.0, bottom: 20),
                      child: Text(
                        '${Translations.of(context).text('gas_bill')} ${data.billTypeDesc != "" ? (data.billTypeDesc) : ""}',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 10.0, left: 25.0, bottom: 20),
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
                        margin:
                            EdgeInsets.only(left: 5.0, top: 10.0, bottom: 20),
                        child: Text(
                          "${data.tagihanIDR.toString()} IDR",
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
          data.others.length != 0
              ? Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 125,
                            margin: EdgeInsets.only(
                                left: 20.0, top: 21.0, bottom: 10),
                            child: Text(
                              Translations.of(context).text('invoice_others'),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600]),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                          itemCount: data.others.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 125,
                                  margin:
                                      EdgeInsets.only(left: 20.0, top: 10.0),
                                  child: Text(
                                    data.others[i].type,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, left: 25.0),
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
                                    margin:
                                        EdgeInsets.only(left: 5.0, top: 10.0),
                                    child: Text(
                                      data.others[i].idr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Text(
                              Translations.of(context).text('total_tax'),
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                              margin: EdgeInsets.only(
                                  left: 5.0, top: 10.0, right: 20),
                              child: Text(
                                data.taxBase.idr,
                                style: TextStyle(
                                    fontSize: 15.0,
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Text(
                              Translations.of(context).text('vat'),
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                              margin: EdgeInsets.only(left: 5.0, top: 10.0),
                              child: Text(
                                data.vat.idr,
                                style: TextStyle(
                                    fontSize: 15.0,
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
                            width: 125,
                            margin: EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Text(
                              Translations.of(context).text('total_other'),
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                              margin: EdgeInsets.only(
                                  left: 5.0, top: 10.0, right: 20),
                              child: Text(
                                data.totalOther.idr,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          data.piutang.length != 0
              ? Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  elevation: 5,
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Container(
                            width: 125,
                            margin: EdgeInsets.only(
                                left: 20.0, top: 21.0, bottom: 10),
                            child: Text(
                              Translations.of(context).text('piutang'),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600]),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                          itemCount: data.piutang.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 125,
                                  margin:
                                      EdgeInsets.only(left: 20.0, top: 10.0),
                                  child: Text(
                                    '${Translations.of(context).text('piutang')} ${data.piutang[i].period}',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, left: 25.0),
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
                                    margin: EdgeInsets.only(
                                        left: 5.0, top: 10.0, right: 20),
                                    child: Text(
                                      data.piutang[i].idr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ))
              : SizedBox(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(top: 10),
            elevation: 5,
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 21.0),
                      child: Text(
                        Translations.of(context).text('total_tagihan'),
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[600]),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 22.0),
                      child: Text(
                        Translations.of(context).text('total_billing'),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 25.0),
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
                        margin:
                            EdgeInsets.only(left: 5.0, top: 20.0, right: 20),
                        child: Text(
                          "${data.tBillIdr ?? "-"} IDR",
                          style: TextStyle(
                              fontSize: 15.0,
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
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context).text('payment_code'),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, left: 25.0),
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
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Text(
                          data.custInvoiceId.toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 90,
                  color: Colors.grey[200],
                  padding: EdgeInsets.only(right: 10),
                  margin: EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        padding: EdgeInsets.all(0.1),
                        margin: EdgeInsets.only(right: 10),
                        color: Colors.grey[400],
                      ),
                      Expanded(
                        child: Text(
                          Translations.of(context).text('payment_desc'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  color: Colors.grey[200],
                  padding: EdgeInsets.only(right: 10),
                  margin: EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        padding: EdgeInsets.all(0.1),
                        margin: EdgeInsets.only(right: 10),
                        color: Colors.grey[400],
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'Sesuai ketentuan UU No.7/2021 Harmonisasi Peraturan Perpajakan, per '),
                              TextSpan(
                                  text: '1 April 2022 ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      'tagihan atas pemakaian Gas bulan Maret dan seterusnya dikenakan '),
                              TextSpan(
                                  text: 'PPN 11%',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Container(
              height: 45,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(top: 13, left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF427CEF)),
              child: Text(
                Translations.of(context)
                    .text('f_customer_invoice_tv_payment_method'),
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentMethod()));
            },
          ),
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey[300],
              margin: EdgeInsets.only(top: 20, bottom: 10),
              elevation: 5,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15),
                  Icon(Icons.help, size: 34, color: Colors.white),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 20.0, left: 10.0, top: 10.0, bottom: 10.0),
                      child: Text(
                        Translations.of(context)
                            .text('f_customer_invoice_tv_footer_notes'),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Future<CustomerInvoiceResidential> getCustomerInvoice(
      BuildContext context, String custID) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseCustomerInvoice =
        await http.get('${UrlCons.mainProdUrl}customers/me/invoices', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });
    CustomerInvoiceResidential _customerInvoice =
        CustomerInvoiceResidential.fromJson(
            json.decode(responseCustomerInvoice.body));
    return _customerInvoice;
  }

  getCred(BuildContext context) async {
    String listMenusString = await storageCache.read(key: 'list_menu') ?? "";

    setState(() {
      listMenus = listMenusString.split(',');
    });
    //print('HASIL LIST MENU LENGHT = ${listMenus.length}');
  }
}
