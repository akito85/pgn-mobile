import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:pgn_mobile/models/payment_plan_model.dart';
import 'package:intl/intl.dart';

class CreatePaymentPlan extends StatefulWidget {
  final String custID;
  final String paymentUSD;
  final String paymentUSDdisplay;
  CreatePaymentPlan({this.custID, this.paymentUSD, this.paymentUSDdisplay});
  @override
  CreatePPState createState() => CreatePPState(
      custID: custID,
      paymentUSD: paymentUSD,
      paymentUSDdisplay: paymentUSDdisplay);
}

class CreatePPState extends State<CreatePaymentPlan> {
  String custID;
  String paymentUSD;
  String paymentUSDdisplay;
  CreatePPState({this.custID, this.paymentUSD, this.paymentUSDdisplay});
  String dateTimeSelected;
  DateTime selected;
  DateTime currentDate = DateTime.now();
  bool btnKonfirmasi = true;
  _showDateTimePicker() async {
    selected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    setState(() {
      invoiceDateCtrl.text = new DateFormat('dd MMM yyyy').format(selected);
      dateTimeSelected = new DateFormat('yyyy-MM-dd').format(selected);
    });
  }

  @override
  TextEditingController amountCtrl = new TextEditingController();
  TextEditingController noVirtualAccountCtrl = new TextEditingController();
  TextEditingController invoiceDateCtrl = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Payment Plan",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Image.asset(
                'assets/search.png',
                height: 200.0,
                width: 200.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
              alignment: Alignment.center,
              child: Text(
                "Total Tagihan IDR",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF427CEF)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0, bottom: 20.0),
              alignment: Alignment.center,
              child: Text(
                paymentUSDdisplay,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF427CEF)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Silahkan masukan Nama Perusahaan / Group beserta No Virtual Account",
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: amountCtrl,
                decoration: InputDecoration(
                  labelText: 'Nama Perusahaan / Group',
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _showDialogNoVirtualAcount(context, getNoVirtualAccount());
              },
              child: Container(
                padding: EdgeInsets.only(top: 5.0),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  enabled: true,
                  controller: noVirtualAccountCtrl,
                  decoration: InputDecoration(
                    labelText: 'No Virtual Account',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle,
                          color: Color(0XFF427CEF)),
                      onPressed: () {
                        _showDialogNoVirtualAcount(
                            context, getNoVirtualAccount());
                      },
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _showDateTimePicker();
              },
              child: Container(
                padding: EdgeInsets.only(top: 15.0),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  enabled: true,
                  controller: invoiceDateCtrl,
                  decoration: InputDecoration(
                    labelText: 'Rencana Pembayaran',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        size: 25,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _showDateTimePicker();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: btnKonfirmasi,
              child: Container(
                  height: 50.0,
                  margin: EdgeInsets.fromLTRB(100.0, 25.0, 100.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'KONFIRMASI',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        btnKonfirmasi = false;
                      });
                      putPaymentPlan(context, custID);
                    },
                  )),
            )
          ],
        ));
  }

  Widget _showDialogNoVirtualAcount(
      BuildContext context, Future<NoVirtualAccount> data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "No Virtual Account",
                        style: TextStyle(fontSize: 18),
                      ),
                      FutureBuilder<NoVirtualAccount>(
                        future: data,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Column(
                              children: <Widget>[LinearProgressIndicator()],
                            );
                          return ListView.builder(
                            itemCount: snapshot.data.data.length + 1,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return i < snapshot.data.data.length
                                  ? _buildRow(snapshot.data.data[i])
                                  : SizedBox(
                                      height: 10.0,
                                    );
                            },
                          );
                        },
                      ),
                    ],
                  )));
        });
  }

  Widget _buildRow(DataVirtualAccount data) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
      title: Text(
        data.id ?? " ",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        String sendBack = data.id.toString();
        setState(() {
          noVirtualAccountCtrl.text = sendBack;
        });
        Navigator.pop(context, sendBack);
      },
    );
  }

  Future<PutPaymentPlan> putPaymentPlan(
      BuildContext context, String paymentPlanID) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');

    Map body = {
      'payment_date': dateTimeSelected,
      'payment_usd': paymentUSD,
      'customer_invoice_id': paymentPlanID,
      'customer_virtual_account_id': noVirtualAccountCtrl.text
    };
    var responsePutPaymentPlan = await http.post(
        'http://192.168.105.184/pgn-mobile-api/v2/payment-plans',
        headers: {
          'Authorization': 'Bearer aDri8xQJDL6MpFFCUE6lAA4ref5nWb3VGaWyMdgC',
          'Content-Type': 'applictation/json',
          'accept': 'applictation/json'
        },
        body: jsonEncode(body));

    if (responsePutPaymentPlan.statusCode == 200) {
      successAlert(context, "Payment Plan berhasil dibuat!");
    } else {
      setState(() {
        btnKonfirmasi = true;
      });
      ReturnCreatePaymentPlan returnCreatePaymentPlan =
          ReturnCreatePaymentPlan.fromJson(
              json.decode(responsePutPaymentPlan.body));
      successAlert(context, returnCreatePaymentPlan.message);
    }
  }

  Future<bool> successAlert(BuildContext context, String message) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
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
            style: TextStyle(
                color: Color(0xFF707070),
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.green,
          child: Text(
            "OK",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }
}

Future<NoVirtualAccount> getNoVirtualAccount() async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  var responseVirtualAccount = await http
      .get('${UrlCons.mainProdUrl}customers/me/virtual-accounts', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });
  NoVirtualAccount _virtualAccount =
      NoVirtualAccount.fromJson(json.decode(responseVirtualAccount.body));
  return _virtualAccount;
}
