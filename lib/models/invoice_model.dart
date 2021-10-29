import 'down_usage_detail_model.dart';

class InvoiceModel {
  List<CustModel> data;
  MetaData metaData;

  InvoiceModel({this.data, this.metaData});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    if (json['PGNCRMCustPaymentDBOutput'] != null) {
      return InvoiceModel(
          data: parseCustModel(json['PGNCRMCustPaymentDBOutput']));
    } else {
      return InvoiceModel(metaData: json['meta']);
    }
  }

  static List<CustModel> parseCustModel(dataJson) {
    var list = dataJson as List;
    List<CustModel> datas =
        list.map((data) => CustModel.fromJson(data)).toList();
    return datas;
  }
}

class CustModel {
  final String areaId;
  final String custNumber;
  final String payDate;
  final String payCurrCode;
  final String productId;
  final int payAmt;
  final String payChannelId;
  final String payFlag;
  final String opFlag;
  final String bank;
  final String ca;
  final String payNum;
  final String paymentStatus;

  CustModel(
      {this.areaId,
      this.custNumber,
      this.payDate,
      this.payCurrCode,
      this.productId,
      this.payAmt,
      this.payChannelId,
      this.payFlag,
      this.opFlag,
      this.bank,
      this.ca,
      this.payNum,
      this.paymentStatus});

  factory CustModel.fromJson(Map<String, dynamic> json) {
    return CustModel(
        areaId: json['CUST_AREA_ID'],
        custNumber: json['CUST_NUMBER'],
        payDate: json['PAY_DATE'],
        payCurrCode: json['PAY_CURR_CODE'],
        productId: json['PRODUCT_ID'],
        payAmt: json['PAY_AMT'],
        payChannelId: json['PAY_CHANNEL_ID'],
        payFlag: json['PAY_FLG'],
        opFlag: json['OP_FLG'],
        bank: json['BANK'],
        ca: json['CA'],
        payNum: json['PAY_NUM'],
        paymentStatus: json['PAYMENT_STATUS']);
  }
}
