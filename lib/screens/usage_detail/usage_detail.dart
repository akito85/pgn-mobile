import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/tab_1_detail.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/tab_2_detail.dart';
import 'package:pgn_mobile/screens/usage_detail/widgets/tab_3_detail.dart';

class UsageDetail extends StatefulWidget {
  @override
  UsageDetailState createState() => UsageDetailState();
}

class UsageDetailState extends State<UsageDetail>
    with TickerProviderStateMixin {
  Widget appBarTitle = new Text(
    "Usage Detail",
    style: TextStyle(color: Colors.black),
  );
  Icon actionIcon = new Icon(Icons.search, color: Colors.black);
  TabController _tabController;
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, length: 3, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  width: 380,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    labelColor: Colors.blue,
                    indicatorColor: Colors.black,
                    unselectedLabelColor: Color(0xFF427CEF),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF4578EF),
                    ),
                    onTap: (index) {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                    tabs: <Widget>[
                      Tab(
                        child: Container(
                          height: 30,
                          width: 30,
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                  'assets/icon_all_categories_on.png',
                                  color: _tabController.index == 0
                                      ? Colors.white
                                      : Color(0xFF427CEF))),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 30,
                          width: 30,
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                  'assets/icon_top_ten_gain_on.png',
                                  color: _tabController.index == 1
                                      ? Colors.white
                                      : Color(0xFF427CEF))),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 30,
                          width: 30,
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                  'assets/icon_top_ten_down_on.png',
                                  color: _tabController.index == 2
                                      ? Colors.white
                                      : Color(0xFF427CEF))),
                        ),
                      ),
                    ],
                  ),
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
              controller: _tabController,
              children: <Widget>[
                FirstTab(),
                PeningkatanTab(),
                PenurunanTab(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
