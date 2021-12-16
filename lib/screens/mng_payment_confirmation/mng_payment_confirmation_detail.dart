import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/payment_confirmation_model.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class CustomerPaymentConfirmation extends StatefulWidget {
  final MngPaymentModel mngPaymentModel;
  final String idCust;
  CustomerPaymentConfirmation({this.mngPaymentModel, this.idCust});
  @override
  _CustomerPaymentConfirmation createState() => _CustomerPaymentConfirmation(
      mngPaymentModel: mngPaymentModel, idCust: idCust);
}

class _CustomerPaymentConfirmation extends State<CustomerPaymentConfirmation>
    with SingleTickerProviderStateMixin {
  final MngPaymentModel mngPaymentModel;
  final String idCust;
  _CustomerPaymentConfirmation({this.mngPaymentModel, this.idCust});
  var currentDate = new DateTime.now();
  TabController _tabController;
  String nameCust = "";

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int month2 = currentMonth - 1;
    int month3 = currentMonth - 2;
    String month3S, month2S, currentMonthS;
    String y = "10";
    String sNull = "0";
    if (currentMonth == 2) {
      int currentYears = DateTime.now().year - 1;
      // int y1 = 12;
      // int y2 = 01;
      currentMonthS = '02';
      String cal2 = '${currentYears + 1}01';
      String cal1 = '${currentYears}12';
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
        print('MASUK SINI KAH : $currentMonthS');
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
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          Translations.of(context).text('pc_tab_title'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white),
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
                  ]),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new AssetImage("assets/new_backgound.jpeg"),
                        fit: BoxFit.fill)),
              ),
              TabBarView(controller: _tabController, children: [
                _buildContent(context, mngPaymentModel.data[0]),
                _buildContent(context, mngPaymentModel.data[1]),
                _buildContent(context, mngPaymentModel.data[2]),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CustModel model) {
    return buildRow(context, model);
  }

  Widget buildRow(BuildContext context, CustModel model) {
    DateTime date = DateTime.parse(
        model.payDate != "" ? model.payDate : DateTime.now().toString());
    return ListView(
      children: [
        Card(
          margin: EdgeInsets.only(top: 20, right: 16, left: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
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
                      margin: EdgeInsets.only(left: 15.0, top: 5.0),
                      child: Text(
                        "-",
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
                        idCust ?? "-",
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
                height: 15,
              )
            ],
          ),
        ),
        Card(
          margin: EdgeInsets.only(top: 20, right: 16, left: 16),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(
                        Translations.of(context).text('pc_tab_title_desc'),
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
                      width: 120,
                      child: Text('Information Date',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
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
                          model.payDate != ""
                              ? DateFormat("d MMMM yyyy")
                                      .format(date)
                                      .toString() ??
                                  "-"
                              : "-",
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
                        width: 120,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text('Channel',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0))),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
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
                          model.ca != "" ? model.ca : "-",
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
                      width: 120,
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text('Besaran',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
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
                          '${model.payAmt} ${model.payCurrCode}',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
                //0150019822
                Row(
                  children: <Widget>[
                    Container(
                      width: 120,
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text('Payment Status',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
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
                          model.paymentStatus != "" ? model.paymentStatus : "-",
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
        ),
      ],
    );
  }
}
