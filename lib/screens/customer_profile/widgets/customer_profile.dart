import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgn_mobile/models/cust_profile_model.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class CustomersTabDetail extends StatelessWidget {
  final Customer data;
  final String idCust;
  CustomersTabDetail(this.data, this.idCust);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          elevation: 5,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/icon_default_pelanggan.png'),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text(data.data.name ?? "-",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          )),
                      SizedBox(height: 5),
                      Text('CM - ${data.data.ae_id} | $idCust',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[400],
                            fontSize: 12.0,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (data.data.imageUrl != "")
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.network(data.data.imageUrl, fit: BoxFit.fill),
                ),
              if (data.data.imageUrl == "")
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/img_default_pelanggan.png')),
                  ),
                ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(bottom: 10),
                padding:
                    EdgeInsets.only(left: 15, top: 17, bottom: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        Translations.of(context)
                            .text('ff_subscription_et_address'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Color(0xFF427CEF))),
                    SizedBox(height: 22),
                    Text(data.data.address ?? "-",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 15.0,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 18, right: 30, top: 21),
                child: Text('Contact Detail',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF427CEF),
                      fontSize: 15.0,
                    )),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 0, right: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 20.0, top: 10),
                          child: Text(
                            Translations.of(context)
                                .text('f_customer_detail_tv_fax'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 10),
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
                            margin: EdgeInsets.only(left: 5.0, top: 10),
                            child: Text(
                              data.data.fax ?? '-',
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
                          width: 140,
                          margin:
                              EdgeInsets.only(left: 20.0, top: 5, bottom: 5),
                          child: Text(
                            Translations.of(context)
                                .text('f_customer_detail_tv_phone'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
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
                            margin:
                                EdgeInsets.only(left: 5.0, top: 5, bottom: 5),
                            child: Text(
                              data.data.phone ?? '-',
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
                          width: 140,
                          margin:
                              EdgeInsets.only(left: 20.0, top: 5, bottom: 5),
                          child: Text(
                            Translations.of(context)
                                .text('f_customer_detail_tv_email'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
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
                            margin:
                                EdgeInsets.only(left: 5.0, top: 5, bottom: 5),
                            child: Text(
                              data.data.personEmail ?? '-',
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
                          width: 140,
                          margin:
                              EdgeInsets.only(left: 20.0, top: 5, bottom: 5),
                          child: Text(
                            Translations.of(context)
                                .text('f_customer_detail_tv_product'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
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
                            margin:
                                EdgeInsets.only(left: 5.0, top: 5, bottom: 5),
                            child: Text(
                              data.data.production ?? '-',
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
                          width: 140,
                          margin:
                              EdgeInsets.only(left: 20.0, top: 5, bottom: 20),
                          child: Text(
                            Translations.of(context)
                                .text('f_customer_detail_tv_sector'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 20),
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
                            margin:
                                EdgeInsets.only(left: 5.0, top: 5, bottom: 20),
                            child: Text(
                              data.data.sectorIndustry ?? '-',
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
              ),
            ],
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 21),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 18, right: 30, top: 30),
                child: Text(
                    Translations.of(context)
                        .text('f_customer_detail_tv_contact'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF427CEF),
                      fontSize: 16.0,
                    )),
              ),
              Container(
                color: Colors.white,
                margin:
                    EdgeInsets.only(left: 0, right: 10, top: 10.0, bottom: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(left: 20.0, top: 10),
                          child: Text(
                            Translations.of(context)
                                .text('ff_customer_profile_et_name'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
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
                            margin: EdgeInsets.only(left: 5.0, top: 10),
                            child: Text(
                              data.data.contactPersonName ?? '-',
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
                          width: 140,
                          margin:
                              EdgeInsets.only(left: 20.0, bottom: 5, top: 10),
                          child: Text(
                            Translations.of(context)
                                .text('f_customer_detail_tv_mobile_phone'),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5, top: 10),
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
                            margin:
                                EdgeInsets.only(left: 5.0, bottom: 5, top: 10),
                            child: Text(
                              data.data.personNumber ?? '-',
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
