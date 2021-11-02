import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/invoice_model.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> with SingleTickerProviderStateMixin {
  var currentDate = new DateTime.now();
  TabController _tabController;
  List<CustModel> list = <CustModel>[];

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this, initialIndex: 4);
    String strCurrentDate = DateFormat('MMM-yyyy').format(currentDate);
    String endCurrentDate = DateFormat('MMM-yyyy').format(currentDate);
    getCustomerInvoice(context, "01-MAR-2020", "30-MAR-2020");
    // getCustomerInvoice(context, "01-$strCurrentDate", "30-$endCurrentDate");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentYear = new DateTime.now().year;
    int currentMonth = new DateTime.now().month;
    int month2 = currentMonth - 1;
    int month3 = currentMonth - 2;
    int month4 = currentMonth - 3;
    int month5 = currentMonth - 4;

    var startDate2 = new DateTime(month2);
    var startDate3 = new DateTime(month3);
    var startDate4 = new DateTime(month4);
    var startDate5 = new DateTime(month5);

    String sNull = "0";
    String month5s, month4S, month3S, month2S, currentMonthS;

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
      int y3 = 10;
      int y4 = 09;
      String cal2 = '$currentYears$y1';
      String cal1 = '$currentYears$y2';
      String cal3 = '$currentYears$y3';
      String cal4 = '$currentYears$y4';
      currentMonthS = '01';
      month2S = cal2;
      month3S = cal1;
      month4S = cal3;
      month5s = cal4;
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

      if (month4 < 10) {
        month4S = '$currentYear$sNull$month4';
      } else {
        month4S = '$currentYear$month4';
      }

      if (month5 < 10) {
        month5s = '$currentYear$sNull$month5';
      } else {
        month5s = '$currentYear$sNull$month5';
      }
    }
    String dateformatCurrent =
        '${currentYear.toString()}${currentMonthS.toString()}10';
    String dateformatCurrent2 = '${month2S.toString()}10';
    String dateformatCurrent3 = '${month3S.toString()}10';
    String dateformatCurrent4 = '${month4S.toString()}10';
    String dateformatCurrent5 = '${month5s.toString()}10';

    String formatDate =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent));
    String formatDate2 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent2));
    String formatDate3 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent3));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            Translations.of(context).text('a_payment_title'),
            style: TextStyle(color: Colors.black, fontSize: 18),
          )),
      body: Stack(
        children: <Widget>[
          DefaultTabController(
              length: 5,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white),
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
                              onTap: (index) {
                                if (index == 0) {
                                  setState(() {
                                    list.clear();
                                  });
                                  getCustomerInvoice(
                                      context,
                                      "01-" +
                                          DateFormat("MMM").format(
                                              DateTime.parse(
                                                  dateformatCurrent5)) +
                                          "-" +
                                          currentDate.year.toString(),
                                      "30-" +
                                          DateFormat("MMM").format(
                                              DateTime.parse(
                                                  dateformatCurrent5)) +
                                          "-" +
                                          currentDate.year.toString());
                                } else if (index == 1) {
                                  setState(() {
                                    list.clear();
                                  });
                                  getCustomerInvoice(
                                      context,
                                      "01-" +
                                          DateFormat("MMM").format(
                                              DateTime.parse(
                                                  dateformatCurrent4)) +
                                          "-" +
                                          currentDate.year.toString(),
                                      "30-" +
                                          DateFormat("MMM").format(
                                              DateTime.parse(
                                                  dateformatCurrent4)) +
                                          "-" +
                                          currentDate.year.toString());
                                } else if (index == 2) {
                                  setState(() {
                                    list.clear();
                                  });
                                  getCustomerInvoice(
                                      context,
                                      "01-" +
                                          DateFormat("MMM").format(
                                              DateTime.parse(
                                                  dateformatCurrent3)) +
                                          "-" +
                                          currentDate.year.toString(),
                                      "30-" +
                                          DateFormat("MMM").format(
                                              DateTime.parse(
                                                  dateformatCurrent3)) +
                                          "-" +
                                          currentDate.year.toString());
                                } else if (index == 3) {
                                  setState(() {
                                    list.clear();
                                  });
                                  getCustomerInvoice(
                                      context,
                                      "01-" +
                                          DateFormat("MMM").format(
                                              DateTime.parse(
                                                  dateformatCurrent2)) +
                                          "-" +
                                          currentDate.year.toString(),
                                      "30-" +
                                          DateFormat("MMM").format(
                                              DateTime.parse(
                                                  dateformatCurrent2)) +
                                          "-" +
                                          currentDate.year.toString());
                                }
                                // else if (index == 4) {
                                //   setState(() {
                                //     list.clear();
                                //   });
                                //   getCustomerInvoice(
                                //       context,
                                //       "01-" +
                                //           DateFormat('MMM-yyyy')
                                //               .format(currentDate),
                                //       "30-" +
                                //           DateFormat('MMM-yyyy')
                                //               .format(currentDate));
                                // }
                              },
                              tabs: [
                                Tab(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent5))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent3))}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent4))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent3))}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent3))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent3))}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent2))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent2))}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent))}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                    preferredSize: Size.fromHeight(kToolbarHeight)),
                body: Stack(
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              image:
                                  new AssetImage("assets/new_backgound.jpeg"),
                              fit: BoxFit.fill)),
                    ),
                    TabBarView(controller: _tabController, children: [
                      _buildContent(context),
                      _buildContent(context),
                      _buildContent(context),
                      _buildContent(context),
                      _buildContent(context)
                    ])
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: list.length + 1,
          itemBuilder: (context, int index) {
            return index < list.length
                ? buildRow(context, list[index])
                : SizedBox(height: 10);
          }),
    );
  }

  Future<InvoiceModel> getCustomerInvoice(
      BuildContext context, String startDate, String endDate) async {
    final storageCache = FlutterSecureStorage();
    String customerIDs = await storageCache.read(key: 'customer_id');
    String accessToken = await storageCache.read(key: 'access_token');
    print('StartDate' + startDate);
    print('EndDate' + endDate);
    var body = json.encode({
      "P_PAY_DATE_FROM": startDate,
      "P_PAY_DATE_TO": endDate,
      "P_CUST_NUMBER": customerIDs
    });
    var responseCustomerInvoice = await http.post(
        "https://sandbox.pgn.co.id/api-mobile/PGNCRMCustPaymentRS",
        headers: {
          'Content-Type': 'application/json',
          'PGN-Key': 'ecd1bcb5b7cf463d94b7c5f25948e687',
          'Ocp-Apim-Trace': 'true',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);
    if (responseCustomerInvoice.body != null) {
      InvoiceModel _custInvoice =
          InvoiceModel.fromJson(json.decode(responseCustomerInvoice.body));
      setState(() {
        list.addAll(_custInvoice.data);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Tidak Ada Data')));
    }
    return InvoiceModel.fromJson(json.decode(responseCustomerInvoice.body));
  }
}

Widget buildRow(BuildContext context, CustModel model) {
  DateTime date = DateTime.parse(model.payDate);
  return Card(
    margin: EdgeInsets.only(top: 24, right: 16, left: 16),
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    color: Colors.white,
    child: Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Information Date',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0)),
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
                    DateFormat("d MMMM yyyy").format(date).toString() ?? "-",
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
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text('Channel',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0))),
              Container(
                margin: EdgeInsets.only(left: 25.0, top: 10.0),
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
                    model.ca ?? "-",
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
                margin: EdgeInsets.only(top: 10.0),
                child: Text('Besaran',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0)),
              ),
              Container(
                margin: EdgeInsets.only(left: 25.0, top: 10.0),
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
                    model.payNum ?? "-",
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
                margin: EdgeInsets.only(top: 10.0),
                child: Text('Payment Status',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0)),
              ),
              Container(
                margin: EdgeInsets.only(left: 25.0, top: 10.0),
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
                    model.paymentStatus ?? "-",
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
  );
}
