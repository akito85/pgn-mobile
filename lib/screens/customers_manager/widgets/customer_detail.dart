import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/cust_list_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/customers_manager/widgets/cust_tab_detail.dart';
import 'package:pgn_mobile/screens/customers_manager/widgets/bill_tab_detail.dart';
import 'package:pgn_mobile/screens/customers_manager/widgets/tools_tab_detail.dart';
import 'package:pgn_mobile/screens/customers_manager/widgets/payment_tab_detail.dart';
import 'package:pgn_mobile/screens/customers_manager/widgets/contract_tab_detail.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/cust_invoice_model.dart';

class CustomersDetail extends StatefulWidget {
  CustomersDetail({this.data});

  final DataListCust data;
  @override
  CustomerState createState() => CustomerState(data);
}

class CustomerState extends State<CustomersDetail>
    with TickerProviderStateMixin {
  DataListCust data;
  CustomerState(this.data);
  TabController _controller;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _controller,
            labelColor: Colors.white,
            indicator: ShapeDecoration(
                color: Color(0xff427CEF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                      color: Color(0xff427CEF),
                    ))),
            unselectedLabelColor: Color(0xFF427CEF),
            indicatorColor: Colors.blue[300],
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(Translations.of(context)
                        .text('a_home_tv_menu_my_profile')),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(Translations.of(context)
                        .text('title_bar_contract_history')),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(Translations.of(context)
                        .text('title_bar_customer_guarantee_detail')),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(Translations.of(context)
                        .text('f_customer_equipments_title')),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(Translations.of(context)
                        .text('f_customer_invoice_title')),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            Translations.of(context).text('title_bar_customer'),
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/new_backgound.jpeg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TabBarView(
              controller: _controller,
              children: <Widget>[
                CustomersTabDetail(data),
                ContractDetail(data: data),
                PaymentDetail(data: data),
                ToolsDetail(data: data),
                BillDetail(
                    data: data, dataInvoice: fetchPost(context, data.id)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<CustomerInvoice> fetchPost(BuildContext context, String id) async {

  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseCustInvoice = await http.get(
    '${UrlCons.mainProdUrl}invoice/$id',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    },
  );
  CustomerInvoice _getCustInvoice =
      CustomerInvoice.fromJson(json.decode(responseCustInvoice.body));

  return _getCustInvoice;
}
