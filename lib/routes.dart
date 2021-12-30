import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/dashboard_customer_model.dart';
import 'package:pgn_mobile/screens/about_pgn/pgn_services.dart';
import 'package:pgn_mobile/screens/cm_visit/cm_visit.dart';
import 'package:pgn_mobile/screens/cm_visit/cm_visit_form.dart';
import 'package:pgn_mobile/screens/cmm/cmm.dart';
import 'package:pgn_mobile/screens/cmm/cmm_form.dart';
import 'package:pgn_mobile/screens/customer_payment_confirmation/customer_payment_confirmation.dart';
import 'package:pgn_mobile/screens/dashboard/dashboard.dart';
import 'package:pgn_mobile/screens/gas_station/gas_station.dart';
import 'package:pgn_mobile/screens/installation_inspection/installation_inspection.dart';
import 'package:pgn_mobile/screens/installation_inspection/installation_inspection_detail.dart';
import 'package:pgn_mobile/screens/invoice_customer_residential/payment.dart';
import 'package:pgn_mobile/screens/login/login.dart';
import 'package:pgn_mobile/screens/login/login_revamp.dart';
import 'package:pgn_mobile/screens/mng_payment_confirmation/mng_payment_confirmation.dart';
import 'package:pgn_mobile/screens/notification_customer/notification_customer.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pengajuan_layanan.dart';
import 'package:pgn_mobile/screens/progress_subscriptions/progress_subscriptions.dart';
import 'package:pgn_mobile/screens/login/login_change_numb.dart';
import 'package:pgn_mobile/screens/progress_subscriptions/widgets/progress_subs_detail.dart';
import 'package:pgn_mobile/screens/smartmeter_mng/smartmeter_mng.dart';
import 'package:pgn_mobile/screens/smartmeter_rtpk/smartmeter_rtpk.dart';
import 'package:pgn_mobile/services/push_notification.dart';
import 'package:pgn_mobile/splash_screen.dart';
import 'package:pgn_mobile/widgets/active_cust_dialog.dart';
import 'package:pgn_mobile/widgets/push_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/register_residential.dart';
import 'package:pgn_mobile/services/calculators.dart';
import 'package:pgn_mobile/screens/calculator/calculator.dart';
import 'package:pgn_mobile/screens/about_pgn/about_pgn.dart';
import 'package:pgn_mobile/screens/cutomer_bill/customer_bill.dart';
import 'package:pgn_mobile/screens/energy_dict/energy_dict.dart';
import 'package:pgn_mobile/screens/notifications/notifications.dart';
import 'package:pgn_mobile/screens/saels_area/sales_area.dart';
import 'package:pgn_mobile/screens/sector_industry/sector_industry.dart';
import 'package:pgn_mobile/screens/usage_trend/usage_trend.dart';
import 'package:pgn_mobile/screens/customers_manager/customers.dart';
import 'package:pgn_mobile/screens/usage_detail/usage_detail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/services/applications.dart';
import 'package:pgn_mobile/screens/otp/otp.dart';
import 'package:pgn_mobile/services/user_credientials.dart';
import 'package:pgn_mobile/services/language.dart';
import 'package:pgn_mobile/services/usage_detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'models/url_cons.dart';

class Routes {
  Routes() {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<RegistResidential>.value(
            value: RegistResidential()),
        ChangeNotifierProvider<UserCred>.value(value: UserCred()),
        ChangeNotifierProvider<Language>.value(value: Language()),
        ChangeNotifierProvider<UsgDetail>.value(value: UsgDetail()),
        ChangeNotifierProvider<CalculatorsEnergy>.value(
            value: CalculatorsEnergy()),
        ChangeNotifierProvider<PushNotification>.value(
            value: PushNotification()),
      ],
      child: FirstScreen(),
    ));
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _MyFirstState createState() => new _MyFirstState();
}

class _MyFirstState extends State<FirstScreen> {
  var _routes = {
    '/login': (context) => LoginRevamp(),
    // '/login': (context) => Login(),
    '/loginchangenumb': (context) => LoginChangeNumb(),
    '/otp': (context) => OTPForm(),
    '/dashboard': (context) => Dashboard(),
    '/gasStation': (context) => GasStation(),
    '/calculatorEnergy': (context) => Calculator(),
    '/aboutPgn': (context) => AboutPgn(),
    '/customerBill': (context) => CustomerBills(),
    '/energyDict': (context) => EnergyDict(),
    '/notifications': (context) => Notifications(),
    '/salesArea': (context) => SalesArea(),
    '/sectorIndustry': (context) => SectorIndustry(),
    '/usageTrend': (context) => UsageTrend(),
    '/customers': (context) => Customers(),
    '/cmm': (context) => CMM(),
    '/cmmForm': (context) => CMMForm(),
    '/usageDetail': (context) => UsageDetail(),
    '/cmVisit': (context) => CMVisit(),
    '/cmVisitForm': (context) => CMVisitForm(),
    '/pgnServices': (context) => PgnServices(),
    '/installationInspection': (context) => InstallationInspection(),
    '/subscriptionProgress': (context) => ProgressSubscriptions(),
    '/installationInspectionDetail': (context) =>
        InstallationInspectionDetail(),
    '/payment': (context) => Payment(),
    '/subsProgressDetail': (context) => ProgressSubsDetail(),
    '/paymentConfirmation': (context) => CustomerPaymentConfirmation(),
    '/paymentConfirmationMng': (context) => MngPaymentConf(),
    '/smartmeterRTPK': (context) => UsageDetailRTPK(),
    '/notificationCustomer': (context) => NotificationCustomer(),
    '/smartmeterMng': (context) => SmartmeterMng(),
    '/pengajuanLayanan': (context) => PengajuanLayanan(),
  };

  SpecificLocalizationDelegate _localeOverrideDelegate;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    applic.onLocaleChanged = onLocaleChange;
    // getActiveCustomer(context);
    _firebaseMsgListener();
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PGN Mobile',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        primaryColor: Color(0xFF427CEF),
        primaryColorDark: Colors.blue[800],
        accentColor: Colors.blue[600],
        appBarTheme: AppBarTheme(
            elevation: 5.0, iconTheme: IconThemeData(color: Colors.black)),
        cardTheme: CardTheme(
          elevation: 3.0,
        ),
      ),
      home: SplashScreen(),
      supportedLocales: applic.supportedLocales(),
      routes: _routes,
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }

  void _firebaseMsgListener() {
    Future.delayed(Duration(seconds: 1), () {
      _firebaseMessaging.configure(
        onBackgroundMessage: myBackgroundMessageHandler,
        onMessage: (Map<String, dynamic> message) async {
          print("=====>on message $message");
          print("ON MESSGAE");
          print("INI RETURN ${message['data']['type']}");
          // print("ON");
          if (message['data']['type'] == "promosi") {
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                    message['data']['imageURL'],
                    message['data']['redirectURL']));
          } else if (message['data']['type'] == "menu_update") {
            getMenuUpdate(context, message['data']['menu_id']);
          } else if (message['data']['type'] == "verify") {
            getActiveCustomer(context);
          }
        },
        onResume: (Map<String, dynamic> message) async {
          print("ON RESUME");
          print("INI RETURN ${message['data']['type']}");
          if (message['data']['type'] == "promosi") {
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                    message['data']['imageURL'],
                    message['data']['redirectURL']));
          } else if (message['data']['type'] == "menu_update") {
            getMenuUpdate(context, message['data']['menu_id']);
          } else if (message['data']['type'] == "verify") {
            getActiveCustomer(context);
          }
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("ON LAUNCH");
          print("INI RETURN ${message['data']['type']}");
          if (message['data']['type'] == "promosi") {
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                    message['data']['imageURL'],
                    message['data']['redirectURL']));
          } else if (message['data']['type'] == "menu_update") {
            getMenuUpdate(context, message['data']['menu_id']);
          } else if (message['data']['type'] == "verify") {
            getActiveCustomer(context);
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

  void getActiveCustomer(BuildContext context) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseActiveCustomer = await http.get(
      '${UrlCons.mainProdUrl}active_customer_id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
    );

    SwitchCustomerId activeCustomer =
        SwitchCustomerId.fromJson(json.decode(responseActiveCustomer.body));
    print('HASIL GET CUSTOMER ${responseActiveCustomer.body}');
    if (responseActiveCustomer.statusCode == 200) {
      await storageCache.write(
          key: 'customer_id',
          value: activeCustomer.dataSwitchCustomerId.custID);
      await storageCache.write(
          key: 'user_name_cust',
          value: activeCustomer.dataSwitchCustomerId.custName);
      if (activeCustomer.dataSwitchCustomerId.product != null) {
        await storageCache.write(
            key: 'products',
            value: activeCustomer.dataSwitchCustomerId.product);
      } else {
        await storageCache.write(key: 'products', value: '-');
      }
      if (activeCustomer.dataSwitchCustomerId.menus != null) {
        List<String> _listMenus = [];
        activeCustomer.dataSwitchCustomerId.menus.forEach((i) {
          _listMenus.add(i.id.toString());
        });
        String listMenuString = _listMenus.join(',');
        print('HASIL MENU LIST TO STRING $listMenuString');
        await storageCache.write(key: 'list_menu', value: listMenuString);
      } else {
        await storageCache.write(key: 'list_menu', value: '-');
      }
      showToast(activeCustomer.dataSwitchCustomerId.message);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              ActivCustDialogNotif(activeCustomer.message));
    } else {
      showToast(activeCustomer.message);
    }
  }

  void getMenuUpdate(BuildContext context, String stringMenu) async {
    final storageCache = FlutterSecureStorage();

    await storageCache.write(key: 'list_menu', value: stringMenu);
    showToast('Menu Berhasil di Update $stringMenu');
    Navigator.pop(context);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }
}
