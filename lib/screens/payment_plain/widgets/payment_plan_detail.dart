import 'package:flutter/material.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:pgn_mobile/models/cust_invoice_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPlanDetail extends StatefulWidget {
  PaymentPlanDetail({this.paymentPlanID});
  final String paymentPlanID;
  @override
  PaymentPlanDetailState createState() => PaymentPlanDetailState(paymentPlanID);
}

class PaymentPlanDetailState extends State<PaymentPlanDetail> {
  String paymentPlanID;
  PaymentPlanDetailState(this.paymentPlanID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Payment Plan",
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body:
          _buildContent(context, getPaymentPlanDetail(context, paymentPlanID)),
    );
  }

  Widget _buildContent(
      BuildContext context, Future<CustomerInvoice> getInvoiceData) {
    return FutureBuilder<CustomerInvoice>(
        future: getInvoiceData,
        builder: (context, snapshot) {
          return ListView.builder(
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
          );
        });
  }

  Widget _buildRow(DataCustInvoice data) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
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
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 21.0),
                      child: Text(
                        Translations.of(context)
                            .text('f_invoice_paymentplan_detail_tv_topic1'),
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
                            'f_invoice_paymentplan_detail_tv_periodepemakaiangas'),
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
                Row(
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context).text(
                            'f_invoice_paymentplan_detail_tv_totaltagihan'),
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
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context).text(
                            'f_invoice_paymentplan_detail_tv_tanggaljatuhtempo'),
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
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin:
                          EdgeInsets.only(left: 20.0, top: 10.0, bottom: 15),
                      child: Text(
                        Translations.of(context)
                            .text('f_invoice_paymentplan_detail_tv_invoiceid'),
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
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0, top: 21.0),
                        child: Text(
                          Translations.of(context)
                              .text('f_invoice_paymentplan_detail_tv_topic2'),
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600]),
                        ),
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
                        Translations.of(context)
                            .text('f_invoice_paymentplan_detail_tv_nominal'),
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
                Row(
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context)
                            .text('f_invoice_paymentplan_detail_tv_bank'),
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
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context).text(
                            'f_invoice_paymentplan_detail_tv_nomorvirtualaccount'),
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
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin:
                          EdgeInsets.only(left: 20.0, top: 10.0, bottom: 15),
                      child: Text(
                        Translations.of(context)
                            .text('f_invoice_paymentplan_detail_tv_tanggal'),
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
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0, top: 21.0),
                        child: Text(
                          Translations.of(context)
                              .text('f_invoice_paymentplan_detail_tv_topic3'),
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600]),
                        ),
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
                        Translations.of(context)
                            .text('f_invoice_paymentplan_detail_tv_nama'),
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
                Row(
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        Translations.of(context)
                            .text('f_invoice_paymentplan_detail_tv_email'),
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
                  children: <Widget>[
                    Container(
                      width: 125,
                      margin:
                          EdgeInsets.only(left: 20.0, top: 10.0, bottom: 15),
                      child: Text(
                        Translations.of(context).text(
                            'f_invoice_paymentplan_detail_tv_nomorponsel'),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<CustomerInvoice> getPaymentPlanDetail(
    BuildContext context, String paymentPlanID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('access_token');
  var responseCustomerInvoice = await http
      .get('https://api-mobile.pgn.co.id/v2/customers/me/invoices', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });
  CustomerInvoice _customerInvoice =
      CustomerInvoice.fromJson(json.decode(responseCustomerInvoice.body));
  return _customerInvoice;
}
