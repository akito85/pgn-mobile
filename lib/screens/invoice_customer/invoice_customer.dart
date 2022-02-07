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

class InvoiceCust extends StatefulWidget {
  InvoiceCust({this.data, this.custID, this.userid});
  final Future<CustomerInvoice> data;
  final String custID;
  final String userid;
  @override
  BillDetailState createState() => BillDetailState(data, custID, userid);
}

class BillDetailState extends State<InvoiceCust>
    with SingleTickerProviderStateMixin {
  Future<CustomerInvoice> data;
  String custID;
  String userid;
  BillDetailState(this.data, this.custID, this.userid);
  var prevMonth1, prevMonth2, prevMonth3;
  var currentDate = new DateTime.now();
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 2);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          FutureBuilder<CustomerInvoice>(
              future: getCustomerInvoice(context, custID),
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
                return DefaultTabController(
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: BorderSide(
                                          color: Color(0xff427CEF),
                                        ))),
                                tabs: [
                                  Tab(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${snapshot.data.data[0].invoicePeriod.display}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )),
                                  Tab(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${snapshot.data.data[1].invoicePeriod.display}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )),
                                  Tab(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${snapshot.data.data[2].invoicePeriod.display}',
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
                                image:
                                    new AssetImage("assets/new_backgound.jpeg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          TabBarView(
                            controller: _tabController,
                            children: [
                              Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemCount: 1,
                                      itemBuilder: (context, i) {
                                        return i < 1
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 10),
                                                child: _buildRow(
                                                    snapshot.data.data[0]))
                                            : SizedBox(
                                                height: 10.0,
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemCount: 1,
                                      itemBuilder: (context, i) {
                                        return i < 1
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 10),
                                                child: _buildRow(
                                                    snapshot.data.data[1]))
                                            : SizedBox(
                                                height: 10.0,
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemCount: 1,
                                      itemBuilder: (context, i) {
                                        return i < 1
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 10),
                                                child: _buildRow(
                                                    snapshot.data.data[2]))
                                            : SizedBox(
                                                height: 10.0,
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildRow(DataCustInvoice data) {
    //print('ID STATUSNYA : ${data.paymentStatus.id}');
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
                            data.minUsage.display ?? "-",
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
                            data.maxUsage.display ?? "-",
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
                              'f_commercial_invoice_detail_tv_calc_volume_mmbtu_label'),
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
                            data.countedEnergy.display ?? "-",
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
                              'f_commercial_invoice_detail_tv_warranty_idr_label'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
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
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            data.pGuaranteeIdr.display ?? "-",
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
                        margin: EdgeInsets.only(left: 20.0, bottom: 20),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_warranty_usd_label'),
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
                            data.pGuaranteeUsd.display ?? "-",
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
                Expanded(
                  child: Container(
                    height: 50.0,
                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF427CEF)),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        Translations.of(context)
                            .text('title_bar_invoice_residence_paymentplan'),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
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
                ),
                SizedBox(width: 20),
                Container(
                    height: 50.0,
                    width: 100,
                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
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
                            data.minUsage.display ?? "-",
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
                            data.maxUsage.display ?? "-",
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
                              'f_commercial_invoice_detail_tv_calc_volume_mmbtu_label'),
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
                            data.countedEnergy.display ?? "-",
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
                              'f_commercial_invoice_detail_tv_billed_volume_mmbtu_label'),
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
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, top: 10.0),
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
                              'f_commercial_invoice_detail_tv_warranty_idr_label'),
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
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
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            data.pGuaranteeIdr.display ?? "-",
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
                        margin: EdgeInsets.only(left: 20.0, bottom: 20),
                        child: Text(
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_warranty_usd_label'),
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
                            data.pGuaranteeUsd.display ?? "-",
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
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseCustomerInvoice =
      await http.get('${UrlCons.mainProdUrl}customers/me/invoices', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });
  CustomerInvoice _customerInvoice =
      CustomerInvoice.fromJson(json.decode(responseCustomerInvoice.body));
  return _customerInvoice;
}
