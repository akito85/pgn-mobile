class PaymentModel {
  CustModel data;
  String message;
  int code;
  PaymentModel({this.data, this.code, this.message});

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return PaymentModel(data: CustModel.fromJson(json['data']));
    } else {
      return PaymentModel(message: json['message']);
    }
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

//// PAYMENT CONFIRMATION MNG
class MngPaymentModel {
  List<CustModel> data;
  String message;
  int code;
  MngPaymentModel({this.data, this.code, this.message});

  factory MngPaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return MngPaymentModel(
        data: parseDataPayment(json['data']),
      );
    } else {
      return MngPaymentModel(message: json['message']);
    }
  }

  static List<CustModel> parseDataPayment(datasJson) {
    var list = datasJson as List;
    List<CustModel> datasPayment =
        list.map((data) => CustModel.fromJson(data)).toList();
    return datasPayment;
  }
}
