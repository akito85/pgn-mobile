import 'package:flutter/material.dart';
import 'package:pgn_mobile/models/cust_profile_model.dart';
import 'package:pgn_mobile/screens/customer_profile/widgets/customer_profile.dart';

import 'package:pgn_mobile/screens/customer_profile/widgets/cust_tab_payment.dart';
import 'package:pgn_mobile/screens/customer_profile/widgets/cust_tab_contract.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class CustomerDetail extends StatefulWidget {
  CustomerDetail({this.data, this.idCust});

  final Customer data;
  final String idCust;
  @override
  CustomerState createState() => CustomerState(data, idCust);
}

class CustomerState extends State<CustomerDetail> {
  Customer data;
  String idCust;
  CustomerState(this.data, this.idCust);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                height: 45,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Color(0xFF4578EF),
                  indicatorWeight: 1,
                  indicatorPadding: EdgeInsets.only(left: 15, right: 15),
                  labelColor: Colors.white,
                  unselectedLabelColor: Color(0xFF4578EF),
                  indicator: ShapeDecoration(
                    color: Color(0xFF4578EF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Color(0xFF4578EF)),
                    ),
                  ),
                  tabs: <Widget>[
                    Tab(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        Translations.of(context)
                            .text('title_bar_customer_detail'),
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
                    Tab(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        Translations.of(context)
                            .text('f_customer_contracts_title'),
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
                    Tab(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        Translations.of(context)
                            .text('f_customer_guarantees_title'),
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
                  ],
                ),
              )
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
              children: <Widget>[
                CustomersTabDetail(data, idCust),
                ContractDetailSales(data: data, idCust: idCust),
                PaymentDetailSales(data: data, idCust: idCust)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
