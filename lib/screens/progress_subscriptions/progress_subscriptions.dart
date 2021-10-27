import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pgn_mobile/models/subscription_progress_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/otp/otp.dart';
import 'package:pgn_mobile/screens/progress_subscriptions/widgets/progress_subs_detail.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProgressSubscriptions extends StatefulWidget {
  @override
  _ProgressSubscriptionsState createState() => _ProgressSubscriptionsState();
}

class _ProgressSubscriptionsState extends State<ProgressSubscriptions> {
  ScrollController _scrollController = ScrollController();
  List<DataSubscription> returnSubsProg = [];
  String userName = '';
  String userID = '';
  String nextPage = '';
  bool _isLoading = false;
  TextEditingController formIDCtrl = TextEditingController();
  TextEditingController ktpIDCtrl = TextEditingController();
  final storageCache = FlutterSecureStorage();
  void initState() {
    super.initState();

    getDataCred();
    this.getSubsProg();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        this.getSubsProg();

        Future.delayed(Duration(seconds: 3), _updateStatus);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future _updateStatus() async {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('pb_tab_title'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF427CEF),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin:
                    EdgeInsets.only(left: 18, right: 18, bottom: 11, top: 20),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16, top: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 20),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/icon_default_pelanggan.png'),
                          backgroundColor: Colors.transparent,
                          radius: 21.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          userName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<SubscriptionsProgressModel>(
                future: getFutureSubsProg(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 18, right: 18, top: 5),
                      child: LinearProgressIndicator(),
                    );
                  if (snapshot.data.code != null)
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 150),
                          alignment: Alignment.center,
                          child: Image.asset('assets/penggunaan_gas.png'),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            snapshot.data.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: returnSubsProg.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProgressSubsDetail(
                                  formID: returnSubsProg[i].formId),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          margin: EdgeInsets.only(top: 10, left: 18, right: 18),
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20, top: 5, right: 14),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Reg No : ${returnSubsProg[i].formId}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF427CEF),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: IconButton(
                                        icon: Image.asset(
                                          'assets/trash.png',
                                          height: 25,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          deleteFormIdAlert(
                                              returnSubsProg[i].id,
                                              returnSubsProg[i].formId,
                                              returnSubsProg[i].name);
                                        }),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 115,
                                    margin: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Name Customer',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        returnSubsProg[i].name ?? "-",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 115,
                                    margin:
                                        EdgeInsets.only(left: 20.0, top: 15),
                                    child: Text(
                                      'Category Customer',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 25.0, top: 15),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 5.0, top: 15),
                                      child: Text(
                                        returnSubsProg[i].katPelanggan ?? "-",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 115,
                                    margin: EdgeInsets.only(
                                        left: 20.0, top: 15, bottom: 20),
                                    child: Text(
                                      'Reg Status',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 25.0, top: 15, bottom: 20),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: returnSubsProg[i].rejectedDate !=
                                                null
                                            ? Color(0xFFFF0000)
                                            : Color(0xFF427CEF),
                                        borderRadius: BorderRadius.circular(5)),
                                    margin: EdgeInsets.only(
                                        left: 5.0,
                                        top: 15,
                                        bottom: 20,
                                        right: 5),
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
                                    child: Text(
                                      returnSubsProg[i].status ?? "-",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 70),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 18,
            right: 18,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xFF427CEF),
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '+',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      '  Add Subsription Progress',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext contec) {
                        return addFormIdAlert();
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void getSubsProg() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetSubsProg = await http.get(
        '${UrlCons.mainDevUrl}prospective_customer_progress?cursor=$nextPage',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang,
        });
    SubscriptionsProgressModel returnGetSubsProg =
        SubscriptionsProgressModel.fromJson(
            json.decode(responseGetSubsProg.body));

    if (returnGetSubsProg.message == null &&
        returnGetSubsProg.dataSubscription.length > 0) {
      setState(() {
        nextPage = returnGetSubsProg.paging.next;
        returnSubsProg.addAll(returnGetSubsProg.dataSubscription);
      });
    }
  }

  void getDataCred() async {
    String userNameString = await storageCache.read(key: 'user_id');
    String userIDString = await storageCache.read(key: 'user_name');
    setState(() {
      userID = userNameString;
      userName = userIDString;
    });
  }

  Future<SubscriptionsProgressModel> getFutureSubsProg() async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetSubsProg = await http
        .get('${UrlCons.mainDevUrl}prospective_customer_progress', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    });
    return SubscriptionsProgressModel.fromJson(
        json.decode(responseGetSubsProg.body));
  }

  void deleteFormId(String reqID, String custId, String custName) async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseDeleteCustId = await http.delete(
      '${UrlCons.mainProdUrl}delete_prospective_customer_progress/$reqID',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
    );
    DeleteFormId switchCustomerId =
        DeleteFormId.fromJson(json.decode(responseDeleteCustId.body));
    if (responseDeleteCustId.statusCode == 200) {
      Navigator.pop(context);
      showToast(switchCustomerId.dataDeleteCustomerId.message);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else {
      showToast(switchCustomerId.message);
    }
  }

  void addFormId() async {
    String accessToken = await storageCache.read(key: 'access_token');
    var body = json
        .encode({"form_id": formIDCtrl.text, "idcard_number": ktpIDCtrl.text});
    var responseDeleteCustId = await http.post(
        '${UrlCons.mainProdUrl}insert_prospective_customer_progress',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);
    print('STATUS BERLANGGANAN : ${responseDeleteCustId.body}');
    DeleteFormId switchCustomerId =
        DeleteFormId.fromJson(json.decode(responseDeleteCustId.body));
    if (responseDeleteCustId.statusCode == 200) {
      showToast(switchCustomerId.dataDeleteCustomerId.message);
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else {
      showToast(switchCustomerId.message);
    }
  }

  Future<bool> deleteFormIdAlert(
      String reqIDCust, String formId, String custName) {
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
            "${Translations.of(context).text('f_dialog_confirmation_delete_form')} $formId ($custName)",
            style: TextStyle(
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
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          width: 130,
          onPressed: () async {
            deleteFormId(reqIDCust, formId, custName);
          },
          color: Colors.red,
          child: Text(
            "Delete",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }

  Widget addFormIdAlert() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "${Translations.of(context).text('f_dialog_confirmation_add_form')} ",
              style: TextStyle(
                  // color: painting.Color.fromRGBO(255, 255, 255, 0),
                  fontSize: 18,
                  color: Color(0xFF427CEF),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Form ID',
                style: TextStyle(
                    color: Color(0xFF455055), fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 5),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: formIDCtrl,
                decoration: InputDecoration(
                  hintText: 'Enter your form ID here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 02,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Last 6 Digits of Your ID (KTP)',
                style: TextStyle(
                    color: Color(0xFF455055), fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 5),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: ktpIDCtrl,
                decoration: InputDecoration(
                  hintText: '6 Digits',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 02,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 36),
            Row(
              children: [
                DialogButton(
                  width: 100,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  color: Color(0xFFD3D3D3),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DialogButton(
                    width: 130,
                    onPressed: () async {
                      addFormId();
                    },
                    color: Color(0xFF427CEF),
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
