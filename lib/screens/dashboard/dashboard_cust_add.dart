import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

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
                              padding: EdgeInsets.only(top: 15, bottom: 15),
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
}
