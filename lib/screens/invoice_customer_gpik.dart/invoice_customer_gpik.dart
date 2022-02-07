import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/models/cust_invoice_model.dart';
import 'package:pgn_mobile/screens/payment_plain/payment_plain.dart';
import 'package:pgn_mobile/screens/payment_plain/widgets/create_payement_plan.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class InvoiceCustGPIRnGPIK extends StatefulWidget {
  InvoiceCustGPIRnGPIK({this.data, this.custID, this.userid});
  final Future<CustomerInvoice> data;
  final String custID;
  final String userid;
  @override
  InvoiceCustGPIRnGPIKState createState() =>
      InvoiceCustGPIRnGPIKState(data, custID, userid);
}

class InvoiceCustGPIRnGPIKState extends State<InvoiceCustGPIRnGPIK>
    with SingleTickerProviderStateMixin {
  Future<CustomerInvoice> data;
  String custID;
  String userid;
  InvoiceCustGPIRnGPIKState(this.data, this.custID, this.userid);
  var prevMonth1, prevMonth2, prevMonth3;
  var currentDate = new DateTime.now();
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 2);
    super.initState();
  }

  Widget build(BuildContext context) {
    // final _prov = Provider.of<UserCred>(context);
    prevMonth1 = currentDate.month - 1;
    prevMonth2 = new DateTime(currentDate.month - 2);
    prevMonth3 = new DateTime(currentDate.month - 3);
    // DateTime newone = DateFormat("MMMM").parse(prevMonth1);
    //print('prevMonth1: ${currentDate.month - 1}');
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int month2 = currentMonth - 1;
    int month3 = currentMonth - 2;
    String y = "10";
    String sNull = "0";
    String month3S, month2S, currentMonthS;
    if (DateTime.now().day >= 5) {
      currentMonth = DateTime.now().month;
      month2 = currentMonth - 1;
      month3 = currentMonth - 2;
    } else {
      currentMonth = DateTime.now().month - 1;
      month2 = currentMonth - 1;
      month3 = currentMonth - 2;
    }

    if (currentMonth == 2) {
      int currentYears = DateTime.now().year - 1;
      // int yearNow = DateTime.now().year;
      String y1 = "12";
      int y2 = 11;

      String cal2 = '$currentYear$y1';
      String cal1 = '$currentYears$y2';
      currentMonthS = '01';
      month2S = cal2;
      month3S = cal1;
    }
    // else if (currentMonth == 3) {
    //   int currentYears = DateTime.now().year - 1;
    //   String y1 = "01";
    //   int y2 = 12;

    //   String cal2 = '$currentYear$y1';
    //   String cal1 = '$currentYears$y2';
    //   currentMonthS = '02';
    //   month2S = cal2;
    //   month3S = cal1;
    // }
    else if (currentMonth == 1) {
      int currentYears = DateTime.now().year - 1;
      int y1 = 11;
      int y2 = 10;
      String cal2 = '$currentYears$y1';
      String cal1 = '$currentYears$y2';
      currentMonthS = '12';
      month2S = cal2;
      month3S = cal1;
    } else {
      currentYear = DateTime.now().year;
      if (currentMonth < 10) {
        currentMonthS = '0$currentMonth$y';
      } else {
        currentMonthS = '${currentMonth.toString()}$y';
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
        '${currentYear.toString()}${currentMonthS.toString()}';
    String dateformatCurrent2 = '${month2S.toString()}10';

    String dateformatCurrent3 = '${month3S.toString()}10';

    String formatDate =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent));
    String formatDate2 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent2));
    String formatDate3 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent3));
    // //print(' DATE FORMAT TITLE CURRENT : $dateformatCurrent');
    // //print(' DATE FORMAT TITLE 2 : $dateformatCurrent2');
    // //print(' DATE FORMAT TITLE paling kiri : $dateformatCurrent3');
    // //print(' DATE FORMAT API CURRENT : $formatDate');
    // //print(' DATE FORMAT API 2 : $formatDate2');
    // //print(' DATE FORMAT API paling kiri : $formatDate3');
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          DefaultTabController(
            length: 3,
            child: Scaffold(
                // backgroundColor: Colors.black,
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
                          indicatorPadding:
                              EdgeInsets.only(left: 15, right: 15),
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
                )),
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

  Widget _buildCharContent2(
      BuildContext context, Future<CustomerInvoice> getInvoiceData, title) {
    return FutureBuilder<CustomerInvoice>(
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

  Widget _buildCharContent0(
      BuildContext context, Future<CustomerInvoice> getInvoiceData, title) {
    return FutureBuilder<CustomerInvoice>(
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
        // if (snapshot.data.data[2] == null)
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

  Widget _buildCharContent1(
      BuildContext context, Future<CustomerInvoice> getInvoiceData, title) {
    return FutureBuilder<CustomerInvoice>(
        future: getInvoiceData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          if (snapshot.data.code == 435)
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
          // if (snapshot.data.data[1] == null)
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
        });
  }

  Widget _buildRow(DataCustInvoice data) {
    // //print('ID STATUSNYA : ${data.paymentStatus.id}');
    if (userid == "17" && data.paymentStatus.display == 'Unpaid' ||
        data.paymentStatus.display == 'Belum Bayar')
      return Container(
        margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
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
                        height: 45,
                        margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/icon_default_pelanggan.png'),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 15.0, top: 5.0),
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
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
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin:
                            EdgeInsets.only(left: 20.0, top: 10.0, bottom: 15),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_invoicenumber'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: 10.0, left: 25.0, bottom: 15),
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
                              EdgeInsets.only(left: 5.0, top: 10.0, bottom: 15),
                          child: Text(
                            data.invoiceId ?? "-",
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
                        margin: EdgeInsets.only(left: 20.0, top: 21.0),
                        child: Text(
                          'Contract Details',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 125,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_min_contract_label'),
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
                            '4 m3/month',
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
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_max_contract_label'),
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
                            '50 m3/month',
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
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_month_label'),
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
                            data.usagePeriod.display ?? "-",
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
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_invoice_month_label'),
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
                            data.invoicePeriod.display ?? "-",
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
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 125,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_calc_volume_label'),
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
                            data.countedVolume.display ?? "-",
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
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_billed_volume_mmbtu_label'),
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
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            data.billedEnergy.display ?? "-",
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
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 125,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_billed_volume_label'),
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
                            data.billedVolume.display ?? "-",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Container(
                  //       width: 125,
                  //       alignment: Alignment.topLeft,
                  //       margin: EdgeInsets.only(left: 20.0),
                  //       child: Text(
                  //         Translations.of(context).text(
                  //             'f_commercial_invoice_detail_tv_warranty_idr_label'),
                  //         style: TextStyle(
                  //             fontSize: 15.0,
                  //             fontWeight: FontWeight.w400,
                  //             color: Colors.grey[600]),
                  //       ),
                  //     ),
                  //     Container(
                  //       alignment: Alignment.topLeft,
                  //       margin: EdgeInsets.only(left: 25.0),
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
                  //         alignment: Alignment.topLeft,
                  //         margin: EdgeInsets.only(left: 5.0),
                  //         child: Text(
                  //           data.pGuaranteeIdr.display ?? "-",
                  //           style: TextStyle(
                  //               fontSize: 15.0,
                  //               fontWeight: FontWeight.w400,
                  //               color: Colors.grey[600]),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Container(
                  //       alignment: Alignment.topLeft,
                  //       width: 125,
                  //       margin: EdgeInsets.only(left: 20.0, bottom: 20),
                  //       child: Text(
                  //         Translations.of(context).text(
                  //             'f_commercial_invoice_detail_tv_warranty_usd_label'),
                  //         style: TextStyle(
                  //             fontSize: 15.0,
                  //             fontWeight: FontWeight.w400,
                  //             color: Colors.grey[600]),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.only(left: 25.0, bottom: 20),
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
                  //         margin: EdgeInsets.only(left: 5.0, bottom: 20),
                  //         child: Text(
                  //           data.pGuaranteeUsd.display ?? "-",
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
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0, top: 22.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_total_idr_label'),
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
                          margin: EdgeInsets.only(left: 5.0, top: 20.0),
                          child: Text(
                            data.tBillIdr.display ?? "-",
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
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_total_usd_label'),
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
                            data.tBillUsd.display ?? "-",
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
                      margin: EdgeInsets.only(
                          top: 11.0, bottom: 11.0, left: 20.0, right: 20.0),
                      child: Divider(color: Colors.grey)),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0, top: 0.0),
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
                        margin: EdgeInsets.only(top: 0.0, left: 25.0),
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
                          margin: EdgeInsets.only(left: 5.0, top: 0.0),
                          child: Text(
                            data.dueDate.display ?? "-",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFF0000)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_payment_date'),
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
                            data.paidDate ?? "-",
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
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin:
                            EdgeInsets.only(left: 20.0, top: 10.0, bottom: 15),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_payment_status'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: 10.0, left: 25.0, bottom: 15),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      if (data.paymentStatus.id == "2" ||
                          data.paymentStatus.id == "1")
                        Container(
                          width: 150,
                          height: 40,
                          margin:
                              EdgeInsets.only(left: 5.0, top: 10.0, bottom: 15),
                          padding: EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFF0000),
                          ),
                          child: Text(
                            data.paymentStatus.display ?? "-",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      if (data.paymentStatus.id == "3")
                        Container(
                          width: 150,
                          height: 40,
                          margin:
                              EdgeInsets.only(left: 5.0, top: 10.0, bottom: 15),
                          padding: EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF73C670),
                          ),
                          child: Text(
                            data.paymentStatus.display ?? "-",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
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
            Row(
              children: <Widget>[
                Container(
                    height: 50.0,
                    width: 170,
                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 15.0, 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF427CEF),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      child: Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 30,
                      ),
                      // Text(
                      //   'List Payment Plan',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentPlain()));
                      },
                    )),
                SizedBox(width: 30),
                Expanded(
                  child: Container(
                    height: 50.0,
                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF427CEF)),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      child: Icon(Icons.add, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatePaymentPlan(
                                    custID: data.invoiceId,
                                    paymentUSD: data.tBillUsd.value.toString(),
                                    paymentUSDdisplay: data.tBillUsd.display)));
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    else
      return Container(
        margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
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
                        height: 45,
                        margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/icon_default_pelanggan.png'),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 15.0, top: 5.0),
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
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
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin:
                            EdgeInsets.only(left: 20.0, top: 10.0, bottom: 15),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_invoicenumber'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: 10.0, left: 25.0, bottom: 15),
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
                              EdgeInsets.only(left: 5.0, top: 10.0, bottom: 15),
                          child: Text(
                            data.invoiceId ?? "-",
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
                        // width: 125,
                        margin: EdgeInsets.only(left: 20.0, top: 21.0),
                        child: Text(
                          'Contract Details',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 125,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_min_contract_label'),
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
                            '4 m3/month',
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
                        width: 125,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_max_contract_label'),
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
                            '50 m3/month',
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
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_month_label'),
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
                            data.usagePeriod.display ?? "-",
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
                        width: 125,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_invoice_month_label'),
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
                            data.invoicePeriod.display ?? "-",
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
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_calc_volume_label'),
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
                            data.countedVolume.display ?? "-",
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
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_billed_volume_label'),
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
                            data.billedVolume.display ?? "-",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                      )
                    ],
                  ),
                  // SizedBox(height: 10),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Container(
                  //       width: 125,
                  //       alignment: Alignment.topLeft,
                  //       margin: EdgeInsets.only(left: 20.0),
                  //       child: Text(
                  //         Translations.of(context).text(
                  //             'f_commercial_invoice_detail_tv_warranty_idr_label'),
                  //         style: TextStyle(
                  //             fontSize: 15.0,
                  //             fontWeight: FontWeight.w400,
                  //             color: Colors.grey[600]),
                  //       ),
                  //     ),
                  //     Container(
                  //       alignment: Alignment.topLeft,
                  //       margin: EdgeInsets.only(left: 25.0),
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
                  //         alignment: Alignment.topLeft,
                  //         margin: EdgeInsets.only(left: 5.0),
                  //         child: Text(
                  //           data.pGuaranteeIdr.display ?? "-",
                  //           style: TextStyle(
                  //               fontSize: 15.0,
                  //               fontWeight: FontWeight.w400,
                  //               color: Colors.grey[600]),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 10,
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
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0, top: 22.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_total_idr_label'),
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
                          margin: EdgeInsets.only(left: 5.0, top: 20.0),
                          child: Text(
                            data.tBillIdr.display ?? "-",
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
                      margin: EdgeInsets.only(
                          top: 11.0, bottom: 11.0, left: 20.0, right: 20.0),
                      child: Divider(color: Colors.grey)),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0, top: 0.0),
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
                        margin: EdgeInsets.only(top: 0.0, left: 25.0),
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
                          margin: EdgeInsets.only(left: 5.0, top: 0.0),
                          child: Text(
                            data.dueDate.display ?? "-",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFF0000)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin: EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_payment_date'),
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
                            data.paidDate ?? "-",
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
                    children: <Widget>[
                      Container(
                        width: 125,
                        margin:
                            EdgeInsets.only(left: 20.0, top: 10.0, bottom: 15),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_payment_status'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: 10.0, left: 25.0, bottom: 15),
                        child: Text(
                          ':',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      if (data.paymentStatus.id == "1")
                        Container(
                          width: 140,
                          height: 40,
                          margin:
                              EdgeInsets.only(left: 5.0, top: 10.0, bottom: 15),
                          padding: EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFF0000),
                          ),
                          child: Text(
                            data.paymentStatus.display ?? "-",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      data.paymentStatus.id == "3"
                          ? Container(
                              width: 140,
                              height: 40,
                              margin: EdgeInsets.only(
                                  left: 5.0, top: 10.0, bottom: 15),
                              padding: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF73C670),
                              ),
                              child: Text(
                                data.paymentStatus.display ?? "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
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
}

Future<CustomerInvoice> getCustomerInvoice(
    BuildContext context, String custID) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString('access_token');
  // String lang = prefs.getString('lang');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');

  var responseCustomerInvoice =
      await http.get('${UrlCons.mainProdUrl}customers/me/invoices', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });
  //print('INI INVOICENYA : ${responseCustomerInvoice.body}');
  // List<dynamic> list = json.decode(responseCustomerInvoice.body);
  // CustomerInvoice _customerInvoice = CustomerInvoice.fromJson(list[0]);
  CustomerInvoice _customerInvoice =
      CustomerInvoice.fromJson(json.decode(responseCustomerInvoice.body));
  return _customerInvoice;
}
