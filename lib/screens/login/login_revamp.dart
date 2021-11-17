import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/about_pgn/pgn_services.dart';
import 'package:pgn_mobile/screens/register/register.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/services/language.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class LoginRevamp extends StatefulWidget {
  @override
  LoginRevampState createState() => LoginRevampState();
}

class LoginRevampState extends State<LoginRevamp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Carousel(
                images: [
                  AssetImage('assets/background_landing_1.jpg'),
                  AssetImage('assets/background_landing_2.jpg'),
                  AssetImage('assets/background_landing_3.jpg'),
                  AssetImage('assets/background_landing_4.jpg'),
                  AssetImage('assets/background_landing_5.jpg'),
                ],
                animationCurve: Curves.fastOutSlowIn,
                noRadiusForIndicator: false,
                overlayShadow: false,
                boxFit: BoxFit.cover,
                borderRadius: false,
                indicatorBgPadding: 0,
                dotSize: 7.0,
                dotPosition: DotPosition.bottomCenter,
                moveIndicatorFromBottom: 10.0,
                animationDuration: Duration(microseconds: 2000),
              ),
            ),
            Positioned(
                child: ListView(
              children: <Widget>[
                SizedBox(height: 45),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 40.0),
                  height: 160,
                  child: Image.asset('assets/icon_launch.png'),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 40.0),
                  child: Text(
                      Translations.of(context)
                          .text('title_welcome_screen' ?? '-'),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 12.0, left: 35.0, right: 35.0),
                    child: Text(
                        Translations.of(context)
                            .text('subtitle_welcome_screen' ?? '-'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 2,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white))),
                Container(
                    margin: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: MaterialButton(
                            // minWidth: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 18.0),
                                  width: 17.0,
                                  height: 20.0,
                                  child: Image.asset(
                                    'assets/logo_head.png',
                                    color: Color(0xFF427CEF),
                                  ),
                                ),
                                Text(
                                  'PGN Product & Services',
                                  style: TextStyle(color: Color(0xFF427CEF)),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PgnServices()));
                            },
                          ),
                        ),
                      ],
                    ))
              ],
            )),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(bottom: 60.0, left: 20.0, right: 20.0),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        // width: MediaQuery.of(context).size.width / 2.3,
                        height: 50.0,
                        margin: EdgeInsets.only(top: 12.0, left: 20, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF427CEF),
                        ),
                        child: MaterialButton(
                            child: Text(
                              Translations.of(context)
                                  .text('label_signin_button' ?? '-'),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              setLang(context, true);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            }),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 12.0, right: 20, left: 5),
                        // width: MediaQuery.of(context).size.width / 2.3,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.orange,
                        ),
                        child: MaterialButton(
                            child: Text(
                              Translations.of(context)
                                  .text('label_register_button'),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Provider.of<Language>(context, listen: true).lang(
                                registration: Translations.of(context)
                                    .text('title_bar_register'),
                                phonNumb: Translations.of(context).text(
                                    'ff_change_number_et_hint_phone_number'),
                                idPelanggan: Translations.of(context)
                                    .text('f_household_invoice_form_et'),
                                registDesc: Translations.of(context)
                                    .text('ff_register_note'),
                                register: Translations.of(context)
                                    .text('ff_guest_home_tv_register'),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            }),
                      ),
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

void setLang(BuildContext context, bool listen) {
  Provider.of<Language>(context, listen: listen).lang(
    forgotPass: Translations.of(context).text('title_bar_forgot_password'),
    send: Translations.of(context).text('ff_forgot_password_bt_send'),
    forgotPassDesc:
        Translations.of(context).text('ff_forgot_password_tv_instruction_desc'),
    btnForgotPass: Translations.of(context).text('ff_login_bt_forgot_password'),
    verifikasi: Translations.of(context).text('title_bar_otp'),
    descVer: Translations.of(context).text('ff_otp_tv_instruction_desc'),
    verUbahNo: Translations.of(context).text('ff_otp_bt_change_number'),
    kirimUlangNo: Translations.of(context).text('ff_otp_bt_resend'),
    konfirmasi: Translations.of(context).text('ff_otp_bt_confirmation'),
    custInvoice: Translations.of(context).text('a_home_tv_menu_invoice'),
    custInDesc: Translations.of(context).text('f_household_invoice_form_tv'),
    idPelanggan: Translations.of(context).text('f_household_invoice_form_et'),
    check: Translations.of(context).text('f_household_invoice_form_bt'),
    registration: Translations.of(context).text('title_bar_register'),
    phonNumb:
        Translations.of(context).text('ff_change_number_et_hint_phone_number'),
    custPassword: Translations.of(context).text('f_household_invoice_form_bt'),
    registDesc: Translations.of(context).text('f_household_invoice_form_bt'),
    register: Translations.of(context).text('ff_guest_home_tv_register'),
    hitung: Translations.of(context).text('ff_calculator_boiler_bt_submit'),
    kalEnergi: Translations.of(context).text('title_bar_calculator'),
    konversi: Translations.of(context).text('f_calculator_conversion_tv_title'),
    listrik: Translations.of(context).text('f_calculator_electricity_tv_title'),
    apabilaTerdapatPerbedaan:
        Translations.of(context).text('f_customer_invoice_tv_footer_notes'),
    changeNumb: Translations.of(context).text('ff_otp_bt_change_number'),
    changeNumbDesc:
        Translations.of(context).text('ff_change_number_tv_instruction_desc'),
    change: Translations.of(context).text('ff_change_number_bt_change'),
  );
}
