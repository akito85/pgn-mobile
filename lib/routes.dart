import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/cmm/cmm.dart';
import 'package:pgn_mobile/screens/cmm/cmm_form.dart';
import 'package:pgn_mobile/screens/customer_payment_confirmation/customer_payment_confirmation.dart';
import 'package:pgn_mobile/screens/dashboard/dashboard.dart';
import 'package:pgn_mobile/screens/gas_station/gas_station.dart';
import 'package:pgn_mobile/screens/login/login.dart';
import 'package:pgn_mobile/screens/mng_payment_confirmation/mng_payment_confirmation.dart';
import 'package:pgn_mobile/screens/progress_subscriptions/progress_subscriptions.dart';
import 'package:pgn_mobile/screens/login/login_change_numb.dart';
import 'package:pgn_mobile/screens/progress_subscriptions/widgets/progress_subs_detail.dart';
import 'package:pgn_mobile/splash_screen.dart';
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
        // ChangeNotifierProvider<PushNotification>.value(
        //     value: PushNotification()),
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
    '/login': (context) => Login(),
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
    '/subscriptionProgress': (context) => ProgressSubscriptions(),
    '/subsProgressDetail': (context) => ProgressSubsDetail(),
    '/paymentConfirmation': (context) => CustomerPaymentConfirmation(),
    '/paymentConfirmationMng': (context) => MngPaymentConf(),
  };

  SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    applic.onLocaleChanged = onLocaleChange;
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
}
