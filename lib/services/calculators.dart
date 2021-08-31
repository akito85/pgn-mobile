import 'package:flutter/material.dart';

class CalculatorsEnergy extends ChangeNotifier{
  String oneValConv, twoValConv, triHintConv, fourHintConv, fiveHintConv, sixHintVal, sevenHIntConv,
  eightHintConv, oneUnit, twoUnit, triUnit, fourUnit, fiveUnit, sixUnit, sevenUnit, eightUnit,
  oneBoiValConv, twoBoiValConv, triBoiHintConv, fourBoiHintConv, fiveBoiHintConv, sixBoiHintVal, sevenBoiHIntConv,
  eightBoiHintConv, oneBoiUnit, twoBoiUnit, triBoiUnit, fourBoiUnit, fiveBoiUnit, sixBoiUnit, sevenBoiUnit, eightBoiUnit, 
  oneLisVal, eightLisVal, nineListVal, tenListVal, nineListUnit, tenListUnit;

  void conversion({String oneValConv, String twoValConv, String triHintConv, String fourHintConv, String fiveHintConv, 
  String sixHintVal, String sevenHIntConv, String oneUnit, String twoUnit, String triUnit, String fourUnit, 
  String fiveUnit, String sixUnit, String sevenUnit, String eightUnit }){
    this.oneValConv = oneValConv;
    this.twoValConv = twoValConv;
    this.triHintConv = triHintConv;
    this.fourHintConv = fourHintConv;
    this.fiveHintConv = fiveHintConv;
    this.sixHintVal = sixHintVal;
    this.sevenHIntConv = sevenHIntConv;
    this.oneUnit = oneUnit;
    this.twoUnit = twoUnit;
    this.triUnit = triUnit;
    this.fourUnit = fourUnit;
    this.fiveUnit = fiveUnit;
    this.sixUnit = sixUnit;
    this.sevenUnit = sevenUnit;
    this.eightUnit = eightUnit;
  }

  void boiler({String oneBoiValConv, String twoBoiValConv, String triBoiHintConv, String fourBoiHintConv, String fiveBoiHintConv, 
  String sixBoiHintVal, String sevenBoiHIntConv, String oneBoiUnit, String twoBoiUnit, String triBoiUnit, String fourBoiUnit, 
  String fiveBoiUnit, String sixBoiUnit, String seveBoinUnit, String eightBoiUnit, String eightBoiHintConv }){
    this.oneBoiValConv = oneBoiValConv;
    this.twoBoiValConv = twoBoiValConv;
    this.triBoiHintConv = triBoiHintConv;
    this.fourBoiHintConv = fourBoiHintConv;
    this.fiveBoiHintConv = fiveBoiHintConv;
    this.sixBoiHintVal = sixBoiHintVal;
    this.sevenBoiHIntConv = sevenBoiHIntConv;
    this.eightBoiHintConv = eightBoiHintConv;
    this.oneBoiUnit = oneBoiUnit;
    this.twoBoiUnit = twoBoiUnit;
    this.triBoiUnit = triBoiUnit;
    this.fourBoiUnit = fourBoiUnit;
    this.fiveBoiUnit = fiveBoiUnit;
    this.sixBoiUnit = sixBoiUnit;
    this.sevenBoiUnit = sevenBoiUnit;
    this.eightBoiUnit = eightBoiUnit;
  }

  void listrict({String oneLisVal ,String eightLisVal, String nineListVal, String tenListVal, 
  String nineListUnit, String tenListUnit}){
    this.eightLisVal = eightLisVal;
    this.nineListVal = nineListVal; 
    this.tenListVal = tenListVal;
    this.nineListUnit = nineListUnit; 
    this.tenListUnit = tenListUnit;
  }
}