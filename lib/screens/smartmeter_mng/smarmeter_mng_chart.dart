import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/detail_usage_smartmeter.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/smartmeter_mng/smartmeter_mng_list.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:http/http.dart' as http;

class UsageDetailMngRTPK extends StatefulWidget {
  final String title, idCust;
  UsageDetailMngRTPK({this.idCust, this.title});

  @override
  _UsageDetailRTPKState createState() => _UsageDetailRTPKState(title, idCust);
}

class _UsageDetailRTPKState extends State<UsageDetailMngRTPK>
    with TickerProviderStateMixin {
  final String idCust, title;

  _UsageDetailRTPKState(this.title, this.idCust);
  TabController _tabController;

  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, length: 3, initialIndex: 2);
  }

  List<charts.Series<LinearSalesDateTime, DateTime>> _createSampleData17(
      List<UsageDetailChar> data) {
    return [
      charts.Series<LinearSalesDateTime, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSalesDateTime sales, _) => sales.year,
        measureFn: (LinearSalesDateTime sales, _) => sales.sales,
        data: inputDataChartDate(data),
      ),
    ];
  }

  List<LinearSalesDateTime> inputDataChartDate(List<UsageDetailChar> data) {
    final myFakeDesktopData = List<LinearSalesDateTime>();

    data.forEach((itemData) {
      DateTime todayDate = DateTime.parse(itemData.date.value);
      myFakeDesktopData
          .add(LinearSalesDateTime(todayDate, itemData.usage.value));
    });

    return myFakeDesktopData;
  }

  var prevMonth1, prevMonth2, prevMonth3;
  var currentDate = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int month2 = currentMonth - 1;
    int month3 = currentMonth - 2;
    String month3S, month2S, currentMonthS;
    String y = "10";
    String sNull = "0";
    int monthSelected;
    int monthSelected2;
    int monthSelected3;
    int selectedYear;
    int selectedYear2;
    int selectedYear3;
    if (currentMonth == 2) {
      int currentYears = DateTime.now().year - 1;
      // int y1 = 12;
      // int y2 = 01;
      selectedYear = currentYears;
      monthSelected = 2;
      monthSelected2 = 1;
      monthSelected3 = 12;
      currentMonthS = '02';
      String cal2 = '${currentYears + 1}01';
      String cal1 = '${currentYears}12';
      month2S = cal2;
      month3S = cal1;
    } else if (currentMonth == 1) {
      int currentYears = DateTime.now().year - 1;
      selectedYear = currentYears;

      monthSelected = 1;
      monthSelected2 = 12;
      monthSelected3 = 11;
      int y1 = 12;
      int y2 = 11;
      String cal2 = '$currentYears$y1';
      String cal1 = '$currentYears$y2';
      currentMonthS = '01';
      month2S = cal2;
      month3S = cal1;
    } else {
      currentYear = DateTime.now().year;
      selectedYear = currentYear;

      if (currentMonth < 10) {
        currentMonthS = '0$currentMonth';
        //print('MASUK SINI KAH : $currentMonthS');
        monthSelected = currentMonth;
      } else {
        currentMonthS = currentMonth.toString();
        monthSelected = currentMonth;
      }
      if (month2 < 10) {
        month2S = '$currentYear$sNull$month2';
        monthSelected2 = month2;
      } else {
        month2S = '$currentYear$month2';
        monthSelected2 = month2;
      }

      if (month3 < 10) {
        month3S = '$currentYear$sNull$month3';
        monthSelected3 = month3;
      } else {
        month3S = '$currentYear$month3';
        monthSelected3 = month3;
      }
    }

    String dateformatCurrent =
        '${currentYear.toString()}${currentMonthS.toString()}10';
    String dateformatCurrent2 = '${month2S.toString()}10';

    String dateformatCurrent3 = '${month3S.toString()}10';

    String formatDate =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent));
    String formatDate2 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent2));
    String formatDate3 =
        DateFormat("yyyMM").format(DateTime.parse(dateformatCurrent3));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Smartmeter',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              height: 50,
              margin: EdgeInsets.only(left: 10, right: 10),
              width: 380,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Color(0xff427CEF),
                indicatorWeight: 1,
                indicatorPadding: EdgeInsets.only(left: 15, right: 15),
                labelColor: Colors.white,
                unselectedLabelColor: Color(0xff427CEF),
                indicator: ShapeDecoration(
                    color: Color(0xff427CEF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                          color: Color(0xff427CEF),
                        ))),
                tabs: <Widget>[
                  Tab(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent3))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent3))}',
                      style: TextStyle(fontSize: 15),
                    ),
                  )),
                  Tab(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent2))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent2))}',
                      style: TextStyle(fontSize: 15),
                    ),
                  )),
                  Tab(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${DateFormat("MMMM").format(DateTime.parse(dateformatCurrent))} ${DateFormat("yyy").format(DateTime.parse(dateformatCurrent))}',
                      style: TextStyle(fontSize: 15),
                    ),
                  )),
                ],
              ),
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
                  // _buildContextJuni(context, 'juni'),
                  // _buildContextJuni(context, 'juli'),
                  _buildContent3(
                      context, formatDate3, selectedYear, monthSelected3),
                  _buildContent2(
                      context, formatDate2, selectedYear, monthSelected2),
                  _buildContent(
                      context, formatDate, selectedYear, monthSelected)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContextJuni(BuildContext context, String title) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 30, bottom: 10),
          child: Container(
            height: 289,
            child: Padding(
              padding: EdgeInsets.only(left: 14.0, right: 14.0, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset('assets/penggunaan_gas.png'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      Translations.of(context)
                          .text('f_gus_all_summary_error_empty'),
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent3(
      BuildContext context, String title, int selectedYear, int monthSelected) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 30, bottom: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 140,
                      margin: EdgeInsets.only(left: 14.0, top: 18.0),
                      child: Text(
                        'Volume (m3)',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 289,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                  child: _buildCharContent3(
                      context,
                      fetchGetChar3(context, title),
                      title,
                      selectedYear,
                      monthSelected),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent2(
      BuildContext context, String title, int selectedYear, int monthSelected) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 30, bottom: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 140,
                      margin: EdgeInsets.only(left: 14.0, top: 18.0),
                      child: Text(
                        'Volume (m3)',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 289,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                  child: _buildCharContent2(
                      context,
                      fetchGetChar2(context, title),
                      title,
                      selectedYear,
                      monthSelected),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent(
      BuildContext context, String title, int selectedYear, int monthSelected) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 30, bottom: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 140,
                      margin: EdgeInsets.only(left: 14.0, top: 18.0),
                      child: Text(
                        'Volume (m3)',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 289,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 14.0, top: 14.0, right: 14.0, bottom: 5),
                  child: _buildCharContent(
                      context,
                      fetchGetChar(context, title),
                      title,
                      selectedYear,
                      monthSelected),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCharContent(
      BuildContext context,
      Future<ChartUsageDetailSmartmeter> getChartUsageDetail,
      String period,
      int selectedYear,
      int monthSelected) {
    return FutureBuilder<ChartUsageDetailSmartmeter>(
        future: getChartUsageDetail,
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
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          //print('PERIOD DARI API ${snapshot.data.data[0].date.display}');
          return Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, i) {
                  return i < 1
                      ? _buildRow(snapshot.data.data, period, selectedYear,
                          monthSelected)
                      : SizedBox(
                          height: 10.0,
                        );
                },
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: painting.Color(0xFF4578EF),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
                        child: Text(
                          'Weekly Volume',
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        )),
                  ),
                  InkWell(
                    child: Container(
                      height: 30,
                      width: 80,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue),
                      child: Text(
                        Translations.of(context)
                            .text('f_customer_gas_usage_detail_bt_detail'),
                        style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      //print('ini titlenyaaas : $period');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HarianDetailMngRTPKChart(
                                    title: title,
                                    period: period,
                                    custID: idCust,
                                  )));
                    },
                  )
                ],
              ),
            ],
          );
        });
  }

  Widget _buildCharContent2(
      BuildContext context,
      Future<ChartUsageDetailSmartmeter> getChartUsageDetail,
      String period,
      int selectedYear,
      int monthSelected) {
    return FutureBuilder<ChartUsageDetailSmartmeter>(
        future: getChartUsageDetail,
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
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          //print('PERIOD DARI API ${snapshot.data.data[0].date.display}');
          return Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, i) {
                  return i < 1
                      ? _buildRow(snapshot.data.data, period, selectedYear,
                          monthSelected)
                      : SizedBox(
                          height: 10.0,
                        );
                },
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: painting.Color(0xFF4578EF),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
                        child: Text(
                          'Weekly Volume',
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        )),
                  ),
                  InkWell(
                    child: Container(
                      height: 30,
                      width: 80,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue),
                      child: Text(
                        Translations.of(context)
                            .text('f_customer_gas_usage_detail_bt_detail'),
                        style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      //print('ini titlenyaaa : $title');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HarianDetailMngRTPKChart(
                                    title: title,
                                    period: period,
                                    custID: idCust,
                                  )));
                    },
                  )
                ],
              ),
            ],
          );
        });
  }

  Widget _buildCharContent3(
      BuildContext context,
      Future<ChartUsageDetailSmartmeter> getChartUsageDetail,
      String period,
      int selectedYear,
      int monthSelected) {
    return FutureBuilder<ChartUsageDetailSmartmeter>(
        future: getChartUsageDetail,
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
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          //print('PERIOD DARI API ${snapshot.data.data[0].date.display}');
          return Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, i) {
                  return i < 1
                      ? _buildRow(snapshot.data.data, period, selectedYear,
                          monthSelected)
                      : SizedBox(
                          height: 10.0,
                        );
                },
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: painting.Color(0xFF4578EF),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
                        child: Text(
                          'Weekly Volume',
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        )),
                  ),
                  InkWell(
                    child: Container(
                      height: 30,
                      width: 80,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue),
                      child: Text(
                        Translations.of(context)
                            .text('f_customer_gas_usage_detail_bt_detail'),
                        style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      //print('ini titlenyaaa : $title');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HarianDetailMngRTPKChart(
                                    title: title,
                                    period: period,
                                    custID: idCust,
                                  )));
                    },
                  )
                ],
              ),
            ],
          );
        });
  }

  Widget _buildRow(List<UsageDetailChar> data, String period, int selectedYear,
      int monthSelected) {
    return Container(
      height: 212,
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: SimpleLineCharts(
            _createSampleData17(data), period, selectedYear, monthSelected),
      ),
    );
  }

  Future<ChartUsageDetailSmartmeter> fetchGetChar(
      BuildContext context, String title) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    //print('INI PERIODNYA $accessToken');
    var responseUsageChar = await http.get(
      '${UrlCons.mainProdUrl}customers/$idCust/gas-usages/smart-meter-chart/$title',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang,
      },
    );
    //print('RETURN DATA SMART METER ${responseUsageChar.body}');
    ChartUsageDetailSmartmeter _getContract =
        ChartUsageDetailSmartmeter.fromJson(
            json.decode(responseUsageChar.body));
    //print('RETURN DATA MODEL ${_getContract.data.length}');
    return _getContract;
  }

  Future<ChartUsageDetailSmartmeter> fetchGetChar2(
      BuildContext context, String title) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    //print('INI PERIODNYA $accessToken');
    var responseUsageChar = await http.get(
      '${UrlCons.mainProdUrl}customers/$idCust/gas-usages/smart-meter-chart/$title',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang,
      },
    );
    //print('RETURN DATA SMART METER ${responseUsageChar.body}');
    ChartUsageDetailSmartmeter _getContract =
        ChartUsageDetailSmartmeter.fromJson(
            json.decode(responseUsageChar.body));
    //print('RETURN DATA MODEL ${_getContract.data.length}');
    return _getContract;
  }

  Future<ChartUsageDetailSmartmeter> fetchGetChar3(
      BuildContext context, String title) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    //print('INI PERIODNYA $accessToken');
    var responseUsageChar = await http.get(
      '${UrlCons.mainProdUrl}customers/$idCust/gas-usages/smart-meter-chart/$title',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang,
      },
    );
    //print('RETURN DATA SMART METER ${responseUsageChar.body}');
    ChartUsageDetailSmartmeter _getContract =
        ChartUsageDetailSmartmeter.fromJson(
            json.decode(responseUsageChar.body));
    //print('RETURN DATA MODEL ${_getContract.data.length}');
    return _getContract;
  }
}

class SimpleLineCharts extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final String period;
  final int selectedYear;
  final int monthSelected;
  SimpleLineCharts(
      this.seriesList, this.period, this.selectedYear, this.monthSelected,
      {this.animate = true});

  @override
  SimpleLineChart createState() =>
      SimpleLineChart(seriesList, period, selectedYear, monthSelected);
}

class SimpleLineChart extends State<SimpleLineCharts> {
  final List<charts.Series> seriesList;
  final bool animate;
  final String period;
  final int selectedYear;
  final int monthSelected;
  String valueText = '0';
  String titleText;
  Widget _timeSeriesChart;
  SimpleLineChart(
      this.seriesList, this.period, this.selectedYear, this.monthSelected,
      {this.animate = true});

  @override
  void initState() {
    super.initState();
    //print('SELECTED YEAR : $selectedYear');
    //print('SELECTED MONTH : $monthSelected');
    setState(() {
      _timeSeriesChart = charts.TimeSeriesChart(
        seriesList,
        defaultRenderer: new charts.LineRendererConfig(
            includeArea: true,
            stacked: true,
            includePoints: true,
            radiusPx: 4.0),
        animate: false,
        // domainAxis: new charts.EndPointsTimeAxisSpec(
        //   tickProviderSpec: charts.DayTickProviderSpec(increments: [6]),
        // ),

        domainAxis: charts.DateTimeAxisSpec(
          tickProviderSpec: charts.StaticDateTimeTickProviderSpec(
            <charts.TickSpec<DateTime>>[
              charts.TickSpec<DateTime>(
                  DateTime(selectedYear, monthSelected, 07)),
              charts.TickSpec<DateTime>(
                  DateTime(selectedYear, monthSelected, 14)),
              charts.TickSpec<DateTime>(
                  DateTime(selectedYear, monthSelected, 21)),
              charts.TickSpec<DateTime>(
                  DateTime(selectedYear, monthSelected, 28)),
            ],
          ),
          tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
            day: charts.TimeFormatterSpec(
              format: 'dd',
              transitionFormat: 'dd MMM',
            ),
          ),
        ),
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec:
                new charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
        dateTimeFactory: new charts.LocalDateTimeFactory(),
        selectionModels: [
          charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model) {
                setState(
                  () {
                    valueText =
                        '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}';
                    titleText =
                        '${model.selectedSeries[0].domainFn(model.selectedDatum[0].index)}';
                  },
                );
              })
        ],
      );
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 180,
          child: _timeSeriesChart,
        ),
        SizedBox(height: 5),
        titleText != null
            ? Text(
                'Volume(${DateFormat("MMM d").format(DateTime.parse(titleText))}) : $valueText' ??
                    '-',
                style: TextStyle(
                    color: painting.Color(0xFFFF972F),
                    fontWeight: FontWeight.bold),
              )
            : Container(),
      ],
    );
  }
}

class LinearSalesDateTime {
  final DateTime year;
  final int sales;

  LinearSalesDateTime(this.year, this.sales);
}
