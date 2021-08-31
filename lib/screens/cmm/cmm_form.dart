import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pgn_mobile/models/cmm_form_model.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CMMForm extends StatefulWidget {
  CMMForm({this.custID, this.userid});
  final String custID;
  final String userid;

  @override
  CMMFormState createState() => CMMFormState(custID, userid);
}

class CMMFormState extends State<CMMForm> {
  String custID;
  String userid;
  CMMFormState(this.custID, this.userid);
  TextEditingController noIDMeterCtrl = new TextEditingController();
  TextEditingController angkaStandCtrl = new TextEditingController();
  File _image;
  var varImage;
  final picker = ImagePicker();
  Future getImage(String title) async {
    ImageSource imageSource;
    if (title == 'Camera') {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final pickedFile = await picker.getImage(
        source: imageSource, maxWidth: 1000, maxHeight: 1000, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // varImage = picker.getImage(source: imageSource);
        // print('No image selected. $varImage');
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Catat Meter Mandiri',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
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
          Container(
            margin: EdgeInsets.only(right: 5.0, left: 5.0, bottom: 10.0),
            child: ListView(
              children: <Widget>[
                // Container(
                //   height: 50,
                //   margin: EdgeInsets.only(top: 5.0, left: 10, right: 10),
                //   padding: EdgeInsets.only(left: 10, right: 10),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(15.0),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey,
                //         blurRadius: 2.0,
                //         spreadRadius: 0.0,
                //         offset:
                //             Offset(1.0, 1.0), // shadow direction: bottom right
                //       )
                //     ],
                //   ),
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     controller: noIDMeterCtrl,
                //     decoration: InputDecoration(
                //       labelText: 'No ID/Meter (auto generate)',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8),
                //         borderSide: BorderSide(
                //           width: 0,
                //           style: BorderStyle.none,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(1.0, 1.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: angkaStandCtrl,
                    decoration: InputDecoration(
                      labelText: 'Angka Stand',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin:
                      EdgeInsets.only(top: 20, bottom: 30, left: 10, right: 10),
                  elevation: 5,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          dialogChoosePic(context);
                          // getImage();
                        },
                        child: _image != null
                            ? Container(
                                height: 350,
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                      image: FileImage(_image),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : Container(
                                height: 350,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xFFD3D3D3),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_rounded,
                                      size: 65,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      Translations.of(context)
                                              .text('cmm_upload_photo') ??
                                          '',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      _image != null
                          ? Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: InkWell(
                                onTap: () {
                                  dialogChoosePic(context);
                                  // getImage();
                                },
                                child: Text(
                                  Translations.of(context)
                                          .text('cmm_form_retake_photo') ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF427CEF)),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Container(
                  height: 45.0,
                  margin:
                      EdgeInsets.only(top: 10, bottom: 30, left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    // color: Color(0xFFD3D3D3),untuk yang belum cmm
                    color: Color(0xFF427CEF),
                  ),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      dialogAlertCMMForm(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogChoosePic(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Select Method'),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xFF427CEF),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Camera',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  getImage('Camera');
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => Dashboard()));
                },
              ),
              SizedBox(height: 15),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xFF427CEF),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.insert_photo,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Gallery',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  getImage('Gallery');
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => Dashboard()));
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<bool> dialogAlertCMMForm(BuildContext context) {
    bool visibilityBtn = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (contextState, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    Translations.of(context).text('cmm_form_btn_confirm') ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 20),
                  Text(
                    Translations.of(context).text('cmm_form_alert') ?? '',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  visibilityBtn == false
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(bottom: 15),
                          child: CircularProgressIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: Color(0xFFD3D3D3),
                                  ),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    Translations.of(context).text(
                                            'cmm_form_btn_confirm_back') ??
                                        '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: Color(0xFF427CEF),
                                  ),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    Translations.of(context).text(
                                            'cmm_form_btn_confirm_Sent') ??
                                        '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                onTap: () {
                                  Uint8List imageUnit8;
                                  imageUnit8 = _image.readAsBytesSync();
                                  String fileExt = _image.path.split('.').last;
                                  String encodedImage =
                                      'data:image/$fileExt;base64,${base64Encode(imageUnit8)}';
                                  print('ini Iimagenya : ${encodedImage}');
                                  // Navigator.pop(context);
                                  setState(() {
                                    visibilityBtn = false;
                                  });
                                  postCMMForm(context, encodedImage,
                                      angkaStandCtrl.text);
                                },
                              ),
                            )
                          ],
                        ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<CMMFormModel> postCMMForm(
      BuildContext context, String foto, String stand) async {
    String customerID;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerID = prefs.getString('customer_id');
    String accessToken = prefs.getString('access_token');
    print('INI STANDNYA $stand');
    // var body = json.encode({
    //   'customer_id': '005',
    //   'photo': [foto],
    //   'stand': stand,
    // });
    var responsePostCMMForm =
        await http.post('https://devapi-mobile.pgn.co.id/v2/giore', headers: {
      'Authorization': 'Bearer $accessToken',
      // 'Authorization': 'Bearer 0Dz4C3O9flOerWWYUaFFFQXYbwKr9tlHc60k4MVa '
    }, body: {
      // 'customer_id': customerID,
      'photo[]': foto,
      'stand': stand,
    });
    // print('BODY YANG DIRIKIM POST FORM : ${body}');
    print('Hasil POST FORM : ${responsePostCMMForm.body}');
    CMMFormModel cmmFormModel =
        CMMFormModel.fromJson(json.decode(responsePostCMMForm.body));

    // if (responsePostCMMForm.statusCode == 200) {
    allertFormCMM(context, cmmFormModel.message, cmmFormModel.response);
    // }
    return cmmFormModel;
  }

  Future<bool> allertFormCMM(
      BuildContext context, String message, bool response) {
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
          color: response != false ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold),
    );
    return Alert(
      context: context,
      style: alertStyle,
      title: "Info",
      content: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            message,
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
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
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
