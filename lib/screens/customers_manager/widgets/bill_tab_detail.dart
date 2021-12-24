import 'package:flutter/material.dart';
import 'package:pgn_mobile/models/cust_list_model.dart';
import 'package:pgn_mobile/models/cust_invoice_model.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class BillDetail extends StatefulWidget {
  BillDetail({this.data, this.dataInvoice});
  final DataListCust data;
  final Future<CustomerInvoice> dataInvoice;
  @override
  BillDetailState createState() => BillDetailState(data, dataInvoice);
}

class BillDetailState extends State<BillDetail> {
  DataListCust data;
  Future<CustomerInvoice> dataInvoice;
  BillDetailState(this.data, this.dataInvoice);
  @override
  Widget build(BuildContext context) {
    if (data == null)
      return ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                        child: Text(
                      data.name,
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    )),
                    SizedBox(width: 15),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Text(
                      data.id ?? "-",
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset('assets/negative_peralatan.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    children: <Widget>[
                      Text(
                        Translations.of(context).text('error_sorry'),
                        style: TextStyle(fontSize: 30.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        Translations.of(context)
                            .text('f_customer_detail_guarantee_tv_empty_desc'),
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    return ListView(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.only(left: 10, right: 10, top: 15),
          elevation: 5,
          child: Container(
            height: 50.0,
            width: 500,
            margin: EdgeInsets.only(bottom: 20.0, top: 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                        child: Text(
                      data.name,
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    )),
                    SizedBox(width: 15),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Text(
                      data.id ?? "-",
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
        ),
        Card1(dataInvoice),
        Card2(dataInvoice),
        Card3(dataInvoice),
        Card(
          margin:
              EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 30.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.grey[200],
          elevation: 5,
          child: Container(
            margin: EdgeInsets.only(
                right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
            child: Text(Translations.of(context)
                .text('f_customer_invoice_tv_footer_notes')),
          ),
        )
      ],
    );
  }
}

class Card1 extends StatelessWidget {
  final Future<CustomerInvoice> dataInvoice;
  Card1(this.dataInvoice);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CustomerInvoice>(
      future: dataInvoice,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.data == null) return SizedBox();
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, i) {
            return snapshot.data.data.length != null
                ? i < snapshot.data.data.length
                    ? _buildRow(context, snapshot.data.data[2])
                    : SizedBox(
                        height: 10.0,
                      )
                : SizedBox(
                    height: 10.0,
                  );
          },
        );
      },
    );
  }

  Widget _buildRow(BuildContext context, DataCustInvoice data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context)
                          .text('row_invoice_paymentplan_invoiceid'),
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
                        data.invoiceId ?? "-",
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context)
                          .text('f_home_tv_chart_minimum_contract'),
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
                        data.minUsage.display ?? "-",
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context)
                          .text('f_home_tv_chart_maximum_contract'),
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
                        data.maxUsage.display ?? "-",
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context)
                          .text('f_household_invoice_detail_tv_month'),
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
                        data.usagePeriod.display ?? "-",
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                    child: Text(
                      Translations.of(context)
                          .text('f_household_invoice_detail_tv_invoice_month'),
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
                        data.invoicePeriod.display ?? "-",
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
        ],
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  final Future<CustomerInvoice> dataInvoice;
  Card2(this.dataInvoice);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CustomerInvoice>(
      future: dataInvoice,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.data == null)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Image.asset('assets/penggunaan_gas.png'),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  "Data Belum Tersedia",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, i) {
            return i < snapshot.data.data.length
                ? _buildRow(context, snapshot.data.data[2])
                : SizedBox(
                    height: 10.0,
                  );
          },
        );
      },
    );
  }

  Widget _buildRow(BuildContext context, DataCustInvoice data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              // for(var i in Iterable.generate(7))
              Row(
                children: <Widget>[
                  Container(
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_calc_volume_mmbtu_label'),
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
                        data.countedEnergy.display ?? "-",
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_calc_volume_label'),
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
                        data.countedVolume.display ?? "-",
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_billed_volume_mmbtu_label'),
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
                        data.billedEnergy.display ?? "-",
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                    child: Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_billed_volume_label'),
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
                        data.billedVolume.display ?? "-",
                        style: TextStyle(
                            fontSize: 13.0,
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
              //       width: 150,
              //       margin: EdgeInsets.only(left: 20.0, top: 15),
              //       child: Text(
              //         Translations.of(context).text(
              //             'f_commercial_invoice_detail_tv_warranty_idr_label'),
              //         style: TextStyle(
              //             fontSize: 13.0,
              //             fontWeight: FontWeight.w400,
              //             color: Colors.grey[600]),
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(left: 10.0, top: 15),
              //       child: Text(
              //         ':',
              //         style: TextStyle(
              //             fontSize: 13.0,
              //             fontWeight: FontWeight.w400,
              //             color: Colors.grey[600]),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         margin: EdgeInsets.only(left: 5.0, top: 15),
              //         child: Text(
              //           data.pGuaranteeIdr.display ?? "-",
              //           style: TextStyle(
              //               fontSize: 13.0,
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
              //       width: 150,
              //       margin: EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
              //       child: Text(
              //         Translations.of(context).text(
              //             'f_commercial_invoice_detail_tv_warranty_usd_label'),
              //         style: TextStyle(
              //             fontSize: 12.5,
              //             fontWeight: FontWeight.w400,
              //             color: Colors.grey[600]),
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
              //       child: Text(
              //         ':',
              //         style: TextStyle(
              //             fontSize: 13.0,
              //             fontWeight: FontWeight.w400,
              //             color: Colors.grey[600]),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         margin: EdgeInsets.only(left: 5.0, top: 15, bottom: 15),
              //         child: Text(
              //           data.pGuaranteeUsd.display ?? "-",
              //           style: TextStyle(
              //               fontSize: 13.0,
              //               fontWeight: FontWeight.w400,
              //               color: Colors.grey[600]),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class Card3 extends StatelessWidget {
  final Future<CustomerInvoice> dataInvoice;
  Card3(this.dataInvoice);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CustomerInvoice>(
        future: dataInvoice,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          if (snapshot.data.data == null) return SizedBox();
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, i) {
              return i < snapshot.data.data.length
                  ? _buildRow(context, snapshot.data.data[2])
                  : SizedBox(
                      height: 10.0,
                    );
            },
          );
        });
  }

  Widget _buildRow(BuildContext context, DataCustInvoice data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_total_idr_label'),
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
                        data.tBillIdr.display ?? "-",
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_total_usd_label'),
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
                        data.tBillUsd.display ?? "-",
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15),
                    child: Text(
                      Translations.of(context)
                          .text('f_commercial_invoice_detail_tv_duedate'),
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
                        data.dueDate.display ?? "-",
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                  )
                ],
              ),
              if (data.isPaid == 1)
                Row(
                  children: <Widget>[
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        Translations.of(context).text(
                            'f_commercial_invoice_detail_tv_payment_status'),
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
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_payment_status_paid'),
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
              if (data.isPaid == 0)
                Row(
                  children: <Widget>[
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        Translations.of(context).text(
                            'f_commercial_invoice_detail_tv_payment_status'),
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
                          Translations.of(context).text(
                              'f_commercial_invoice_detail_tv_payment_status_unpaid'),
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
                    width: 150,
                    margin: EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                    child: Text(
                      Translations.of(context)
                          .text('f_commercial_invoice_detail_tv_payment_date'),
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
                        data.paidDate ?? '-',
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
        ],
      ),
    );
  }
}
