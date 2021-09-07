import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/notifications/widgets/pemakaian_abnormal.dart';
import 'package:pgn_mobile/screens/notifications/widgets/jaminan_pembayaran.dart';
import 'package:pgn_mobile/screens/notifications/widgets/kontrak.dart';
import 'package:pgn_mobile/screens/notifications/widgets/tunggakan.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Notifikasi',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: <Widget>[
            DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                        ),
                        height: 50,
                        child: TabBar(
                          indicatorColor: Color(0xff427CEF),
                          indicatorWeight: 1,
                          indicatorPadding:
                              EdgeInsets.only(left: 15, right: 15),
                          labelColor: Colors.white,
                          unselectedLabelColor: Color(0xff427CEF),
                          indicator: ShapeDecoration(
                              color: Color(0xff427CEF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(
                                    color: Color(0xff427CEF),
                                  ))),
                          isScrollable: true,
                          tabs: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Tab(
                                text: Translations.of(context)
                                    .text('title_bar_customer_abnormal_detail'),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Tab(
                                  text: Translations.of(context).text(
                                      'title_bar_customer_guarantee_detail')),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Tab(
                                  text: Translations.of(context).text(
                                      'title_bar_customer_contract_detail')),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Tab(
                                  text: Translations.of(context).text(
                                      'title_bar_customer_invoice_detail')),
                            ),
                          ],
                        ),
                      )
                    ],
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
                      children: <Widget>[
                        PemakaianAbnormal(),
                        JaminanPembayaran(),
                        Kontrak(),
                        Tunggakan()
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
