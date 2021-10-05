import 'dart:math';
import 'package:charts_flutter/src/text_element.dart' as element;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pgn_mobile/models/dashboard_chart_invoice_residential.dart';
import 'package:pgn_mobile/models/dashboard_customer_model.dart';
import 'package:pgn_mobile/models/gas_point_model.dart' as modelGP;
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/dashboard/dashboard_cust_add.dart';
import 'package:pgn_mobile/screens/gas_point/gas_point.dart';
import 'package:pgn_mobile/screens/otp/otp.dart';
import 'package:pgn_mobile/screens/invoice_customer_gpik.dart/invoice_customer_gpik.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/widgets/navigation_drawer.dart';
import 'package:pgn_mobile/screens/dashboard/widgets/dashboard_detail.dart';
import 'package:pgn_mobile/screens/dashboard/widgets/dashboard_detail_cust.dart';
import 'package:pgn_mobile/screens/settings/settings.dart';
import 'package:pgn_mobile/services/user_credientials.dart';
import 'package:pgn_mobile/widgets/push_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/cust_profile_model.dart';
import 'package:pgn_mobile/models/customer_profile_residential.dart';
import 'package:pgn_mobile/models/dashboard_chart_model.dart';
import 'package:date_format/date_format.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pgn_mobile/screens/cutomer_bill/customer_bill.dart';
import 'package:pgn_mobile/screens/usage_detail/usage_detail.dart';
import 'package:pgn_mobile/models/cust_invoice_model.dart';
import 'package:pgn_mobile/models/customer_invoce_residential_model.dart';
import 'package:pgn_mobile/screens/invoice_customer/invoice_customer.dart';
import 'package:pgn_mobile/screens/invoice_customer_residential/invoce_customer_residential.dart';
import 'package:pgn_mobile/screens/customers_manager/customers.dart';
import 'package:pgn_mobile/screens/customer_profile/customer_profile.dart';
import 'package:pgn_mobile/screens/customer_profile_residential/customer_profile_residential.dart';
import 'package:pgn_mobile/screens/usage_detail_cust/usage_detail_cust.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  String noValue = ' ';
  String pointGasPoint = '0';
  bool harianCustVisible = true;
  TabController _tabController;
  String greetings;
  DateTime currentDate = DateTime.now();
  Icon actionIcon = new Icon(
    Icons.settings,
    color: Colors.black,
  );
  String sysLng = ui.window.locale.languageCode;
  String titleMng;
  String titleCust;
  String custID;
  String userType;
  String groupID;
  String customerID;
  String customerGroupID;
  final storageCache = new FlutterSecureStorage();
  List<SummaryModel> datanyaIdr(List<DataChartIdr> data) {
    final mockedData = List<SummaryModel>();
    data.forEach((itemData) {
      var a = DateTime(itemData.month, itemData.month, itemData.month);

      mockedData.add(SummaryModel(formatDate((a), [M]),
          double.parse(itemData.value.replaceAll(new RegExp(r','), ''))));
    });
    return mockedData;
  }

  List<SummaryModel> datanyaUsd(List<DataChartUsd> data) {
    final mockedData = List<SummaryModel>();
    data.forEach((itemData) {
      var a = DateTime(itemData.month, itemData.month, itemData.month);

      mockedData.add(SummaryModel(formatDate((a), [M]),
          double.parse(itemData.value.replaceAll(new RegExp(r','), ''))));
    });
    return mockedData;
  }

  List<SummaryModel> dataMonthly(List<UsageMonthlyChart> data) {
    final mockedData = List<SummaryModel>();
    data.forEach((itemData) {
      var a = DateTime.parse(itemData.date.value);

      mockedData.add(SummaryModel(
          formatDate((a), [M]), double.parse(itemData.usage.value.toString())));
    });
    return mockedData;
  }

  List<SummaryModel> dataInvoiceResi(List<DataChartInvoiceResi> data) {
    final mockedData = List<SummaryModel>();
    data.forEach((itemData) {
      var a = DateTime.parse(itemData.dateVal);

      mockedData.add(SummaryModel(formatDate((a), [M]),
          double.parse(itemData.value.replaceAll(new RegExp(r','), ''))));
    });
    return mockedData;
  }

  List<CustDailyModel> dataHarianYangDiInput(List<UsageDailyChart> data) {
    final myFakeDesktopData = List<CustDailyModel>();
    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      myFakeDesktopData.add(CustDailyModel(
          int.parse(formatDate(todayDate, [dd])), itemData.usage.value));
    });

    return myFakeDesktopData;
  }

  List<charts.Series<SummaryModel, String>> _createSampleDataIdr(
      List<DataChartIdr> data) {
    return [
      charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (SummaryModel sales, _) => sales.month.toString(),
        measureFn: (SummaryModel sales, _) => sales.value,
        data: datanyaIdr(data),
      )
    ];
  }

  List<charts.Series<SummaryModel, String>> _createSampleDataUsd(
      List<DataChartUsd> data) {
    return [
      charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (SummaryModel sales, _) => sales.month.toString(),
        measureFn: (SummaryModel sales, _) => sales.value,
        data: datanyaUsd(data),
      )
    ];
  }

  List<charts.Series<CustDailyModel, int>> _createSampleDataHarian(
      List<UsageDailyChart> data) {
    return [
      charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (CustDailyModel sales, _) => sales.value,
        measureFn: (CustDailyModel sales, _) => sales.month,
        data: dataHarianYangDiInput(data),
      ),
    ];
  }

  List<charts.Series<SummaryModel, String>> _createSampleDataInvoiceResi(
      List<DataChartInvoiceResi> data) {
    return [
      charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (SummaryModel sales, _) => sales.month.toString(),
        measureFn: (SummaryModel sales, _) => sales.value,
        data: dataInvoiceResi(data),
      ),
    ];
  }

  List<charts.Series<SummaryModel, String>> _createSampleDataMonthly(
      List<UsageMonthlyChart> data) {
    return [
      charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (SummaryModel sales, _) => sales.month.toString(),
        measureFn: (SummaryModel sales, _) => sales.value,
        data: dataMonthly(data),
      )
    ];
  }

  @override
  final List<CustReiTabs> _tabsResi = [
    new CustReiTabs(title: 'Dashboard'),
    new CustReiTabs(title: 'Invoice'),
    new CustReiTabs(title: 'Gas Poin'),
    new CustReiTabs(title: 'My Profile'),
  ];
  final List<CustTabs> _tabs = [
    new CustTabs(title: 'Dashboard'),
    new CustTabs(title: 'Customer Invoice'),
    new CustTabs(title: 'Usage'),
    new CustTabs(title: 'Customer Detail'),
  ];

  CustTabs _myHandler;
  CustReiTabs _myHandlerRei;
  TabController _controller;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    getTitleCust();
    getVirtualCardGasPoint(context);
    _firebaseMsgListener();

    _controller = new TabController(length: 4, vsync: this);
    _myHandler = _tabs[0];
    _myHandlerRei = _tabsResi[0];
    _controller.addListener(_handleSelected);
  }

  void _firebaseMsgListener() {
    Future.delayed(Duration(seconds: 1), () {
      _firebaseMessaging.configure(
        onBackgroundMessage: myBackgroundMessageHandler,
        onMessage: (Map<String, dynamic> message) async {
          print("=====>on message $message");
          // print("ON MESSGAE");
          // print("INI RETURN ${message['data']['type']}");
          // print("ON");
          if (message['data']['type'] == "promosi") {
            // print("TRUE ITS NOT DAILY USAGE");
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                    message['data']['imageURL'],
                    message['data']['redirectURL']));
          } else {
            print('FALSE');
          }
        },
        onResume: (Map<String, dynamic> message) async {
          if (message['data']['type'] == "promosi") {
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                    message['data']['imageURL'],
                    message['data']['redirectURL']));
          }
        },
        onLaunch: (Map<String, dynamic> message) async {
          if (message['data']['type'] == "promosi") {
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                    message['data']['imageURL'],
                    message['data']['redirectURL']));
          }
        },
      );
    });
  }

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }
    return Future<void>.value();
  }

  void _handleSelected() {
    setState(() {
      _myHandler = _tabs[_controller.index];
      _myHandlerRei = _tabsResi[_controller.index];
    });
  }

  void getTitleCust() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //  final storageCache = new FlutterSecureStorage();
    String titleMngs = await storageCache.read(key: 'user_name_cust') ?? "";
    String titleCusts = await storageCache.read(key: 'user_name_cust') ?? "";
    String custIDs = await storageCache.read(key: 'user_id') ?? "";
    String userTypes = await storageCache.read(key: 'user_type') ?? "";
    String groupIDs = await storageCache.read(key: 'usergroup_id') ?? "";
    String customerIDs = await storageCache.read(key: 'customer_id') ?? "";
    String customerGroupIDs =
        await storageCache.read(key: 'customer_groupId') ?? "";

    print('USRER TYPE GET AUTH : ${await storageCache.read(key: 'user_type')}');
    setState(() {
      titleMng = titleMngs;
      titleCust = titleCusts;
      custID = custIDs;
      userType = userTypes;
      groupID = groupIDs;
      customerID = customerIDs;
      customerGroupID = customerGroupIDs;
      print('USRER TYPE GET AUTH : $customerID');
      // titleMng = prefs.getString('user_name_cust') ?? "";
      // titleCust = prefs.getString('user_name_cust') ?? "";
      // custID = prefs.getString('user_id') ?? "";
      // userType = prefs.getString('user_type') ?? "";
      // groupID = prefs.getString('usergroup_id') ?? "";
      // customerID = prefs.getString('customer_id') ?? "";
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getTitleCust();
    print('USRER TYPE : $userType');
    String currentTime = DateFormat('kkmm').format(currentDate);
    if (int.parse(currentTime) <= 1100) {
      greetings =
          Translations.of(context).text('f_home_tv_chart_greeting_morning');
    } else if (int.parse(currentTime) >= 1101 &&
        int.parse(currentTime) <= 1400) {
      greetings =
          Translations.of(context).text('f_home_tv_chart_greeting_afternoon');
    } else if (int.parse(currentTime) >= 1401 &&
        int.parse(currentTime) <= 1800) {
      greetings =
          Translations.of(context).text('f_home_tv_chart_greeting_evening');
    } else if (int.parse(currentTime) >= 1801 &&
        int.parse(currentTime) <= 2300) {
      greetings =
          Translations.of(context).text('f_home_tv_chart_greeting_night');
    }
    final _prov = Provider.of<UserCred>(context);

    if (userType == "1") {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.blue[600],
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            // title: Text(Translations.of(context).text('${_myHandler.title}'),
            title: Text(
              _myHandler.title,
              style: painting.TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                icon: actionIcon,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: NavigationDrawer(),
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
                controller: _controller,
                children: <Widget>[
                  _buildDahsboardManager(context, _prov.userName.toString()),
                  CustomerBills(),
                  UsageDetail(),
                  Customers(),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              color: painting.Color(0xff427CEF),
            ),
            height: 55,
            child: TabBar(
              controller: _controller,
              tabs: <Widget>[
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.dashboard),
                      SizedBox(height: 5),
                      Text(
                        'Dashboard',
                        style: painting.TextStyle(fontSize: 11),
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.description),
                      SizedBox(height: 5),
                      Text(
                        'Invoice',
                        style: painting.TextStyle(fontSize: 11),
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.donut_large),
                      SizedBox(height: 5),
                      Flexible(
                          child: Text(
                        'Usage',
                        style: painting.TextStyle(fontSize: 11),
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ))
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.person_outline),
                      SizedBox(height: 5),
                      Text(
                        'Customers',
                        style: painting.TextStyle(fontSize: 11),
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      )
                    ],
                  ),
                ),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: painting.Color(0xff427CEF),
            ),
          ),
        ),
      );
    } else if (userType == "2" && groupID == "11") {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              _myHandlerRei.title,
              // '',
              style: painting.TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image(
                    image: AssetImage('assets/setting.png'),
                    height: 28,
                    width: 28,
                  ),
                ),
              ),
              // IconButton(
              //     icon: actionIcon,
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => Settings()));
              //     })
            ],
          ),
          drawer: Drawer(
            child: NavigationDrawer(),
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
                controller: _controller,
                children: <Widget>[
                  _buildDashboardResidential(
                      context, _prov.custName.toString() ?? ""),
                  // customerGroupID == '1'
                  //     ? showCustInvoiceGPIRnGPIK(context,
                  //         getCustomerInvoice(context), _prov.custId, groupID)
                  //     :
                  showCustInvoiceCustomerResidential(context,
                      getCustomerInvoiceResidential(context), _prov.custId),
                  GasPoint(),
                  showCustProfileCustomerResidential(
                      context, getCustomerProfileResidential(context))
                ],
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              color: painting.Color(0xff427CEF),
            ),
            height: 55,
            child: TabBar(
              controller: _controller,
              tabs: <Widget>[
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.dashboard),
                      SizedBox(height: 5),
                      Text(
                        'Dashboard',
                        style: painting.TextStyle(fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.description),
                      SizedBox(height: 5),
                      Text('Invoice', style: painting.TextStyle(fontSize: 11))
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.donut_large),
                      SizedBox(height: 5),
                      Text('Gas Point', style: painting.TextStyle(fontSize: 11))
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.person_outline),
                      SizedBox(height: 5),
                      Text('My Profile',
                          style: painting.TextStyle(fontSize: 11))
                    ],
                  ),
                ),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: painting.Color(0xff427CEF),
            ),
          ),
        ),
      );
    } else if (userType == "2" && groupID != "11") {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              _myHandler.title,
              style: painting.TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                  icon: actionIcon,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  }),
            ],
          ),
          drawer: Drawer(
            child: NavigationDrawer(),
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
                controller: _controller,
                children: <Widget>[
                  _buildDashboardSales(
                      context, _prov.custName.toString() ?? ""),
                  groupID == '9'
                      ? showCustInvoiceCustomerResidential(context,
                          getCustomerInvoiceResidential(context), _prov.custId)
                      : showCustInvoiceCustomer(context,
                          getCustomerInvoice(context), _prov.custId, groupID),
                  UsageDetailCust(title: titleCust, idCust: custID),
                  showCustProfileCustomer(
                      context, getCustomerProfile(context), custID)
                ],
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              color: painting.Color(0xff427CEF),
            ),
            height: 55,
            child: TabBar(
              controller: _controller,
              tabs: <Widget>[
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.dashboard),
                      SizedBox(height: 5),
                      Text(
                        'Dashboard',
                        style: painting.TextStyle(fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.description),
                      SizedBox(height: 5),
                      Text('Invoice', style: painting.TextStyle(fontSize: 11))
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.donut_large),
                      SizedBox(height: 5),
                      Flexible(
                          child: Text(
                        'Usage',
                        style: painting.TextStyle(fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ))
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Icon(Icons.person_outline),
                      SizedBox(height: 5),
                      Text('Profile', style: painting.TextStyle(fontSize: 11))
                    ],
                  ),
                ),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: painting.Color(0xff427CEF),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildDahsboardManager(BuildContext context, String title) {
    return Container(
        // color: Colors.white,
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 3.0),
            //  child: Text(Translations.of(context).text('f_home_tv_chart_greeting') ?? " ",
            child: Text(
              greetings ?? " ",
              style: painting.TextStyle(
                  color: Colors.grey[500],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 3.0),
            child: Text(
              titleMng ?? " ",
              style: painting.TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 15.0),
            //  height: 300.0,
            child: Card(
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
                          margin: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
                          child: Text(
                            "Revenue Chart",
                            style: painting.TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 10.0, 5.0),
                        child: Text(
                          'RP. 48.609,442,975',
                          style: painting.TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[400]),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: SizedBox(
                        width: 20,
                      )),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                        child: Text(
                          Translations.of(context)
                              .text('f_home_tv_chart_last_revenue'),
                          style: painting.TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 140.0,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 15.0),
                        child: Text('O'),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 15.0),
                            child: Text('Omset IDR')),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 15.0),
                        child: Text(
                          Translations.of(context)
                              .text('f_customer_gas_usage_detail_bt_detail'),
                          style: painting.TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700]),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 15.0),
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.blue[700],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 15.0),
            //  height: 300.0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(top: 10),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: SizedBox(
                        height: 365.0,
                        child: _buildContentIdr(context, getChartIdr(context)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 15.0),
            //  height: 300.0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(top: 10),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  //CHART
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: SizedBox(
                        height: 380.0,
                        child: _buildContentUsd(context, getChartUsd(context)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              margin: EdgeInsets.only(left: 3, right: 3),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/notifBottom.png')),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Get to Know Us',
                      style: painting.TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 106),
                    alignment: Alignment.center,
                    child: Text(
                      'Perusahaan Gas Negara',
                      style:
                          painting.TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              )),
        ],
      ),
    ));
  }

  Widget _buildDashboardSales(BuildContext context, String title) {
    return Container(
      // color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 3.0),
              child: Text(
                greetings ?? "",
                style: painting.TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              color: painting.Color(0xFF427CEF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.only(left: 16.0, right: 18.0),
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 12, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: CircleAvatar(
                            backgroundColor: painting.Color(0xFFFFFFFF)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            titleCust ?? "-",
                            overflow: TextOverflow.ellipsis,
                            style: painting.TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            customerID ?? "-",
                            style: painting.TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: InkWell(
                        onTap: () {
                          // switchCustomerIdAlert(context);
                          _showCustIdModalBottomSheet(context);
                        },
                        child: Image(
                          image: AssetImage('assets/switchDash.png'),
                          color: Colors.white,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(top: 10),
                elevation: 8,
                child: Container(
                  height: 285,
                  child: Swiper.children(
                    autoplay: false,
                    pagination: new SwiperPagination(
                        builder: new DotSwiperPaginationBuilder()),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8, top: 8, bottom: 8),
                        child: SizedBox(
                          height: 265.0,
                          width: 400,
                          child: _buildContentContract(
                              context, getSumChart(context)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8, top: 8, bottom: 8),
                        child: SizedBox(
                          height: 265.0,
                          width: 400,
                          child: _buildContentContractMax(
                              context, getSumChart(context)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(top: 10),
                elevation: 8,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 370.0,
                          child: _buildContentHarian(
                              context, getDailyChart(context)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(top: 10),
                elevation: 8,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                        child: SizedBox(
                          height: 330.0,
                          child: _buildContentBulanan(
                              context, getMonthlyChart(context)),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 15.0),
                          decoration: new BoxDecoration(
                            color: Colors.blue[800],
                            shape: BoxShape.circle,
                          ),
                          child: Text('    '),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 15.0),
                            child: Text(
                              'Energi',
                              style: painting.TextStyle(
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardResidential(BuildContext context, String title) {
    return Container(
      // color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 15.0),
              child: Text(
                greetings ?? "",
                style: painting.TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              color: painting.Color(0xFF427CEF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.only(left: 16.0, right: 18.0),
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 12, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: CircleAvatar(
                            backgroundColor: painting.Color(0xFFFFFFFF)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            titleCust ?? "-",
                            overflow: TextOverflow.ellipsis,
                            style: painting.TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            customerID ?? "-",
                            style: painting.TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: InkWell(
                        onTap: () {
                          // switchCustomerIdAlert(context);
                          _showCustIdModalBottomSheet(context);
                        },
                        child: Image(
                          image: AssetImage('assets/switchDash.png'),
                          color: Colors.white,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: painting.Color(0xFFFAC842),
              elevation: 5,
              margin: EdgeInsets.only(left: 16, right: 18.0, top: 12),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/ticket.png'),
                      height: 28,
                      color: painting.Color(0xFF7C6400),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                        child: Text(
                      'Poin Collected',
                      style: painting.TextStyle(
                        color: painting.Color(0xFF455055),
                      ),
                    )),
                    Text(
                      pointGasPoint,
                      // overflow: TextOverflow.ellipsis,
                      style: painting.TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: painting.Color(0xFF455055),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(top: 10),
                elevation: 8,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 5, right: 10),
                        child: SizedBox(
                          height: 340.0,
                          child: _buildContentInvoiceResi(
                              context, geInvoiceChartResidential(context)),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
                          decoration: new BoxDecoration(
                            color: Colors.blue[800],
                            shape: BoxShape.circle,
                          ),
                          child: Text('    '),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 15.0),
                            child: Text(
                              Translations.of(context)
                                  .text('invoice_in' ?? '-'),
                              style: painting.TextStyle(
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentHarian(
      BuildContext context, Future<ChartDaily> getTrendHarian) {
    return FutureBuilder<ChartDaily>(
      future: getTrendHarian,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[CircularProgressIndicator()],
          );
        if (snapshot.data.message != null)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset('assets/penggunaan_gas.png'),
              ),
              SizedBox(height: 20),
              for (var i = 7; i <= 7; i++)
                Container(
                  child: Text(
                    snapshot.data.message,
                    style: painting.TextStyle(fontSize: 18),
                  ),
                )
            ],
          );
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                    child: Text(
                      Translations.of(context)
                          .text('f_home_tv_chart_daily_chart'),
                      style: painting.TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                  child: Text(
                    '',
                    style: painting.TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[400]),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 5.0),
                    child: Text(
                      '${snapshot.data.meta.startDate.displayStart ?? noValue}  - ${snapshot.data.meta.endDate.displayEnd ?? noValue}',
                      style: painting.TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 5.0),
                  child: Text(
                    Translations.of(context)
                        .text('f_home_tv_chart_last_usage_volume'),
                    style: painting.TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return i < 1
                    ? _buildRowHarian(snapshot.data.data)
                    : SizedBox(
                        height: 10.0,
                      );
              },
            ),
            Visibility(
              visible: harianCustVisible,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                    decoration: new BoxDecoration(
                      color: Colors.blue[800],
                      shape: BoxShape.circle,
                    ),
                    child: Text('    '),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 7.0, 0.0, 0.0),
                        child: Text(
                          Translations.of(context)
                              .text('f_gu_legend_volume_daily'),
                          style: painting.TextStyle(
                            fontSize: 11.0,
                          ),
                        )),
                  ),
                  InkWell(
                    child: Container(
                      height: 30,
                      width: 80,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue),
                      child: Text(
                        Translations.of(context)
                            .text('f_customer_gas_usage_detail_bt_detail'),
                        style: painting.TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HarianDetailCust(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContentInvoiceResi(
      BuildContext context, Future<ChartInvoiceResidential> getInvoiceResi) {
    return FutureBuilder<ChartInvoiceResidential>(
      future: getInvoiceResi,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[CircularProgressIndicator()],
          );
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
                  style: painting.TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        var startDate = DateTime.parse(snapshot.data.data[2].dateVal);
        var endDate = DateTime.parse(snapshot.data.data[0].dateVal);
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                    child: Text(
                      Translations.of(context)
                          .text('title_bar_invoice_residence_detail'),
                      style: painting.TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                  child: Text(
                    'Rp.${snapshot.data.data[0].value ?? noValue}',
                    style: painting.TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue[400]),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.fromLTRB(0.0, 3.0, 10.0, 5.0),
              child: Text(
                '${formatDate((startDate), [MM]) ?? noValue} ${formatDate((startDate), [
                      yyyy
                    ]) ?? noValue}  - ${formatDate((endDate), [MM]) ?? noValue} ${formatDate((endDate), [yyyy]) ?? noValue}',
                style: painting.TextStyle(
                    fontSize: 10.0, fontWeight: FontWeight.w400),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return i < 1
                    ? _buildRowInvoiceResi(snapshot.data.data
                      ..sort((a, b) => a.dateVal.compareTo(b.dateVal)))
                    : SizedBox(
                        height: 10.0,
                      );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildContentBulanan(
      BuildContext context, Future<ChartMonthly> getMonthly) {
    return FutureBuilder<ChartMonthly>(
      future: getMonthly,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[CircularProgressIndicator()],
          );
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
                  style: painting.TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                    child: Text(
                      Translations.of(context)
                          .text('f_home_tv_chart_monthly_chart'),
                      style: painting.TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                  child: Text(
                    snapshot.data.meta.totalUsage.displayTUsage,
                    style: painting.TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[400]),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 5.0),
                      child: SizedBox(width: 10)),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 5.0),
                  child: Text(
                    Translations.of(context)
                        .text('f_home_tv_chart_total_usage_volume'),
                    style: painting.TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return i < 1
                    ? _buildRowMonthly(snapshot.data.data)
                    : SizedBox(
                        height: 10.0,
                      );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildContentOmsetIdr(
      BuildContext context, Future<UsageSumChart> getSumChart) {
    return FutureBuilder<UsageSumChart>(
      future: getSumChart,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          );
        if (snapshot.data.message == null)
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, i) {
              return i < 1
                  ? _buildRowContract(snapshot.data.data, snapshot.data.meta)
                  : SizedBox(
                      height: 10.0,
                    );
            },
          );
        else
          return Column(
            children: <Widget>[Text("Gagal menghubungi server")],
          );
      },
    );
  }

  Widget _buildContentContract(
      BuildContext context, Future<UsageSumChart> getSumChart) {
    return FutureBuilder<UsageSumChart>(
      future: getSumChart,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          );
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
                  style: painting.TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return i < 1
                    ? _buildRowContract(snapshot.data.data, snapshot.data.meta)
                    : SizedBox(
                        height: 10.0,
                      );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildContentContractMax(
      BuildContext context, Future<UsageSumChart> getSumChart) {
    return FutureBuilder<UsageSumChart>(
      future: getSumChart,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          );
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
                  style: painting.TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return i < 1
                    ? _buildRowContractMax(
                        snapshot.data.data, snapshot.data.meta)
                    : SizedBox(
                        height: 10.0,
                      );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildContentIdr(BuildContext context, Future<ChartIdr> getChartIdr) {
    return FutureBuilder<ChartIdr>(
      future: getChartIdr,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[
              LinearProgressIndicator(),
            ],
          );
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
                  style: painting.TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, i) {
            return i < 1
                ? _buildRowIdr(snapshot.data.data, snapshot.data.data[2])
                : SizedBox(
                    height: 10.0,
                  );
          },
        );
      },
    );
  }

  Widget _buildContentUsd(BuildContext context, Future<ChartUsd> getChartUsd) {
    return FutureBuilder<ChartUsd>(
      future: getChartUsd,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Column(
            children: <Widget>[LinearProgressIndicator()],
          );
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
                  style: painting.TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, i) {
            return i < 1
                ? _buildRowUsd(snapshot.data.data, snapshot.data.data[2])
                : SizedBox(
                    height: 10.0,
                  );
          },
        );
      },
    );
  }

  Widget _buildRowIdr(List<DataChartIdr> data, DataChartIdr datas) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                child: Text(
                  Translations.of(context)
                      .text('f_home_tv_chart_revenue_chart'),
                  style: painting.TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 5.0),
              child: Text(
                'Rp. ${datas.value}',
                style: painting.TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[400]),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: SizedBox(
              width: 20,
            )),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
              child: Text(
                Translations.of(context).text('f_home_tv_chart_last_revenue'),
                style: painting.TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 280,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: SimpleBarChart(_createSampleDataIdr(data), 'RP.', 'Omset'),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
              decoration: new BoxDecoration(
                color: Colors.blue[800],
                shape: BoxShape.circle,
              ),
              child: Text('    '),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 15.0),
                  child: Text(
                    'Omset IDR',
                    style: painting.TextStyle(
                      fontSize: 11.0,
                    ),
                  )),
            ),
            InkWell(
              child:
                  // Row(
                  //   children: <Widget>[
                  Container(
                height: 30,
                width: 80,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blue),
                child: Text(
                  Translations.of(context)
                      .text('f_customer_gas_usage_detail_bt_detail'),
                  style: painting.TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DashboardDetail(title: 'IDR', cur: "")));
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _buildRowUsd(List<DataChartUsd> data, DataChartUsd datas) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
                child: Text(
                  Translations.of(context)
                      .text('f_home_tv_chart_revenue_chart'),
                  style: painting.TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 15.0, 10.0, 5.0),
              child: Text(
                'USD ${datas.value}',
                style: painting.TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[400]),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: SizedBox(
              width: 20,
            )),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
              child: Text(
                Translations.of(context).text('f_home_tv_chart_last_revenue'),
                style: painting.TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 280,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, right: 15, left: 15, bottom: 0),
            child: SimpleBarChart(_createSampleDataUsd(data), 'USD', 'Omset'),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
              decoration: new BoxDecoration(
                color: Colors.blue[800],
                shape: BoxShape.circle,
              ),
              child: Text('    '),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 15.0),
                  child: Text(
                    'Omset USD',
                    style: painting.TextStyle(
                      fontSize: 11.0,
                    ),
                  )),
            ),
            InkWell(
              // child: Row(
              //   children: <Widget>[
              child: Container(
                height: 30,
                width: 80,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blue),
                child: Text(
                  Translations.of(context)
                      .text('f_customer_gas_usage_detail_bt_detail'),
                  style: painting.TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),

              //   ],
              // ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardDetail(
                      title: 'USD',
                      cur: "&currency=20",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRowHarian(List<UsageDailyChart> data) {
    return Container(
      height: 285,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SimpleLineChart(_createSampleDataHarian(data)),
      ),
    );
  }

  Widget _buildRowInvoiceResi(List<DataChartInvoiceResi> data) {
    return Container(
      height: 280,
      child: Padding(
        padding: EdgeInsets.only(top: 25.0, right: 15, left: 15),
        child:
            SimpleBarChart(_createSampleDataInvoiceResi(data), 'RP.', 'Omset'),
      ),
    );
  }

  Widget _buildRowContract(DataUsageSum data, MetaDataSum meta) {
    double a = double.parse(data.percentage);
    double b = a * 0.01;
    painting.Color status;
    if (data.statusSum.valueStart == '1') {
      status = Colors.orange[400];
    } else if (data.statusSum.valueStart == '3') {
      status = Colors.red;
    } else {
      status = Colors.green;
    }
    if (b < 0) {
      b = 0.0;
    } else if (b > 1) {
      b = 1;
    } else {
      b = b;
    }
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                child: Text(
                  data.statusSum.displayStart ?? '-',
                  style: painting.TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
              child: Text(
                data.usageSum.displayStart,
                style: painting.TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[400]),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 5.0),
                child: Text(
                  '${meta.startDate.displayStart} - ${meta.endDate.displayEnd}',
                  style: painting.TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
              child: Text(
                Translations.of(context)
                    .text('f_home_tv_chart_last_usage_volume'),
                style: painting.TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 170,
              width: 155,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: CircularPercentIndicator(
                  radius: 130.0,
                  lineWidth: 20.0,
                  animation: true,
                  percent: b,
                  center: Text(
                    '${data.percentage}%',
                    style: painting.TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.square,
                  progressColor: status,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        Translations.of(context).text(
                            'f_customer_gas_usage_detail_tv_estimation_label'),
                        style: painting.TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.right),
                    Text(
                      data.estimationUsage.displayStart,
                      style: painting.TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_min_contract_label'),
                      style: painting.TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      data.totalMinUsage.displayStart,
                      style: painting.TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_max_contract_label'),
                      style: painting.TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      data.totalMaxUsage.displayStart,
                      style: painting.TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            Translations.of(context).text('f_home_tv_chart_to_min_contract'),
            style: painting.TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget _buildRowContractMax(DataUsageSum data, MetaDataSum meta) {
    double contractMax =
        data.estimationUsage.valueStart / data.totalMaxUsage.valueStart;
    // double a = contractMax;
    double b = contractMax * 0.01;
    painting.Color statusMax;
    if (data.estimationUsage.valueStart < data.totalMaxUsage.valueStart &&
        data.estimationUsage.valueStart > data.totalMinUsage.valueStart) {
      statusMax = Colors.green;
    } else if (data.estimationUsage.valueStart <
            data.totalMaxUsage.valueStart &&
        data.estimationUsage.valueStart < data.totalMinUsage.valueStart) {
      statusMax = Colors.orange[400];
    } else {
      statusMax = Colors.red;
    }
    print('INI B MAXNYA : $contractMax');
    print('INI c MAXNYA : ${data.estimationUsage.valueStart}');
    print('INI d MAXNYA : ${data.totalMaxUsage.valueStart}');
    painting.Color status;
    // if (data.statusSum.valueStart == '1') {
    //   status = Colors.orange[400];
    // } else if (data.statusSum.valueStart == '3') {
    //   status = Colors.red;
    // } else {
    //   status = Colors.green;
    // }
    if (b < 0) {
      b = 0.0;
    } else if (b > 1) {
      b = 1;
    } else {
      b = b;
    }
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                child: Text(
                  data.statusSum.displayStart ?? '-',
                  style: painting.TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
              child: Text(
                data.usageSum.displayStart,
                style: painting.TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[400]),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 5.0),
                child: Text(
                  '${meta.startDate.displayStart} - ${meta.endDate.displayEnd}',
                  style: painting.TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
              child: Text(
                Translations.of(context)
                    .text('f_home_tv_chart_last_usage_volume'),
                style: painting.TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 170,
              width: 155,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: CircularPercentIndicator(
                  radius: 130.0,
                  lineWidth: 20.0,
                  animation: true,
                  percent: b * 100,
                  center: new Text(
                    '${(contractMax * 100).toStringAsFixed(2)}%',
                    style: painting.TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.square,
                  progressColor: statusMax,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        Translations.of(context).text(
                            'f_customer_gas_usage_detail_tv_estimation_label'),
                        style: painting.TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.right),
                    Text(
                      data.estimationUsage.displayStart,
                      style: painting.TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_min_contract_label'),
                      style: painting.TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      data.totalMinUsage.displayStart,
                      style: painting.TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      Translations.of(context).text(
                          'f_commercial_invoice_detail_tv_max_contract_label'),
                      style: painting.TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      data.totalMaxUsage.displayStart,
                      style: painting.TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            Translations.of(context).text('f_home_tv_chart_to_max_contract'),
            style: painting.TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget _buildRowMonthly(List<UsageMonthlyChart> data) {
    return Container(
      height: 280,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: SimpleBarChart(_createSampleDataMonthly(data), '', 'Energy'),
      ),
    );
  }

  void _showCustIdModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext bc) {
        return Container(
          child: FutureBuilder<DashboardCustomerModel>(
            future: getListCustId(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: LinearProgressIndicator(),
                );
              }
              return Wrap(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 15),
                    child: Text(
                      'Select Profile',
                      style: painting.TextStyle(
                          color: painting.Color(0xFF427CEF),
                          fontSize: 18,
                          fontWeight: painting.FontWeight.bold),
                    ),
                  ),
                  snapshot.data.dashboardCustIdList.listCustomerId.length !=
                          null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot
                              .data.dashboardCustIdList.listCustomerId.length,
                          itemBuilder: (context, i) {
                            snapshot.data.dashboardCustIdList.listCustomerId
                                .sort((b, a) => a.active.compareTo(b.active));
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: 20, top: 5, bottom: 10),
                              child: Row(
                                children: [
                                  snapshot.data.dashboardCustIdList
                                              .listCustomerId[i].active ==
                                          1
                                      ? Container(
                                          height: 40,
                                          width: 8,
                                          color: painting.Color(0xFF427CEF),
                                        )
                                      : SizedBox(width: 10),
                                  snapshot.data.dashboardCustIdList
                                              .listCustomerId[i].imgPath ==
                                          ""
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/icon_default_pelanggan.png'),
                                            backgroundColor: Colors.transparent,
                                            radius: 21.0,
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                snapshot
                                                    .data
                                                    .dashboardCustIdList
                                                    .listCustomerId[i]
                                                    .imgPath),
                                            backgroundColor: Colors.transparent,
                                            radius: 21.0,
                                          ),
                                        ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        switchCustomerId(snapshot
                                            .data
                                            .dashboardCustIdList
                                            .listCustomerId[i]
                                            .reqId);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${snapshot.data.dashboardCustIdList.listCustomerId[i].nameCust}',
                                              style: painting.TextStyle(
                                                  fontWeight:
                                                      painting.FontWeight.w600),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                snapshot
                                                            .data
                                                            .dashboardCustIdList
                                                            .listCustomerId[i]
                                                            .statusCust ==
                                                        'Unverified'
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: Text(
                                                          '${snapshot.data.dashboardCustIdList.listCustomerId[i].statusCust}',
                                                          style: painting
                                                              .TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                painting.Color(
                                                                    0xFF81C153),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                Text(
                                                  '${snapshot.data.dashboardCustIdList.listCustomerId[i].custId}',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  snapshot.data.dashboardCustIdList
                                              .listCustomerId[i].active ==
                                          0
                                      ? IconButton(
                                          icon: FaIcon(Icons.delete),
                                          onPressed: () {
                                            deleteCustIdAlert(
                                                snapshot
                                                    .data
                                                    .dashboardCustIdList
                                                    .listCustomerId[i]
                                                    .reqId,
                                                snapshot
                                                    .data
                                                    .dashboardCustIdList
                                                    .listCustomerId[i]
                                                    .custId,
                                                snapshot
                                                    .data
                                                    .dashboardCustIdList
                                                    .listCustomerId[i]
                                                    .nameCust);
                                          })
                                      : SizedBox(),
                                ],
                              ),
                            );
                          },
                        )
                      : Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Row(
                            children: [
                              Column(
                                children: [Text('-')],
                              ),
                            ],
                          ),
                        ),
                  snapshot.data.dashboardCustIdList.listCustomerId.length < 3
                      ? Padding(
                          padding:
                              EdgeInsets.only(left: 25, right: 20, bottom: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DashboardCustAdd()));
                            },
                            child: Row(
                              children: [
                                FaIcon(
                                  Icons.add_circle_outline,
                                  size: 45,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('Add New Profile'),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(height: 5),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void switchCustomerId(String reqIDCust) async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseSwitchCustId = await http.post(
      '${UrlCons.mainProdUrl}switch_customer_id/$reqIDCust',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
    );
    SwitchCustomerId switchCustomerId =
        SwitchCustomerId.fromJson(json.decode(responseSwitchCustId.body));
    if (responseSwitchCustId.statusCode == 200) {
      await storageCache.write(
          key: 'customer_id',
          value: switchCustomerId.dataSwitchCustomerId.custID);
      await storageCache.write(
          key: 'user_name_cust',
          value: switchCustomerId.dataSwitchCustomerId.custName);
      showToast(switchCustomerId.dataSwitchCustomerId.message);
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else {
      showToast(switchCustomerId.message);
    }
  }

  void getVirtualCardGasPoint(BuildContext context) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');

    var responseGetVCGasPoint =
        await http.get('${UrlCons.mainDevUrl}virtual_card', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    print('HASILNYA : ${responseGetVCGasPoint.body}');
    if (responseGetVCGasPoint.statusCode == 200) {
      modelGP.VirtualCardGasPoint virtualCardGasPoint =
          modelGP.VirtualCardGasPoint.fromJson(
              json.decode(responseGetVCGasPoint.body));
      setState(() {
        pointGasPoint = virtualCardGasPoint.dataVCGasPoint.pointReward;
      });
      print('UPDATE $pointGasPoint');
    } else {
      throw Exception('Could not get any response');
    }
  }

  void deleteCustId(String reqIDCust, String custId, String custName) async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseDeleteCustId = await http.delete(
      '${UrlCons.mainProdUrl}delete_customer_id/$reqIDCust',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
    );
    DeleteCustomerId switchCustomerId =
        DeleteCustomerId.fromJson(json.decode(responseDeleteCustId.body));
    if (responseDeleteCustId.statusCode == 200) {
      showToast(switchCustomerId.dataDeleteCustomerId.message);
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else {
      showToast(switchCustomerId.message);
    }
  }

  Future<bool> deleteCustIdAlert(
      String reqIDCust, String custId, String custName) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: painting.TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: painting.TextStyle(
        color: Colors.black,
      ),
    );
    return Alert(
      context: context,
      style: alertStyle,
      title: "Information !",
      content: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            "${Translations.of(context).text('f_dialog_confirmation_delete_custid')} $custId ($custName)",
            style: painting.TextStyle(
                // color: painting.Color.fromRGBO(255, 255, 255, 0),
                fontSize: 17,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10)
        ],
      ),
      buttons: [
        DialogButton(
          width: 130,
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Colors.green,
          child: Text(
            "Cancel",
            style: painting.TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          width: 130,
          onPressed: () async {
            deleteCustId(reqIDCust, custId, custName);
          },
          color: Colors.red,
          child: Text(
            "Delete",
            style: painting.TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }

  Future<bool> switchCustomerIdAlert(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: painting.TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: painting.TextStyle(
        color: Colors.black,
      ),
    );
    return Alert(
      context: context,
      style: alertStyle,
      title: "Select Profile !",
      content: FutureBuilder<DashboardCustomerModel>(
        future: getListCustId(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: LinearProgressIndicator(),
            );
          }
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text('Select Customer Id'),
              ),
              snapshot.data.dashboardCustIdList.listCustomerId.length != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot
                          .data.dashboardCustIdList.listCustomerId.length,
                      itemBuilder: (context, i) {
                        snapshot.data.dashboardCustIdList.listCustomerId
                            .sort((b, a) => a.active.compareTo(b.active));
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    switchCustomerId(snapshot
                                        .data
                                        .dashboardCustIdList
                                        .listCustomerId[i]
                                        .reqId);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${snapshot.data.dashboardCustIdList.listCustomerId[i].custId}'),
                                      Text(
                                          '${snapshot.data.dashboardCustIdList.listCustomerId[i].nameCust}')
                                    ],
                                  ),
                                ),
                              ),
                              snapshot.data.dashboardCustIdList
                                          .listCustomerId[i].active ==
                                      0
                                  ? IconButton(
                                      icon: FaIcon(Icons.delete),
                                      onPressed: () {
                                        deleteCustIdAlert(
                                            snapshot.data.dashboardCustIdList
                                                .listCustomerId[i].reqId,
                                            snapshot.data.dashboardCustIdList
                                                .listCustomerId[i].custId,
                                            snapshot.data.dashboardCustIdList
                                                .listCustomerId[i].nameCust);
                                      })
                                  : SizedBox(),
                              snapshot.data.dashboardCustIdList
                                          .listCustomerId[i].active ==
                                      1
                                  ? FaIcon(Icons.check_circle_outline_outlined,
                                      color: Colors.green)
                                  : SizedBox(),
                            ],
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        children: [
                          Column(
                            children: [Text('-')],
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardCustAdd()));
                  },
                  child: Row(
                    children: [
                      FaIcon(Icons.add),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('Add new Customer Id'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ).show();
  }

  Future<ChartIdr> getChartIdr(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetDataChartIdr = await http
        .get('${UrlCons.mainProdUrl}summary/omset-monthly?idr=20', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });
    print('HASIL GET CHART IDR : ${responseGetDataChartIdr.body}');
    ChartIdr _chartIDR =
        ChartIdr.fromJson(json.decode(responseGetDataChartIdr.body));
    if (_chartIDR.message ==
        "Session expired or account changed to other device, please Login again.") {
      accessTokenAlert(context,
          "Session expired or account changed to other device, please Login again.");
    } else {
      return ChartIdr.fromJson(json.decode(responseGetDataChartIdr.body));
    }
  }

  Future<ChartUsd> getChartUsd(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('access_token');
    // String lang = prefs.getString('lang');
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetDataChartIdr = await http
        .get('${UrlCons.mainProdUrl}summary/omset-monthly?currency', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });
    print('HASIL GET CHART USD : ${responseGetDataChartIdr.body}');
    ChartUsd _chartIDR =
        ChartUsd.fromJson(json.decode(responseGetDataChartIdr.body));
    if (_chartIDR.message ==
        "Session expired or account changed to other device, please Login again.") {
      accessTokenAlert(context,
          "Session expired or account changed to other device, please Login again.");
    } else {
      return ChartUsd.fromJson(json.decode(responseGetDataChartIdr.body));
    }
  }

  Future<ChartDaily> getDailyChart(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('access_token');
    // String lang = prefs.getString('lang');
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetDataChartDaily =
        await http.get(UrlCons.getGasUsageDailyChartCust, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });
    ChartDaily _chartIDR =
        ChartDaily.fromJson(json.decode(responseGetDataChartDaily.body));
    if (_chartIDR.message ==
        "Session expired or account changed to other device, please Login again.") {
      accessTokenAlert(context,
          "Session expired or account changed to other device, please Login again.");
    } else {
      return ChartDaily.fromJson(json.decode(responseGetDataChartDaily.body));
    }
  }

  Future<ChartInvoiceResidential> geInvoiceChartResidential(
      BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('access_token');
    // String lang = prefs.getString('lang');
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetChartResidential = await http
        .get("${UrlCons.getInvoiceResidentialChart}$customerID", headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });

    ChartInvoiceResidential _chartIDR = ChartInvoiceResidential.fromJson(
        json.decode(responseGetChartResidential.body));
    if (_chartIDR.message ==
        "Session expired or account changed to other device, please Login again.") {
      accessTokenAlert(context,
          "Session expired or account changed to other device, please Login again.");
    } else {
      return ChartInvoiceResidential.fromJson(
          json.decode(responseGetChartResidential.body));
    }
  }

  Future<ChartMonthly> getMonthlyChart(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('access_token');
    // String lang = prefs.getString('lang');
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetDataChartMonthly =
        await http.get(UrlCons.getGasUsageMonthlyChartCust, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });
    ChartMonthly _chartIDR =
        ChartMonthly.fromJson(json.decode(responseGetDataChartMonthly.body));
    if (_chartIDR.message ==
        "Session expired or account changed to other device, please Login again.") {
      accessTokenAlert(context,
          "Session expired or account changed to other device, please Login again.");
    } else {
      return ChartMonthly.fromJson(
          json.decode(responseGetDataChartMonthly.body));
    }
  }

  Future<UsageSumChart> getSumChart(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('access_token');
    // String lang = prefs.getString('lang');
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetDataChartSum =
        await http.get(UrlCons.getGasUsageSumCust, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });
    UsageSumChart _chartIDR =
        UsageSumChart.fromJson(json.decode(responseGetDataChartSum.body));
    if (_chartIDR.message ==
        "Session expired or account changed to other device, please Login again.") {
      accessTokenAlert(context,
          "Session expired or account changed to other device, please Login again.");
    } else {
      return UsageSumChart.fromJson(json.decode(responseGetDataChartSum.body));
    }
  }
}

Future<DashboardCustomerModel> getListCustId(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseGetListCustomerId =
      await http.get('${UrlCons.mainDevUrl}list_customer_id', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });
  print('DATA GET LIST CUST ID : ${responseGetListCustomerId.body}');
  return DashboardCustomerModel.fromJson(
      json.decode(responseGetListCustomerId.body));
}

class SimpleBarChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final String cur;
  final String title;
  final bool animate;
  static String pointerValue;
  SimpleBarChart(this.seriesList, this.cur, this.title, {this.animate = true});
  @override
  SimpleBarCharts createState() => SimpleBarCharts(seriesList, cur, title);
}

class SimpleBarCharts extends State<SimpleBarChart> {
  final List<charts.Series> seriesList;
  final String cur;
  final String title;
  final bool animate;
  static String pointerValue;
  String valueText = "0.0";

  String titleText;
  final formatCurrency =
      new NumberFormat.currency(locale: "en_US", symbol: " ", decimalDigits: 0);
  SimpleBarCharts(this.seriesList, this.cur, this.title, {this.animate = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        titleText != null
            ? Text(
                '$title ($titleText) : $cur${formatCurrency.format(double.parse(valueText)) ?? ''}',
                style: painting.TextStyle(
                    color: painting.Color(0xFFFF972F),
                    fontWeight: FontWeight.bold),
              )
            : Container(),
        SizedBox(height: 5),
        Container(
          height: 220,
          child: charts.BarChart(
            seriesList,
            animate: animate,
            selectionModels: [
              charts.SelectionModelConfig(
                  type: charts.SelectionModelType.info,
                  changedListener: (charts.SelectionModel model) {
                    setState(() {
                      valueText =
                          '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}';
                      // pointerValue = '${model.selectedSeries.measureFn(model.selectedDatum[0].index)}';
                      titleText =
                          '${model.selectedSeries[0].domainFn(model.selectedDatum[0].index)}';
                    });
                  })
              //   print('SELECTED DATUm ${model.selectedDatum[0].index}');
              //   if (model.hasDatumSelection)
              //     pointerValue = formatCurrency
              //         .format(model.selectedSeries[0]
              //             .measureFn(model.selectedDatum[0].index))
              //         .toString();
              // }),
            ],
            // behaviors: [
            //   LinePointHighlighter(
            //       symbolRenderer: CustomCircleSymbolRenderer(text: valueText))
            // ],
            domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
              labelStyle:
                  charts.TextStyleSpec(color: charts.MaterialPalette.black),
              lineStyle:
                  new charts.LineStyleSpec(color: charts.MaterialPalette.black),
            )),

            primaryMeasureAxis: charts.NumericAxisSpec(
              tickProviderSpec:
                  new charts.BasicNumericTickProviderSpec(desiredTickCount: 7),
              renderSpec: charts.GridlineRendererSpec(
                labelStyle:
                    charts.TextStyleSpec(color: charts.MaterialPalette.black),
                lineStyle:
                    charts.LineStyleSpec(color: charts.MaterialPalette.black),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  String text;
  CustomCircleSymbolRenderer({this.text});
  @override
  CustomCircleSymbolRenderer.paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Point point,
      Color fillColor,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 35, bounds.top - 28, bounds.width + 103,
            bounds.height + 12),
        fill: Color.transparent);
    var textStyle = style.TextStyle();
    // textStyle.color = Color(0xFF0000);
    textStyle.fontSize = 15;
    element.TextElement test =
        element.TextElement(SimpleBarCharts.pointerValue, style: textStyle);
    canvas.drawText(
        test, (bounds.left - 35).round(), (bounds.top - 30).round());
  }
}

class SimpleLineChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate = true});

  @override
  _SimpleLineChartState createState() => _SimpleLineChartState(seriesList);
}

class _SimpleLineChartState extends State<SimpleLineChart> {
  final List<charts.Series> seriesList;
  final bool animate;
  static String pointerValue;
  String valueText = "0.0";
  String titleText;
  Widget _timeSeriesChart;

  final formatCurrency =
      new NumberFormat.currency(locale: "en_US", symbol: " ", decimalDigits: 0);
  _SimpleLineChartState(this.seriesList, {this.animate = true});
  @override
  void initState() {
    super.initState();
    setState(
      () {
        _timeSeriesChart = charts.LineChart(
          widget.seriesList,
          defaultRenderer: new charts.LineRendererConfig(
              includeArea: true, stacked: true, includePoints: true),
          animate: widget.animate,
          behaviors: [new charts.PanAndZoomBehavior()],
          selectionModels: [
            charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: (charts.SelectionModel model) {
                  setState(() {
                    valueText =
                        '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}';
                    // pointerValue = '${model.selectedSeries.measureFn(model.selectedDatum[0].index)}';
                    titleText =
                        '${model.selectedSeries[0].domainFn(model.selectedDatum[0].index)}';
                  });
                })
          ],
          domainAxis: new charts.NumericAxisSpec(
            tickProviderSpec:
                charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
          ),
          primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec: new charts.BasicNumericTickProviderSpec(
              desiredTickCount: 5,
            ),
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        titleText != null
            ? Text(
                'Energy (${DateFormat("MMM").format(DateTime.now())} $titleText) : ${formatCurrency.format(double.parse(valueText)) ?? ''}',
                style: painting.TextStyle(
                    color: painting.Color(0xFFFF972F),
                    fontWeight: FontWeight.bold),
              )
            : Container(),
        SizedBox(height: 5),
        Container(
          height: 240,
          child: _timeSeriesChart,
        )
      ],
    );
  }
}

class CustDailyModel {
  final int month;
  final int value;

  CustDailyModel(this.value, this.month);
}

class SummaryModel {
  final String month;
  final double value;

  SummaryModel(this.month, this.value);
}

Future<CustomerInvoice> getCustomerInvoice(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseCustomerInvoice =
      await http.get(UrlCons.getCustInvoiceCust, headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang
  });
  CustomerInvoice _customerInvoice =
      CustomerInvoice.fromJson(json.decode(responseCustomerInvoice.body));
  if (_customerInvoice.message ==
      "Session expired or account changed to other device, please Login again.") {
    accessTokenAlert(context,
        "Session expired or account changed to other device, please Login again.");
  } else {
    return CustomerInvoice.fromJson(json.decode(responseCustomerInvoice.body));
  }
  return _customerInvoice;
}

Future<CustomerInvoiceResidential> getCustomerInvoiceResidential(
    BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseCustomerInvoice =
      await http.get(UrlCons.getCustInvoiceCust, headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang
  });
  CustomerInvoiceResidential _customerInvoice =
      CustomerInvoiceResidential.fromJson(
          json.decode(responseCustomerInvoice.body));
  print('Data Invoice: ${responseCustomerInvoice.body}');
  if (_customerInvoice.message ==
      "Session expired or account changed to other device, please Login again.") {
    accessTokenAlert(context,
        "Session expired or account changed to other device, please Login again.");
  } else {
    return CustomerInvoiceResidential.fromJson(
        json.decode(responseCustomerInvoice.body));
  }
  return _customerInvoice;
}

Widget showCustInvoiceCustomer(BuildContext context,
    Future<CustomerInvoice> _customerInvoice, String cust_id, String userid) {
  return InvoiceCust(data: _customerInvoice, custID: cust_id, userid: userid);
}

Widget showCustInvoiceCustomerResidential(BuildContext context,
    Future<CustomerInvoiceResidential> _customerInvoice, String cust_id) {
  return InvoiceCustResidential(data: _customerInvoice, custID: cust_id);
}

Widget showCustInvoiceGPIRnGPIK(BuildContext context,
    Future<CustomerInvoice> _customerInvoice, String cust_id, String userid) {
  return InvoiceCustGPIRnGPIK(
      data: _customerInvoice, custID: cust_id, userid: userid);
}

Future<Customer> getCustomerProfile(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseCustomer = await http.get(UrlCons.getCustProfileCust, headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang
  });
  Customer _customer = Customer.fromJson(json.decode(responseCustomer.body));
  Customer _customerInvoice =
      Customer.fromJson(json.decode(responseCustomer.body));
  if (_customerInvoice.message ==
      "Session expired or account changed to other device, please Login again.") {
    accessTokenAlert(context,
        "Session expired or account changed to other device, please Login again.");
  } else {
    return Customer.fromJson(json.decode(responseCustomer.body));
  }
  return _customer;
}

Future<CustomerProfileResidentialModel> getCustomerProfileResidential(
    BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseCustomer = await http.get(
    UrlCons.getCustProfileCust,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    },
  );

  CustomerProfileResidentialModel _customer =
      CustomerProfileResidentialModel.fromJson(
          json.decode(responseCustomer.body));
  if (_customer.message ==
      "Session expired or account changed to other device, please Login again.") {
    accessTokenAlert(context,
        "Session expired or account changed to other device, please Login again.");
  } else {
    return CustomerProfileResidentialModel.fromJson(
        json.decode(responseCustomer.body));
  }
  return _customer;
}

Widget showCustProfileCustomer(
    BuildContext context, Future<Customer> _customer, String custID) {
  return FutureBuilder<Customer>(
    future: _customer,
    builder: (context, snapshot) {
      if (!snapshot.hasData)
        return Column(
          children: <Widget>[LinearProgressIndicator()],
        );
      return CustomerDetail(data: snapshot.data, idCust: custID);
    },
  );
}

Widget showCustProfileCustomerResidential(
    BuildContext context, Future<CustomerProfileResidentialModel> _customer) {
  return FutureBuilder<CustomerProfileResidentialModel>(
    future: _customer,
    builder: (context, snapshot) {
      if (!snapshot.hasData)
        return Column(
          children: <Widget>[LinearProgressIndicator()],
        );
      return MyProfileCustResidential(snapshot.data);
    },
  );
}

class CustTabs {
  final String title;
  CustTabs({this.title});
}

class CustReiTabs {
  final String title;
  CustReiTabs({this.title});
}

Future<bool> accessTokenAlert(BuildContext context, String message) {
  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: painting.TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: painting.TextStyle(
      color: Colors.black,
    ),
  );
  return Alert(
    context: context,
    style: alertStyle,
    title: "Information !",
    content: Column(
      children: <Widget>[
        SizedBox(height: 5),
        Text(
          '$message' ?? '',
          style: painting.TextStyle(
              // color: painting.Color.fromRGBO(255, 255, 255, 0),
              fontSize: 17,
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10)
      ],
    ),
    buttons: [
      DialogButton(
        width: 130,
        onPressed: () async {
          _signingOff(context, message);
        },
        color: Colors.green,
        child: Text(
          "OK",
          style: painting.TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )
    ],
  ).show();
}

void _signingOff(BuildContext context, String message) async {
  final storageCache = FlutterSecureStorage();

  if (message == 'Device is registered successfully') {
    await storageCache.write(key: 'auth_status', value: 'Login');
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/dashboard');
  } else {
    await storageCache.write(key: 'user_id', value: 'kosong');
    await storageCache.write(key: 'access_token', value: 'kosong');
    await storageCache.write(key: 'auth_status', value: 'Logout');
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (Route<dynamic> route) => false,
    );
  }
}
