import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgn_mobile/models/dashboard_customer_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/otp/otp.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DashboardCustAdd extends StatefulWidget {
  @override
  DashboardCustAddState createState() => DashboardCustAddState();
}

class DashboardCustAddState extends State<DashboardCustAdd> {
  TextEditingController custIDCtrl = new TextEditingController();
  File _image;
  File _imageSelfie;
  final picker = ImagePicker();
  Future getImage(String title, String containerImg) async {
    ImageSource imageSource;
    if (title == 'Camera') {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final pickedFile = await picker.getImage(
        source: imageSource, maxWidth: 1000, maxHeight: 1000, imageQuality: 50);
    setState(() {
      if (pickedFile != null && containerImg == 'ktp') {
        _image = File(pickedFile.path);
      } else if (pickedFile != null && containerImg == 'selfie') {
        _imageSelfie = File(pickedFile.path);
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
          'Add new Customer ID',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
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
              children: [
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
                    controller: custIDCtrl,
                    decoration: InputDecoration(
                      labelText: 'Customer ID',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 15),
                        child: Text('Upload KTP'),
                      ),
                      InkWell(
                        onTap: () {
                          dialogChoosePic(context, 'ktp');
                          // getImage();
                        },
                        child: _image != null
                            ? Container(
                                height: 200,
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
                                height: 200,
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
                                      'Upload KTP Photo',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      _image != null
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    dialogChoosePic(context, 'ktp');
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
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin:
                      EdgeInsets.only(top: 10, bottom: 30, left: 10, right: 10),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 15),
                        child: Text('Upload Selfie'),
                      ),
                      InkWell(
                        onTap: () {
                          dialogChoosePic(context, 'selfie');
                          // getImage();
                        },
                        child: _imageSelfie != null
                            ? Container(
                                height: 350,
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                      image: FileImage(_imageSelfie),
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
                      _imageSelfie != null
                          ? Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    dialogChoosePic(context, 'selfie');
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
                      'SENT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Uint8List imageUnit8Ktp;
                      imageUnit8Ktp = _image.readAsBytesSync();
                      String fileExt = _image.path.split('.').last;
                      String encodedImage =
                          'data:image/$fileExt;base64,${base64Encode(imageUnit8Ktp)}';
                      Uint8List imageUnit8Selfie;
                      imageUnit8Selfie = _imageSelfie.readAsBytesSync();
                      String fileExtSelfie = _imageSelfie.path.split('.').last;
                      String encodedImageSelfie =
                          'data:image/$fileExtSelfie;base64,${base64Encode(imageUnit8Selfie)}';
                      createCustId(encodedImage, encodedImageSelfie);
                      // dialogAlertCMMForm(context);
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

  Widget dialogChoosePic(BuildContext context, String containerImg) {
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
                  getImage('Camera', containerImg);
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
                  getImage('Gallery', containerImg);
                },
              )
            ],
          ),
        );
      },
    );
  }

  void createCustId(String encodedImage, String encodedImageSelfie) async {
    final storageCache = new FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var body = json.encode({
      'customer_id': custIDCtrl.text,
      'identity_card_photo': encodedImage,
      'self_photo': encodedImageSelfie
    });
    var responseAddCustId = await http.post(
      '${UrlCons.mainProdUrl}add_customer_id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
      body: body,
    );
    AddNewCustomerID addNewCustomerID =
        AddNewCustomerID.fromJson(json.decode(responseAddCustId.body));
    if (responseAddCustId.statusCode == 200) {
      allertAddCustomerId(
          context,
          addNewCustomerID.dataAddCustomerId.message,
          addNewCustomerID.dataAddCustomerId.custID,
          addNewCustomerID.dataAddCustomerId.custName);
    } else {
      showToast(addNewCustomerID.message);
    }
  }

  Future<bool> allertAddCustomerId(
      BuildContext context, String message, String custId, String custName) {
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
      titleStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
    );
    return Alert(
      context: context,
      style: alertStyle,
      title: "Info",
      content: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            'Customer ID : $custId',
            style: TextStyle(
                color: Color(0xFF707070),
                fontSize: 17,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            'Customer Name : $custName',
            style: TextStyle(
                color: Color(0xFF707070),
                fontSize: 17,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
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
