import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/models/cm_visit_response.dart';
import 'package:pgn_mobile/models/cust_list_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:path_provider/path_provider.dart';

class CMVisitForm extends StatefulWidget {
  CMVisitForm(
      {this.id,
      this.dateEdit,
      this.activity,
      this.visitType,
      this.activityDesc,
      this.customerName,
      this.customerId,
      this.contactPerson,
      this.address,
      this.phoneNumber,
      this.emailAddress,
      this.report,
      this.photo1,
      this.photo2,
      this.photo3});

  final String id;
  final String dateEdit;
  final String activity;
  final String visitType;
  final String activityDesc;
  final String customerName;
  final String customerId;
  final String contactPerson;
  final String address;
  final String phoneNumber;
  final String emailAddress;
  final String report;
  final String photo1;
  final String photo2;
  final String photo3;

  @override
  _CMVisitFormState createState() => _CMVisitFormState(
      id,
      dateEdit,
      activity,
      visitType,
      activityDesc,
      customerName,
      customerId,
      contactPerson,
      address,
      phoneNumber,
      emailAddress,
      report,
      photo1,
      photo2,
      photo3);
}

class _CMVisitFormState extends State<CMVisitForm> {
  ProgressDialog progressDialog;
  String id;
  String dateEdit;
  String activityEdit;
  String visitTypeEdit;
  String activityDescEdit;
  String customerNameEdit;
  String customerIdEdit;
  String contactPersonEdit;
  String addressEdit;
  String phoneNumberEdit;
  String emailAddressEdit;
  String reportEdit;
  String photo1;
  String photo2;
  String photo3;
  _CMVisitFormState(
      this.id,
      this.dateEdit,
      this.activityEdit,
      this.visitTypeEdit,
      this.activityDescEdit,
      this.customerNameEdit,
      this.customerIdEdit,
      this.contactPersonEdit,
      this.addressEdit,
      this.phoneNumberEdit,
      this.emailAddressEdit,
      this.reportEdit,
      this.photo1,
      this.photo2,
      this.photo3);
  String valueChoose;
  String activityChoose;
  String filePath1;
  String filePath2;
  String filePath3;

  List listVisitTypes = [
    "Online",
    "Visit",
    "WhatsApp",
  ];
  List listActivity = [
    "Penanganan Keluhan Pelanggan",
    "Perjanjian Jual Beli Gas",
    "Produk dan Layanan",
    "Tagihan dan Jaminan Pembayaran",
    "Pengendalian Pemakaian Gas (Kuota)",
    "Keinstalasian",
    "Evaluasi Kapasitas Meter",
    "Lainnya"
  ];

  bool isVisibleDate = false;
  bool isVisibleVisitType = false;
  bool isVisibleActivity = false;
  bool isVisibleActivityDescription = false;
  bool isVisibleCustomerName = false;
  bool isVisibleCustomerId = false;
  bool isVisibleAddress = false;
  bool isVisiblePhoneNumber = false;
  bool isVisibleCustomerEmail = false;
  bool isVisibleReports = false;

  TextEditingController dateSelected = new TextEditingController();
  TextEditingController visitType = new TextEditingController();
  TextEditingController activity = new TextEditingController();
  TextEditingController activityDescription = new TextEditingController();
  TextEditingController customerName = new TextEditingController();
  TextEditingController customerId = new TextEditingController();
  TextEditingController contactPerson = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController emailAddress = new TextEditingController();
  TextEditingController reports = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File _image;
  File _image2;
  File _image3;

  List<DataListCust> list = <DataListCust>[];

  @override
  void initState() {
    if (dateEdit != null) {
      dateSelected.value = new TextEditingController.fromValue(
              new TextEditingValue(text: dateEdit))
          .value;
    } else {
      _getTime();
    }
    if (activityEdit != null) {
      activityChoose = activityEdit;
    }
    if (visitTypeEdit != null) {
      valueChoose = visitTypeEdit;
    }
    if (activityDescEdit != null) {
      activityDescription.value = new TextEditingController.fromValue(
              new TextEditingValue(text: activityDescEdit))
          .value;
    }
    if (customerNameEdit != null) {
      customerName.value = new TextEditingController.fromValue(
              new TextEditingValue(text: customerNameEdit))
          .value;
    }
    if (customerIdEdit != null) {
      customerId.value = new TextEditingController.fromValue(
              new TextEditingValue(text: customerIdEdit))
          .value;
    }
    if (contactPersonEdit != null) {
      contactPerson.value = new TextEditingController.fromValue(
              new TextEditingValue(text: contactPersonEdit))
          .value;
    }
    if (addressEdit != null) {
      address.value = new TextEditingController.fromValue(
              new TextEditingValue(text: addressEdit))
          .value;
    }
    if (emailAddressEdit != null) {
      emailAddress.value = new TextEditingController.fromValue(
              new TextEditingValue(text: emailAddressEdit))
          .value;
    }
    if (phoneNumberEdit != null) {
      phoneNumber.value = new TextEditingController.fromValue(
              new TextEditingValue(
                  text: phoneNumberEdit.startsWith("+62")
                      ? phoneNumberEdit.substring(3)
                      : phoneNumberEdit))
          .value;
    }
    if (reportEdit != null) {
      reports.value = new TextEditingController.fromValue(
              new TextEditingValue(text: reportEdit))
          .value;
    }
    if (photo1 != "") {
      _createFileFromString1(photo1);
    }
    if (photo2 != "") {
      _createFileFromString2(photo2);
    }
    if (photo3 != "") {
      _createFileFromString3(photo3);
    }
    fetchPost(context);
    super.initState();
  }

  final picker = ImagePicker();
  Future getImage(String title, String images) async {
    ImageSource imageSource;
    if (title == 'Camera') {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }
    if (images == '1') {
      final pickedFile = await picker.getImage(
          source: imageSource,
          maxWidth: 100,
          maxHeight: 100,
          imageQuality: 100);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } else if (images == '2') {
      final pickedFile = await picker.getImage(
          source: imageSource,
          maxWidth: 100,
          maxHeight: 100,
          imageQuality: 100);
      setState(() {
        if (pickedFile != null) {
          _image2 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } else if (images == '3') {
      final pickedFile = await picker.getImage(
          source: imageSource,
          maxWidth: 100,
          maxHeight: 100,
          imageQuality: 100);
      setState(() {
        if (pickedFile != null) {
          _image3 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
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
        dateSelected.text = new DateFormat('dd MMMM yyy').format(d);
      });
  }

  void _getTime() {
    final String formattedDateTime =
        DateFormat('dd MMMM yyy').format(DateTime.now()).toString();
    setState(() {
      dateSelected.value = new TextEditingController.fromValue(
              new TextEditingValue(text: formattedDateTime))
          .value;
    });
  }

  void _setValidation() {
    if (dateSelected.text == "") {
      setState(() {
        isVisibleVisitType = false;
        isVisibleDate = true;
        isVisibleActivity = false;
        isVisibleActivityDescription = false;
        isVisibleAddress = false;
        isVisibleCustomerId = false;
        isVisibleCustomerName = false;
        isVisiblePhoneNumber = false;
        isVisibleCustomerEmail = false;
        isVisibleReports = false;
      });
    } else if (valueChoose == "") {
      setState(() {
        isVisibleVisitType = true;
        isVisibleDate = false;
        isVisibleActivity = false;
        isVisibleActivityDescription = false;
        isVisibleAddress = false;
        isVisibleCustomerId = false;
        isVisibleCustomerName = false;
        isVisiblePhoneNumber = false;
        isVisibleCustomerEmail = false;
        isVisibleReports = false;
      });
    } else if (activityChoose == "") {
      setState(() {
        isVisibleVisitType = false;
        isVisibleDate = false;
        isVisibleActivity = true;
        isVisibleActivityDescription = false;
        isVisibleAddress = false;
        isVisibleCustomerId = false;
        isVisibleCustomerName = false;
        isVisiblePhoneNumber = false;
        isVisibleCustomerEmail = false;
        isVisibleReports = false;
      });
    } else if (activityDescription.text == "") {
      setState(() {
        isVisibleVisitType = false;
        isVisibleDate = false;
        isVisibleActivity = false;
        isVisibleActivityDescription = true;
        isVisibleAddress = false;
        isVisibleCustomerId = false;
        isVisibleCustomerName = false;
        isVisiblePhoneNumber = false;
        isVisibleCustomerEmail = false;
        isVisibleReports = false;
      });
    } else if (customerId.text == "") {
      setState(() {
        isVisibleVisitType = false;
        isVisibleDate = false;
        isVisibleActivity = false;
        isVisibleActivityDescription = false;
        isVisibleAddress = false;
        isVisibleCustomerId = true;
        isVisibleCustomerName = false;
        isVisiblePhoneNumber = false;
        isVisibleCustomerEmail = false;
        isVisibleReports = false;
      });
    } else if (address.text == "") {
      setState(() {
        isVisibleVisitType = false;
        isVisibleDate = false;
        isVisibleActivity = false;
        isVisibleActivityDescription = false;
        isVisibleAddress = true;
        isVisibleCustomerId = false;
        isVisibleCustomerName = false;
        isVisiblePhoneNumber = false;
        isVisibleCustomerEmail = false;
        isVisibleReports = false;
      });
    } else if (phoneNumber.text == "") {
      setState(() {
        isVisibleVisitType = false;
        isVisibleDate = false;
        isVisibleActivity = false;
        isVisibleActivityDescription = false;
        isVisibleAddress = false;
        isVisibleCustomerId = false;
        isVisibleCustomerName = false;
        isVisiblePhoneNumber = true;
        isVisibleCustomerEmail = false;
        isVisibleReports = false;
      });
    } else if (emailAddress.text == "") {
      setState(() {
        isVisibleVisitType = false;
        isVisibleDate = false;
        isVisibleActivity = false;
        isVisibleActivityDescription = false;
        isVisibleAddress = false;
        isVisibleCustomerId = false;
        isVisibleCustomerName = false;
        isVisiblePhoneNumber = false;
        isVisibleCustomerEmail = true;
        isVisibleReports = false;
      });
    } else if (reports.text == "") {
      setState(() {
        isVisibleVisitType = false;
        isVisibleDate = false;
        isVisibleActivity = false;
        isVisibleActivityDescription = false;
        isVisibleAddress = false;
        isVisibleCustomerId = false;
        isVisibleCustomerName = false;
        isVisiblePhoneNumber = false;
        isVisibleCustomerEmail = false;
        isVisibleReports = true;
      });
    } else {
      _showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    return Scaffold(
      key: _scaffoldKey,
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
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                          controller: dateSelected,
                          enabled: false,
                          autocorrect: true,
                          style: TextStyle(height: 1, fontSize: 14),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Color(0xFF455055)),
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.black87,
                            ),
                            filled: true,
                            fillColor: Colors.white70,
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3), width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 2)),
                          ),
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                    ),
                    Visibility(
                      visible: isVisibleDate,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 8),
                        child: Text('Date cannot be empty',
                            style: TextStyle(
                                color: Color(0xFFDD1818),
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Color(0xFFD3D3D3), width: 2)),
                        child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 8),
                            child: DropdownButton(
                                hint: Text('Site/Business Visit',
                                    style: TextStyle(
                                        color: Color(0xFF455055),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.keyboard_arrow_down,
                                    color: Color(0xFF455055)),
                                isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(
                                    color: Color(0xFF455055),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                                value: valueChoose,
                                onChanged: (newValue) {
                                  setState(() {
                                    valueChoose = newValue;
                                  });
                                },
                                items: listVisitTypes.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList()))),
                    Visibility(
                      visible: isVisibleVisitType,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 8),
                        child: Text('Visit Type cannot be empty',
                            style: TextStyle(
                                color: Color(0xFFDD1818),
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Color(0xFFD3D3D3), width: 2)),
                        child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 8),
                            child: DropdownButton(
                                hint: Text('Customer Complaint Handling',
                                    style: TextStyle(
                                        color: Color(0xFF455055),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.keyboard_arrow_down,
                                    color: Color(0xFF455055)),
                                isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(
                                    color: Color(0xFF455055),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                                value: activityChoose,
                                onChanged: (newValue) {
                                  setState(() {
                                    activityChoose = newValue;
                                  });
                                },
                                items: listActivity.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList()))),
                    Visibility(
                      visible: isVisibleActivity,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 8),
                        child: Text('Activity cannot be empty',
                            style: TextStyle(
                                color: Color(0xFFDD1818),
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
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
                        child: TextFormField(
                          controller: activityDescription,
                          minLines: 6,
                          maxLines: 10,
                          autocorrect: true,
                          style: TextStyle(height: 1, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Activity Description',
                            filled: true,
                            fillColor: Colors.white70,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3), width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 2)),
                          ),
                        )),
                    Visibility(
                      visible: isVisibleActivityDescription,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 8),
                        child: Text('Activity description cannot be empty',
                            style: TextStyle(
                                color: Color(0xFFDD1818),
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
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
                    _buildAutoComplate(context),
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
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: customerId,
                          autocorrect: true,
                          style: TextStyle(height: 1, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Customer ID',
                            filled: true,
                            fillColor: Colors.white70,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3), width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 2)),
                          ),
                        )),
                    Visibility(
                      visible: isVisibleCustomerId,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 8),
                        child: Text('Costumer ID cannot be empty',
                            style: TextStyle(
                                color: Color(0xFFDD1818),
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
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
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: contactPerson,
                          autocorrect: true,
                          style: TextStyle(height: 1, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Contact person name',
                            filled: true,
                            fillColor: Colors.white70,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3), width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 2)),
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
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: address,
                          autocorrect: true,
                          style: TextStyle(height: 1, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Enter Your Address',
                            filled: true,
                            fillColor: Colors.white70,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3), width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 2)),
                          ),
                        )),
                    Visibility(
                      visible: isVisibleAddress,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 8),
                        child: Text('Address cannot be empty',
                            style: TextStyle(
                                color: Color(0xFFDD1818),
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
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
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          minLines: 1,
                          maxLines: 10,
                          controller: phoneNumber,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3), width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 2)),
                          ),
                        )),
                    Visibility(
                      visible: isVisiblePhoneNumber,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 8),
                        child: Text('Incorect Phone Number',
                            style: TextStyle(
                                color: Color(0xFFDD1818),
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
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
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          minLines: 1,
                          maxLines: 10,
                          controller: emailAddress,
                          autocorrect: true,
                          style: TextStyle(height: 1, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            filled: true,
                            fillColor: Colors.white70,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3), width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 2)),
                          ),
                        )),
                    Visibility(
                      visible: isVisibleCustomerEmail,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 8),
                        child: Text('Incorect Email Address',
                            style: TextStyle(
                                color: Color(0xFFDD1818),
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
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
                        child: TextFormField(
                          minLines: 5,
                          maxLines: 10,
                          controller: reports,
                          autocorrect: true,
                          style: TextStyle(height: 1, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Reports',
                            filled: true,
                            fillColor: Colors.white70,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3), width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 2)),
                          ),
                        )),
                    Visibility(
                      visible: isVisibleReports,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 8),
                        child: Text('Reports cannot be empty',
                            style: TextStyle(
                                color: Color(0xFFDD1818),
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: FileImage(_image),
                                              fit: BoxFit.fill)),
                                      child: Container(
                                          width: 20,
                                          height: 20,
                                          child: new FloatingActionButton(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.5),
                                            onPressed: () {
                                              _showialogDeleteImage(
                                                  context, "1");
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
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Container(
                                          width: 20,
                                          height: 20,
                                          child: new FloatingActionButton(
                                            onPressed: () {
                                              dialogChoosePic(context, '1');
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: FileImage(_image2),
                                              fit: BoxFit.fill)),
                                      child: Container(
                                          width: 20,
                                          height: 20,
                                          child: new FloatingActionButton(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.5),
                                            onPressed: () {
                                              _showialogDeleteImage(
                                                  context, "2");
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
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Container(
                                          width: 20,
                                          height: 20,
                                          child: new FloatingActionButton(
                                            onPressed: () {
                                              dialogChoosePic(context, '2');
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: FileImage(_image3),
                                              fit: BoxFit.fill)),
                                      child: Container(
                                          width: 20,
                                          height: 20,
                                          child: new FloatingActionButton(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.5),
                                            onPressed: () {
                                              _showialogDeleteImage(
                                                  context, "3");
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
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Container(
                                          width: 20,
                                          height: 20,
                                          child: new FloatingActionButton(
                                            onPressed: () {
                                              dialogChoosePic(context, '3');
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
                                  _setValidation();
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

  Widget dialogChoosePic(BuildContext context, String images) {
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
                  getImage('Camera', images);
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
                  getImage('Gallery', images);
                },
              )
            ],
          ),
        );
      },
    );
  }

  void _showialogDeleteImage(BuildContext context, String images) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
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
                              if (images == "1") {
                                setState(() {
                                  _image = null;
                                });
                              } else if (images == "2") {
                                setState(() {
                                  _image2 = null;
                                });
                              } else if (images == "3") {
                                setState(() {
                                  _image3 = null;
                                });
                              }
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

  void _showAlertDialog(BuildContext context) {
    showDialog(
        context: _scaffoldKey.currentContext,
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
                              progressDialog.show();
                              var date = DateFormat("d MMMM yyyy")
                                  .parse(dateSelected.text);
                              var finalDate =
                                  DateFormat("yyyy-MM-dd").format(date);
                              Uint8List imageUnit8;
                              Uint8List imageUnit82;
                              Uint8List imageUnit83;
                              imageUnit8 = _image.readAsBytesSync();
                              String fileExt1 = _image.path.split('.').last;
                              imageUnit82 = _image2.readAsBytesSync();
                              String fileExt2 = _image2.path.split('.').last;
                              imageUnit83 = _image3.readAsBytesSync();
                              String fileExt3 = _image3.path.split('.').last;
                              String encodeImage1 =
                                  'data:image/$fileExt1;base64,${base64Encode(imageUnit8)}';
                              String encodeImage2 =
                                  'data:image/$fileExt2;base64,${base64Encode(imageUnit82)}';
                              String encodeImage3 =
                                  'data:image/$fileExt3;base64,${base64Encode(imageUnit83)}';
                              if (id != null) {
                                postCmVisitEdit(
                                    context,
                                    finalDate,
                                    visitTypeChoose(),
                                    chooseActivity(),
                                    activityDescription.text,
                                    customerName.text,
                                    customerId.text,
                                    contactPerson.text,
                                    address.text,
                                    '+62' + phoneNumber.text,
                                    emailAddress.text,
                                    reports.text,
                                    encodeImage1,
                                    encodeImage2,
                                    encodeImage3);
                              } else {
                                postCmVisit(
                                    context,
                                    finalDate,
                                    visitTypeChoose(),
                                    chooseActivity(),
                                    activityDescription.text,
                                    customerName.text,
                                    customerId.text,
                                    contactPerson.text,
                                    address.text,
                                    '+62' + phoneNumber.text,
                                    emailAddress.text,
                                    reports.text,
                                    encodeImage1,
                                    encodeImage2,
                                    encodeImage3);
                              }
                            }))
                  ],
                ))
              ],
            ),
          ));
        });
  }

  Widget _buildAutoComplate(BuildContext context) {
    return Autocomplete<DataListCust>(
      optionsBuilder: (TextEditingValue value) {
        return list
            .where((DataListCust cust) =>
                cust.name.toLowerCase().startsWith(value.text.toLowerCase()))
            .toList();
      },
      displayStringForOption: (DataListCust option) => option.name,
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        customerNameEdit != null
            ? fieldTextEditingController.value =
                TextEditingController.fromValue(
                        new TextEditingValue(text: customerName.text))
                    .value
            : print('selected ${customerName.text}');
        return TextFormField(
          minLines: 1,
          maxLines: 10,
          autocorrect: true,
          focusNode: fieldFocusNode,
          controller: fieldTextEditingController,
          style: TextStyle(height: 1, fontSize: 14),
          decoration: InputDecoration(
            hintText: 'Enter customer name',
            filled: true,
            fillColor: Colors.white70,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Color(0xFFD3D3D3), width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black38, width: 2)),
          ),
        );
      },
      onSelected: (DataListCust selection) {
        setState(() {
          selection.name != null || selection.name != ""
              ? customerName.value = TextEditingController.fromValue(
                      new TextEditingValue(text: selection.name))
                  .value
              : print('selected ${selection.name}');
          selection.id != null || selection.id != ""
              ? customerId.value = new TextEditingController.fromValue(
                      new TextEditingValue(text: selection.id))
                  .value
              : print('selected ${selection.id}');
          selection.cPersonName != null || selection.cPersonName != ""
              ? contactPerson.value = new TextEditingController.fromValue(
                      new TextEditingValue(text: selection.cPersonName))
                  .value
              : print('selected ${selection.cPersonName}');
          selection.address != null || selection.address != ""
              ? address.value = new TextEditingController.fromValue(
                      new TextEditingValue(text: selection.address))
                  .value
              : print('selected ${selection.address}');
          selection.cPersonMobPhone != null || selection.cPersonMobPhone != ""
              ? phoneNumber.value = new TextEditingController.fromValue(
                      new TextEditingValue(
                          text: selection.cPersonMobPhone.startsWith("+62")
                              ? selection.cPersonMobPhone.substring(3)
                              : selection.cPersonMobPhone))
                  .value
              : print('selected ${selection.cPersonMobPhone}');
          selection.cPersonEmail != null || selection.cPersonEmail != ""
              ? emailAddress.value = new TextEditingController.fromValue(
                      new TextEditingValue(text: selection.cPersonEmail))
                  .value
              : print('selected ${selection.cPersonEmail}');
        });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<DataListCust> onSelected,
          Iterable<DataListCust> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 2,
            child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 200,
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.all(2),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DataListCust option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                          title: Text(option.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))),
                    );
                  },
                )),
          ),
        );
      },
    );
  }

  Future<CmVisitReponse> postCmVisit(
      BuildContext context,
      String visitDate,
      String visitType,
      String activityType,
      String activityDesc,
      String customerName,
      String customerId,
      String cpName,
      String cpAddress,
      String cpPhone,
      String cpEmail,
      String report,
      String foto1,
      String foto2,
      String foto3) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');

    var responsePostCmVisitForm =
        await http.post('${UrlCons.mainDevUrl}cm-visit', headers: {
      'Authorization': 'Bearer $accessToken'
    }, body: {
      'visit_date': visitDate,
      'visit_type': visitType,
      'activity_type': activityType,
      'customer_name': customerName,
      'customer_id': customerId,
      'activity_description': activityDesc,
      'cp_name': cpName,
      'cp_address': cpAddress,
      'cp_phone': cpPhone,
      'cp_email': cpEmail,
      'report': report,
      'images[0]': foto1,
      'images[1]': foto2,
      'images[2]': foto3
    });
    print('status code' + responsePostCmVisitForm.statusCode.toString());
    if (responsePostCmVisitForm.statusCode == 200) {
      setState(() {
        progressDialog.hide();
        _showDialogSuccessSubmit(context);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(_scaffoldKey.currentContext);
          Navigator.pushReplacementNamed(
              _scaffoldKey.currentContext, '/cmVisit');
        });
      });
    } else {
      setState(() {
        progressDialog.hide();
        print('responsebody' + responsePostCmVisitForm.body.trim().toString());
      });
    }
    return CmVisitReponse.fromJson(json.decode(responsePostCmVisitForm.body));
  }

  Future<CmVisitReponse> postCmVisitEdit(
      BuildContext context,
      String visitDate,
      String visitType,
      String activityType,
      String activityDesc,
      String customerName,
      String customerId,
      String cpName,
      String cpAddress,
      String cpPhone,
      String cpEmail,
      String report,
      String foto1,
      String foto2,
      String foto3) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');

    var responsePostCmVisitForm =
        await http.post('${UrlCons.mainDevUrl}cm-visit/$id', headers: {
      'Authorization': 'Bearer $accessToken'
    }, body: {
      'visit_date': visitDate,
      'visit_type': visitType,
      'activity_type': activityType,
      'customer_name': customerName,
      'customer_id': customerId,
      'activity_description': activityDesc,
      'cp_name': cpName,
      'cp_address': cpAddress,
      'cp_phone': cpPhone,
      'cp_email': cpEmail,
      'report': report,
      'images[0]': foto1,
      'images[1]': foto2,
      'images[2]': foto3
    });
    print('status code' + responsePostCmVisitForm.statusCode.toString());
    if (responsePostCmVisitForm.statusCode == 200) {
      setState(() {
        progressDialog.hide();
        _showDialogSuccessSubmit(context);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(_scaffoldKey.currentContext);
          Navigator.pushReplacementNamed(
              _scaffoldKey.currentContext, '/cmVisit');
        });
      });
    } else {
      setState(() {
        progressDialog.hide();
        print('responsebody' + responsePostCmVisitForm.body.trim().toString());
      });
    }
    return CmVisitReponse.fromJson(json.decode(responsePostCmVisitForm.body));
  }

  void _showDialogSuccessSubmit(BuildContext context) {
    showDialog(
        context: _scaffoldKey.currentContext,
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

  Future<CustListModel> fetchPost(BuildContext context) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var respose = await http.get('${UrlCons.mainProdUrl}customers', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });
    CustListModel getListCust =
        CustListModel.fromJson(json.decode(respose.body));
    setState(() {
      list.addAll(getListCust.data);
    });
    return CustListModel.fromJson(json.decode(respose.body));
  }

  String visitTypeChoose() {
    switch (valueChoose) {
      case "Online":
        return "1";
        break;
      case "Visit":
        return "2";
        break;
      case "WhatsApp":
        return "3";
        break;
      default:
        return "";
    }
  }

  String chooseActivity() {
    switch (activityChoose) {
      case "Penanganan Keluhan Pelanggan":
        return "1";
        break;
      case "Perjanjian Jual Beli Gas":
        return "2";
        break;
      case "Produk dan Layanan":
        return "3";
        break;
      case "Tagihan dan Jaminan Pembayaran":
        return "4";
        break;
      case "Pengendalian Pemakaian Gas (Kuota)":
        return "5";
        break;
      case "Keinstalasian":
        return "6";
        break;
      case "Evaluasi Kapasitas Meter":
        return "7";
        break;
      case " Lainnya":
        return "8";
        break;
    }
  }

  Future<String> _createFileFromString1(String foto) async {
    final encodedStr = foto.split(',');
    Uint8List bytes = base64.decode(encodedStr[1]);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpeg");
    await file.writeAsBytes(bytes);
    _image = File(file.path);
    return file.path;
  }

  Future<String> _createFileFromString2(String foto) async {
    final encodedStr = foto.split(',');
    Uint8List bytes = base64.decode(encodedStr[1]);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpeg");
    await file.writeAsBytes(bytes);
    _image2 = File(file.path);
    return file.path;
  }

  Future<String> _createFileFromString3(String foto) async {
    final encodedStr = foto.split(',');
    Uint8List bytes = base64.decode(encodedStr[1]);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpeg");
    await file.writeAsBytes(bytes);
    _image3 = File(file.path);
    return file.path;
  }
}
