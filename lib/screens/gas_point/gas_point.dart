import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pgn_mobile/screens/gas_point/widgets/card_gas_point.dart';
import 'package:pgn_mobile/screens/gas_point/widgets/points_gas_point.dart';
import 'package:pgn_mobile/screens/gas_point/widgets/redeem_gas_point.dart';
import 'package:pgn_mobile/screens/gas_point/widgets/rewards_gas_point.dart';
import 'package:pgn_mobile/screens/gas_point/widgets/tandc_gas_point.dart';

class GasPoint extends StatefulWidget {
  @override
  _GasPointState createState() => _GasPointState();
}

class _GasPointState extends State<GasPoint> with TickerProviderStateMixin {
  TabController _tabController;
  int selectedIndex = 0;
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, length: 5, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              margin: EdgeInsets.only(left: 18, right: 18),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFF4F4F4), width: 2))),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Color(0xFF4578EF),
                labelStyle: TextStyle(),
                indicatorColor: Color(0xFFADADAD),
                unselectedLabelColor: Color(0xFFADADAD),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: Color(0xFF4578EF),
                  ),
                  insets: EdgeInsets.only(
                    left: 0,
                    right: 25,
                  ),
                ),
                labelPadding: EdgeInsets.only(left: 0, right: 25),
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                    // _tabController.index = index;
                  });
                },
                tabs: <Widget>[
                  Tab(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Card'))),
                  Tab(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Rewards'))),
                  Tab(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Points'))),
                  Tab(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Redeem'))),
                  Tab(
                      child: Align(
                          alignment: Alignment.centerLeft, child: Text('T&C'))),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              TabBarView(controller: _tabController, children: [
                CardGaspoint(),
                RewardsGasPoint(),
                PointsGasPoint(),
                RedeemGasPoint(),
                TandCGasPoint()
              ]),
              selectedIndex == 0
                  ? Positioned(
                      bottom: 10,
                      left: 18,
                      right: 18,
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Color(0xFF427CEF),
                        ),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            'Redeem Point',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _tabController.index = 1;
                            });
                          },
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          )),
    );
  }
}
