import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class CMVisitForm extends StatefulWidget {
  @override
  _CMVisitFormState createState() => _CMVisitFormState();
}

class _CMVisitFormState extends State<CMVisitForm> {
  String _onDateSelected = '18 November 2021';
  TextEditingController controllers;
  File _image;
  File _image2;
  File _image3;
  final picker = ImagePicker();
  Future getImage(String title) async {
    ImageSource imageSource;
    if (title == 'Camera') {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final pickedFile = await picker.getImage(
        source: imageSource, maxWidth: 100, maxHeight: 100, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage2(String title) async {
    ImageSource imageSource;
    if (title == 'Camera') {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final pickedFile = await picker.getImage(
        source: imageSource, maxWidth: 100, maxHeight: 100, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage3(String title) async {
    ImageSource imageSource;
    if (title == 'Camera') {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final pickedFile = await picker.getImage(
        source: imageSource, maxWidth: 100, maxHeight: 100, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (d != null)
      setState(() {
        _onDateSelected = new DateFormat('dd MMMM yyy').format(d);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'CM Visit Form',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 12, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text('Date of Visit',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    child: TextFormField(
                      controller: controllers,
                      enabled: false,
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: _onDateSelected,
                        hintStyle: TextStyle(color: Color(0xFF455055)),
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.black87,
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Visit Type',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Site/Business Visit',
                        hintStyle: TextStyle(color: Color(0xFF455055)),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black87,
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Activity',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Customer Complaint Handling',
                        hintStyle: TextStyle(color: Color(0xFF455055)),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black87,
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Activity Description',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      minLines: 6,
                      maxLines: 10,
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Auto expanding text area',
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 16, right: 18, left: 18),
                  child: Divider(color: Color(0xFFF4F4F4)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Customer Name',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      minLines: 1,
                      maxLines: 10,
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Enter customer name',
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Customer ID',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      minLines: 1,
                      maxLines: 10,
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Customer ID',
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Contact Person',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      minLines: 1,
                      maxLines: 10,
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Contact person name',
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Address',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      minLines: 1,
                      maxLines: 10,
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Enter Your Address',
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                //phoneNumber
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Phone Number',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      minLines: 1,
                      maxLines: 10,
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Contact person number',
                        filled: true,
                        fillColor: Colors.white70,
                        prefixIcon: Padding(
                          padding:
                              EdgeInsets.only(right: 16, top: 14, left: 16),
                          child: Text('+62',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Email Address',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      minLines: 1,
                      maxLines: 10,
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 16, right: 18, left: 18),
                  child: Divider(color: Color(0xFFF4F4F4)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4, top: 20),
                  child: Text('Reports',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      minLines: 5,
                      maxLines: 10,
                      autocorrect: true,
                      style: TextStyle(height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Auto expanding text area',
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Color(0xFFD3D3D3), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 2)),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 8, top: 20),
                  child: Text('Documentation',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _image != null
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(40.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: FileImage(_image),
                                          fit: BoxFit.fill)),
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      child: FloatingActionButton(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.5),
                                        onPressed: () {
                                          _showialogDeleteImage(context);
                                        },
                                        elevation: 0,
                                        child: Icon(Icons.delete_outlined,
                                            color: Colors.white, size: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                      )))
                              : Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(40.0),
                                  decoration: DottedDecoration(
                                      shape: Shape.box,
                                      color: Color(0xFF427CEF),
                                      dash: <int>[3, 3],
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          dialogChoosePic(context);
                                        },
                                        elevation: 0,
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                      ))),
                          SizedBox(height: 8),
                          _image != null
                              ? Container(
                                  width: 110.0,
                                  child: Text(_image.path,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)))
                              : Text('Add Image',
                                  style: TextStyle(
                                      color: Color(0xFF427CEF),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _image2 != null
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(40.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: FileImage(_image2),
                                          fit: BoxFit.fill)),
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      child: FloatingActionButton(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.5),
                                        onPressed: () {
                                          _showialogDeleteImage(context);
                                        },
                                        elevation: 0,
                                        child: Icon(Icons.delete_outlined,
                                            color: Colors.white, size: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                      )))
                              : Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(40.0),
                                  decoration: DottedDecoration(
                                      shape: Shape.box,
                                      color: Color(0xFF427CEF),
                                      dash: <int>[3, 3],
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          dialogChoosePic2(context);
                                        },
                                        elevation: 0,
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                      ))),
                          SizedBox(height: 8),
                          _image2 != null
                              ? Container(
                                  width: 110.0,
                                  child: Text(_image2.path,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)))
                              : Text('Add Image',
                                  style: TextStyle(
                                      color: Color(0xFF427CEF),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _image3 != null
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(40.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: FileImage(_image3),
                                          fit: BoxFit.fill)),
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      child: FloatingActionButton(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.5),
                                        onPressed: () {
                                          _showialogDeleteImage(context);
                                        },
                                        elevation: 0,
                                        child: Icon(Icons.delete_outlined,
                                            color: Colors.white, size: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                      )))
                              : Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(40.0),
                                  decoration: DottedDecoration(
                                      shape: Shape.box,
                                      color: Color(0xFF427CEF),
                                      dash: <int>[3, 3],
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          dialogChoosePic3(context);
                                        },
                                        elevation: 0,
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                      ))),
                          SizedBox(height: 8),
                          _image3 != null
                              ? Container(
                                  width: 110.0,
                                  child: Text(_image3.path,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Color(0xFF427CEF),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)))
                              : Text('Add Image',
                                  style: TextStyle(
                                      color: Color(0xFF427CEF),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 34, bottom: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFD3D3D3)),
                        child: MaterialButton(
                            child: Text('Cancel',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        width: 228.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFF427CEF)),
                        child: MaterialButton(
                            child: Text('Save Report',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {
                              _showAlertDialog(context);
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
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
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget dialogChoosePic2(BuildContext context) {
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
                  getImage2('Camera');
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
                  getImage2('Gallery');
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget dialogChoosePic3(BuildContext context) {
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
                  getImage3('Camera');
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
                  getImage3('Gallery');
                },
              )
            ],
          ),
        );
      },
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Container(
          width: MediaQuery.of(context).size.width,
          height: 140.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'CM Visit Form Confirmation',
                  style: TextStyle(
                      color: Color(0xFF427CEF),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24.0),
                child: Text(
                    'Are you sure that the information that you entered is correct?',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0)),
              ),
              Positioned(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 84.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFD3D3D3)),
                    child: MaterialButton(
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Container(
                      width: 170.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF427CEF)),
                      child: MaterialButton(
                          child: Text('Save Report',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }))
                ],
              ))
            ],
          ),
        ));
      });
}

void _showialogDeleteImage(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Text('Delete Image?',
                      style: TextStyle(
                          color: Color(0xFF427CEF),
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
                Positioned(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 125.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFD3D3D3)),
                      child: MaterialButton(
                          child: Text('Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Container(
                      width: 125.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF427CEF)),
                      child: MaterialButton(
                          child: Text('Delete',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ))
              ],
            ),
          ),
        );
      });
}

void _showDialogSuccessSubmit(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: 70.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 70.0,
                  height: 70.0,
                  child: Icon(Icons.check_circle_outline_rounded,
                      color: Color(0xFF81C153), size: 50),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Thank You!',
                          style: TextStyle(
                              color: Color(0xFF81C153),
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text('Your report has been submitted',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
