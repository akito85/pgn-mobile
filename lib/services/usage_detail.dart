import 'package:flutter/material.dart';

class UsgDetail extends ChangeNotifier{
  String keywoard;

  void usgDetail({String keywoard}){
    this.keywoard = keywoard ?? "-";
  }
}