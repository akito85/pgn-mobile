import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/cust_invoice_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/invoice_customer_residential/widgets/payment_method.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:pgn_mobile/models/customer_invoce_residential_model.dart';

class InvoiceRTPK extends StatefulWidget {
  InvoiceRTPK({this.data, this.custID});
  final CustomerInvoice data;
  final String custID;
  @override
  BillDetailState createState() => BillDetailState(data, custID);
}

class BillDetailState extends State<InvoiceRTPK>
    with SingleTickerProviderStateMixin {
  CustomerInvoice data;
  String custID;
  BillDetailState(this.data, this.custID);
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Customer Invoice',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      // backgroundColor: Colors.white,
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
                        margin: EdgeInsets.only(left: 5.0, top: 5.0),
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
                            .text('f_household_invoice_form_et'),
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
                        margin: EdgeInsets.only(left: 5.0, top: 5.0),
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
                        Translations.of(context)
                            .text('f_commercial_invoice_detail_tv_name'),
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
                          '${data.availableGuarantee.toString()} IDR',
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
                          '${data.paymentGuatantee.toString()} IDR',
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
                        'Period',
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
                          DateFormat('dd MMMM yyyy')
                                  .format(DateTime.parse(data.usagePeriod)) ??
                              "-",
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
                        Translations.of(context).text('gas_bill'),
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
                                'Stand Awal',
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
                                'Stand Akhir',
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 125,
                              margin: EdgeInsets.only(left: 20.0, top: 10.0),
                              child: Text(
                                'Jenis Meter',
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
                                'Metode Pencatatan',
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
                        'Volume Usage',
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
                      margin:
                          EdgeInsets.only(left: 20.0, top: 10.0, bottom: 20),
                      child: Text(
                        'Volume Over Usage',
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

                // Row(
                //   children: <Widget>[
                //     Container(
                //       width: 125,
                //       margin: EdgeInsets.only(left: 20.0, top: 10.0),
                //       child: Text(
                //         Translations.of(context)
                //             .text('f_customer_guarantees_title'),
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10.0, left: 25.0),
                //       child: Text(
                //         ':',
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(left: 5.0, top: 10.0),
                //         child: Text(
                //           "Rp.${data.pGuaranteeIdr ?? "-"}",
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Container(
                //       width: 125,
                //       margin: EdgeInsets.only(left: 20.0, top: 10.0),
                //       child: Text(
                //         Translations.of(context)
                //             .text('f_commercial_invoice_detail_tv_denda'),
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10.0, left: 25.0),
                //       child: Text(
                //         ':',
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(left: 5.0, top: 10.0),
                //         child: Text(
                //           data.denda != "" ? data.denda : "-",
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Container(
                //       width: 125,
                //       margin: EdgeInsets.only(left: 20.0, top: 10.0),
                //       child: Text(
                //         Translations.of(context).text(
                //             'f_commercial_invoice_detail_tv_b_pengaliran_kembali'),
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10.0, left: 25.0),
                //       child: Text(
                //         ':',
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(left: 5.0, top: 10.0),
                //         child: Text(
                //           data.biayaPengaliran != ""
                //               ? data.biayaPengaliran
                //               : "-",
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Container(
                //       width: 125,
                //       margin: EdgeInsets.only(left: 20.0, top: 10.0),
                //       child: Text(
                //         Translations.of(context).text(
                //             'f_commercial_invoice_detail_tv_b_pemasangan_kembali'),
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10.0, left: 25.0),
                //       child: Text(
                //         ':',
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(left: 5.0, top: 10.0),
                //         child: Text(
                //           data.biayaPemasangan != ""
                //               ? data.biayaPemasangan
                //               : "-",
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Container(
                //       width: 125,
                //       margin: EdgeInsets.only(left: 20.0, top: 10.0),
                //       child: Text(
                //         Translations.of(context)
                //             .text('f_commercial_invoice_detail_tv_b_migrasi'),
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10.0, left: 25.0),
                //       child: Text(
                //         ':',
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(left: 5.0, top: 10.0),
                //         child: Text(
                //           data.biayaMigrasi != "" ? data.biayaMigrasi : "-",
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Container(
                //       width: 125,
                //       margin: EdgeInsets.only(left: 20.0, top: 10.0),
                //       child: Text(
                //         Translations.of(context)
                //             .text('f_commercial_invoice_detail_tv_b_pelayanan'),
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10.0, left: 25.0),
                //       child: Text(
                //         ':',
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(left: 5.0, top: 10.0),
                //         child: Text(
                //           data.biayaPelayanan != "" ? data.biayaPelayanan : "-",
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Container(
                //       width: 125,
                //       margin: EdgeInsets.only(left: 20.0, top: 10.0),
                //       child: Text(
                //         Translations.of(context)
                //             .text('f_commercial_invoice_detail_tv_b_sms'),
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(top: 10.0, left: 25.0),
                //       child: Text(
                //         ':',
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(left: 5.0, top: 10.0),
                //         child: Text(
                //           data.biayaSms != "" ? data.biayaSms : "-",
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Container(
                //       width: 125,
                //       margin:
                //           EdgeInsets.only(left: 20.0, top: 10.0, bottom: 20),
                //       child: Text(
                //         Translations.of(context)
                //             .text('f_customer_issue_arrears_title'),
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Container(
                //       margin:
                //           EdgeInsets.only(top: 10.0, left: 25.0, bottom: 20),
                //       child: Text(
                //         ':',
                //         style: TextStyle(
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w500,
                //             color: Colors.grey[600]),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin:
                //             EdgeInsets.only(left: 5.0, top: 10.0, bottom: 20),
                //         child: Text(
                //           "Rp.${data.arrersIdr ?? "-"}",
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
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
                              'Tagihan Lain-lain',
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
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
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
                        'Billing Detail',
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
                            EdgeInsets.only(left: 5.0, top: 20.0, bottom: 20),
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
                // if (data.isPaid == 1)
                //   Row(
                //     children: <Widget>[
                //       Container(
                //         width: 125,
                //         margin:
                //             EdgeInsets.only(left: 20.0, top: 10.0, bottom: 20),
                //         child: Text(
                //           Translations.of(context).text(
                //               'f_household_invoice_detail_tv_payment_status'),
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //       Container(
                //         margin:
                //             EdgeInsets.only(top: 10.0, left: 25.0, bottom: 20),
                //         child: Text(
                //           ':',
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //       Expanded(
                //         child: Container(
                //           margin:
                //               EdgeInsets.only(left: 5.0, top: 10.0, bottom: 20),
                //           child: Text(
                //             Translations.of(context).text(
                //                 'f_commercial_invoice_detail_tv_payment_status_paid'),
                //             style: TextStyle(
                //                 fontSize: 15.0,
                //                 fontWeight: FontWeight.w400,
                //                 color: Colors.grey[600]),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // if (data.isPaid == 0)
                //   Row(
                //     children: <Widget>[
                //       Container(
                //         width: 125,
                //         margin:
                //             EdgeInsets.only(left: 20.0, top: 10.0, bottom: 20),
                //         child: Text(
                //           Translations.of(context).text(
                //               'f_household_invoice_detail_tv_payment_status'),
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //       Container(
                //         margin:
                //             EdgeInsets.only(top: 10.0, left: 25.0, bottom: 20),
                //         child: Text(
                //           ':',
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[600]),
                //         ),
                //       ),
                //       Expanded(
                //         child: Container(
                //           margin:
                //               EdgeInsets.only(left: 5.0, top: 10.0, bottom: 20),
                //           child: Text(
                //             Translations.of(context).text(
                //                 'f_commercial_invoice_detail_tv_payment_status_unpaid'),
                //             style: TextStyle(
                //                 fontSize: 15.0,
                //                 fontWeight: FontWeight.w400,
                //                 color: Colors.grey[600]),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
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
              color: Color(0xFFD3D3D3),
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
        await http.get('${UrlCons.mainProdUrl}invoice/$custID', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });
    CustomerInvoiceResidential _customerInvoice =
        CustomerInvoiceResidential.fromJson(
            json.decode(responseCustomerInvoice.body));
    return _customerInvoice;
  }
}
