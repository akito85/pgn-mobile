import 'package:flutter/material.dart';

class RegistResidential extends ChangeNotifier {
  String province_id,
      province_name,
      townID,
      townName,
      districtId,
      districtName,
      villageId,
      villageName,
      buildingTypeId,
      buildingTypeName,
      buildingConditionName,
      buildingCOnditionId,
      secIndustriId,
      secIndustriName,
      buildingTypeIdBisnis,
      buildingTypeNameBisnis,
      ownershipName,
      ownershipId,
      tabungName3,
      tabungVal3,
      tabungName12,
      tabungVal12,
      tabungName50,
      tabungVal50,
      mTanahName,
      mTanahVal,
      gasBumiName,
      gasBumiVal,
      komName1,
      komVal1,
      komName2,
      komVal2,
      komName3,
      komVal3,
      komName4,
      komVal4,
      ovenName,
      ovenVal,
      dGasName,
      dGasVal,
      watHeatName,
      watHeatVal,
      jBahanBakarBisnisName,
      jenisBahanBakarBisnisId,
      powerInstalId,
      powerInstalVal,
      label;

  void province({String provinceId, String provinceName}) {
    this.province_id = provinceId;
    this.province_name = provinceName;
  }

  void city({String townID, String townName}) {
    this.townID = townID;
    this.townName = townName;
  }

  void districts({String districtId, String districtName}) {
    this.districtId = districtId;
    this.districtName = districtName;
  }

  void villages({String villageId, String villageName}) {
    this.villageId = villageId;
    this.villageName = villageName;
  }

  void buildingType({String buildingTypeId, String buildingTypeName}) {
    this.buildingTypeId = buildingTypeId;
    this.buildingTypeName = buildingTypeName;
  }

  void buildingTypeBisnis(
      {String buildingTypeIdBisnis, String buildingTypeNameBisnis}) {
    this.buildingTypeIdBisnis = buildingTypeIdBisnis;
    this.buildingTypeNameBisnis = buildingTypeNameBisnis;
  }

  void ownership({String ownershipName, String ownershipId}) {
    this.ownershipId = ownershipId;
    this.ownershipName = ownershipName;
  }

  void secIndustri({String secIndustriName, String secIndustriId}) {
    this.secIndustriId = secIndustriId;
    this.secIndustriName = secIndustriName;
  }

  void penggunaan(
      {String tabungName3,
      String tabungVal3,
      String tabungName12,
      String tabungVal12,
      String tabungName50,
      String tabungVal50,
      String mTanahName,
      String mTanahVal,
      String gasBumiName,
      String gasBumiVal}) {
    this.tabungName3 = tabungName3;
    this.tabungVal3 = tabungVal3;
    this.tabungName12 = tabungName12;
    this.tabungVal12 = tabungVal12;
    this.tabungName50 = tabungName50;
    this.tabungVal50 = tabungVal50;
    this.mTanahName = mTanahName;
    this.mTanahVal = mTanahVal;
    this.gasBumiName = gasBumiName;
    this.gasBumiVal = gasBumiVal;
  }

  void jenisBahanBakar(
      {String komName1,
      String komVal1,
      String komName2,
      String komVal2,
      String komName3,
      String komVal3,
      String komName4,
      String komVal4,
      String ovenName,
      String ovenVal,
      String dGasName,
      String dGasVal,
      String watHeatName,
      String watHeatVal}) {
    this.komName1 = komName1;
    this.komVal1 = komVal1;
    this.komName2 = komName2;
    this.komVal2 = komVal2;
    this.komName3 = komName3;
    this.komVal3 = komVal3;
    this.komName4 = komName4;
    this.komVal4 = komVal4;
    this.ovenName = ovenName;
    this.ovenVal = ovenVal;
    this.dGasName = dGasName;
    this.dGasVal = dGasVal;
    this.watHeatName = watHeatName;
    this.watHeatVal = watHeatVal;
  }

  void jenisBahanBakarBisnis(
      {String jBahanBakarBisnisName,
      String jBahanBakarBisnisId,
      String label}) {
    this.jBahanBakarBisnisName = jBahanBakarBisnisName;
    this.jenisBahanBakarBisnisId = jBahanBakarBisnisId;
    this.label = label;
  }

  void electryPowerInstal({String powerInstalId, String powerInstalVal}) {
    this.powerInstalId = powerInstalId;
    this.powerInstalVal = powerInstalVal;
  }
}

// class Calculators extends ChangeNotifier{
//   String oneValConv, twoValConv, triHintConv, fourHintConv, fiveHintConv, sixHintVal, sevenHIntConv,
//   eightHintConv;

//   void conversion({String oneValConv, String twoValConv, String triHintConv, String fourHintConv, String fiveHintConv,
//   String sixHintVal, String sevenHIntConv, String eightHintConv}){
//     this.oneValConv = oneValConv;
//     this.twoValConv = twoValConv;
//     this.triHintConv = triHintConv;
//     this.fourHintConv = fourHintConv;
//     this.fiveHintConv = fiveHintConv;
//     this.sixHintVal = sixHintVal;
//     this.sevenHIntConv = sevenHIntConv;
//     this.eightHintConv = eightHintConv;
//   }
// }
