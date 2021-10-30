import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/services/applications.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/screens/customer_profile/customer_profile.dart';
import 'package:pgn_mobile/models/cust_profile_model.dart';
import 'package:pgn_mobile/models/cust_invoice_model.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/user_credientials.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  SpecificLocalizationDelegate _localeOverrideDelegate;
  bool langSwitch = true;
  Color indLangSelected = Color(0xFF9B9B9B);
  Color enLangSelected = Color(0xFF9B9B9B);
  String userTypes;
  String customerGroupId;
  List<String> listMenus = [];
  final storageCache = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getUserType(context);
    _localeOverrideDelegate = SpecificLocalizationDelegate(null);

    applic.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<UserCred>(context);
    // print('USER GROUP IDNYA : ${_prov.customerGroupId}');
    // print('USER GROUP ID : ${customerGroupId}');
    // print('USER TYPES ID : ${userTypes}');
    if (userTypes != '2')
      return Container(
        color: Colors.white,
        child: ListView(children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0, top: 30),
            leading: Icon(Icons.dashboard),
            title: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Divider(color: Colors.black26),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20),
            leading: Image.asset(
              'assets/logo_head_menu.png',
              width: 30.0,
              height: 30.0,
            ),
            title: Text(
              Translations.of(context).text('title_bar_about') ?? "-",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/aboutPgn');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Icon(Icons.equalizer),
            title: Text(
              Translations.of(context).text('a_home_tv_menu_trend'),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/usageTrend');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Icon(Icons.location_city),
            title: Text(
              Translations.of(context).text('a_home_tv_menu_summary'),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sectorIndustry');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Icon(Icons.domain),
            title: Text(
              Translations.of(context).text('a_home_tv_menu_summary_area'),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/salesArea');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Icon(Icons.exposure),
            title: Text(
              Translations.of(context).text('a_home_tv_menu_calculator'),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/calculatorEnergy');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Icon(Icons.import_contacts),
            title: Text(
              Translations.of(context).text('title_bar_dictionary'),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/energyDict');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Icon(Icons.ev_station),
            title: Text(
              Translations.of(context).text('a_home_tv_menu_spbg'),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/gasStation');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Icon(Icons.notifications_active),
            title: Text(
              Translations.of(context).text('title_bar_notification'),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ]),
      );
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          listMenus.contains('9')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0, top: 30),
                  leading: Icon(Icons.dashboard),
                  title: Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/dashboard');
                  },
                )
              : SizedBox(),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Divider(color: Colors.black26),
          ),
          listMenus.contains('1')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  leading: Image.asset(
                    'assets/logo_head_menu.png',
                    width: 30.0,
                    height: 30.0,
                  ),
                  title: Text(
                    Translations.of(context).text('title_bar_about'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/aboutPgn');
                  },
                )
              : SizedBox(),
          listMenus.contains('14')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Icon(Icons.equalizer),
                  title: Text(
                    Translations.of(context).text('a_home_tv_menu_trend'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/usageTrend');
                  },
                )
              : SizedBox(),
          listMenus.contains('15')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Icon(Icons.location_city),
                  title: Text(
                    Translations.of(context).text('a_home_tv_menu_summary'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/sectorIndustry');
                  },
                )
              : SizedBox(),
          listMenus.contains('16')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Icon(Icons.domain),
                  title: Text(
                    Translations.of(context)
                        .text('a_home_tv_menu_summary_area'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/salesArea');
                  },
                )
              : SizedBox(),
          listMenus.contains('17')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Icon(Icons.exposure),
                  title: Text(
                    Translations.of(context).text('a_home_tv_menu_calculator'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/calculatorEnergy');
                  },
                )
              : SizedBox(),
          listMenus.contains('18')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Icon(Icons.import_contacts),
                  title: Text(
                    Translations.of(context).text('title_bar_dictionary'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/energyDict');
                  },
                )
              : SizedBox(),
          listMenus.contains('2')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Icon(Icons.ev_station),
                  title: Text(
                    Translations.of(context).text('a_home_tv_menu_spbg'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/gasStation');
                  },
                )
              : SizedBox(),
          customerGroupId == '3' && listMenus.contains('8')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Icon(Icons.receipt_long_outlined),
                  title: Text(
                    Translations.of(context).text('a_home_tv_menu_cmm'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/cmm');
                  },
                )
              : SizedBox(),
          listMenus.contains('3')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Icon(Icons.subscriptions_sharp),
                  title: Text(
                    Translations.of(context).text('pb_tab_title'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/subscriptionProgress');
                  },
                )
              : SizedBox(),
          listMenus.contains('22')
              ? ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  leading: Icon(Icons.subscriptions_sharp),
                  title: Text(
                    Translations.of(context).text('pc_tab_title'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/subscriptionProgress');
                  },
                )
              : SizedBox(),
          Divider(color: Colors.black),
        ],
      ),
    );
  }

  getUserType(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String useraUserTypes = await storageCache.read(key: 'user_type') ?? "";
    String listMenusString = await storageCache.read(key: 'list_menu') ?? "";
    String customerGroupds =
        await storageCache.read(key: 'customer_groupId') ?? "";

    setState(() {
      userTypes = useraUserTypes;
      customerGroupId = customerGroupds;
      listMenus = listMenusString.split(',');
    });
    print('HASIL LIST MENU LENGHT = ${listMenus.length}');
  }

  goToCustomerUsadeDetail(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String userType = prefs.getString('user_type');
    String userType = await storageCache.read(key: 'user_type');
    if (userType != '2') {
      Navigator.pushNamed(context, '/customerBill');
    } else if (userType == '2') {
      getCustomerInvoice(context);
    }
  }

  goToCustomerInvoice(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // String userType = prefs.getString('user_type');
    String userType = await storageCache.read(key: 'user_type');

    if (userType != '2') {
      Navigator.pushNamed(context, '/customerBill');
    } else if (userType == '2') {
      getCustomerInvoice(context);
    }
  }

  Future<CustomerInvoice> getCustomerInvoice(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('access_token');
    String accessToken = await storageCache.read(key: 'access_token');
    var responseCustomerInvoice = await http
        .get('${UrlCons.mainProdUrl}customers/me/invoices', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    });
    CustomerInvoice _customerInvoice =
        CustomerInvoice.fromJson(json.decode(responseCustomerInvoice.body));
    if (responseCustomerInvoice.statusCode == 200) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => InvoiceCust(data: _customerInvoice, custID: "02200001")));
      //     print('USERGROUP Is');
    }
  }

  gotoCustomerProfile(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // // String accessToken = prefs.getString('access_token');

    // String userType = prefs.getString('user_type');
    String userType = await storageCache.read(key: 'user_type');

    if (userType != '2') {
      Navigator.pushNamed(context, '/customers');
    } else if (userType == '2') {
      getCustomerProfile(context);
    }
  }

  Future<Customer> getCustomerProfile(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('access_token');
    String accessToken = await storageCache.read(key: 'access_token');
    var responseCustomer = await http.get('${UrlCons.mainProdUrl}customers/me',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    Customer _customer = Customer.fromJson(json.decode(responseCustomer.body));

    if (responseCustomer.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CustomerDetail(data: _customer)));
    }
  }
}

void _signingOff(BuildContext context) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString('user_id', "kosong");
  // prefs.setString('access_token', "kosong");

  final storageCache = FlutterSecureStorage();
  await storageCache.write(key: 'user_id', value: 'kosong');
  await storageCache.write(key: 'access_token', value: 'kosong');
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (Route<dynamic> route) => false,
  );
}
