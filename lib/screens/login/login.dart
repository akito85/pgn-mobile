import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/register/register.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/services/language.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:pgn_mobile/screens/login/login_screen.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 30),
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
                moveIndicatorFromBottom: 180.0,
                animationDuration: Duration(microseconds: 2000),
              ),
            ),
            Positioned(
              bottom: 140,
              left: 25,
              right: 25,
              child: Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xFF427CEF),
                  ),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setLang(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  )),
            ),
            Positioned(
              left: 25,
              right: 25,
              bottom: 100,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                    )),
                    Text(
                      "    Or    ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                    )),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 50,
              right: 50,
              bottom: 70,
              child: Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Provider.of<Language>(context, listen: true).lang(
                      registration:
                          Translations.of(context).text('title_bar_register'),
                      phonNumb: Translations.of(context)
                          .text('ff_change_number_et_hint_phone_number'),
                      idPelanggan: Translations.of(context)
                          .text('f_household_invoice_form_et'),
                      registDesc:
                          Translations.of(context).text('ff_register_note'),
                      register: Translations.of(context)
                          .text('ff_guest_home_tv_register'),
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text(
                    "Don't Have an Account? REGISTER",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void setLang(BuildContext context) {
  Provider.of<Language>(context).lang(
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
