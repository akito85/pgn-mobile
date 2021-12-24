import 'package:flutter/material.dart';

class CustomerInvoiceResidential {
  List<DataCustInvoiceResidential> data;
  String message;
  CustomerInvoiceResidential({this.data, this.message});

  factory CustomerInvoiceResidential.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return CustomerInvoiceResidential(
        data: parseDataInvoiceResidential(json['data']),
      );
    else
      return CustomerInvoiceResidential(message: json['message']);
  }

  static List<DataCustInvoiceResidential> parseDataInvoiceResidential(
      datasJson) {
    var list = datasJson as List;
    List<DataCustInvoiceResidential> datasInvoice =
        list.map((data) => DataCustInvoiceResidential.fromJson(data)).toList();
    return datasInvoice;
  }
}

class DataCustInvoiceResidential {
  String invoiceId;
  String custInvoiceId;
  String custInvoiceName;
  String custVolUsage;
  String tBillIdr;
  String tBillUsd;
  dynamic availableGuarantee;
  dynamic paymentGuatantee;

  String volumeUsage;
  String volumeNormal;
  String volumeOverUsage;
  dynamic tagihanIDR;
  int isPaid;
  String usagePeriod;
  String invoicePeriod;
  String custInvoicePeriod;
  String type;
  List<CMM> cmm;
  List<Others> others;

  DataCustInvoiceResidential(
      {this.custInvoiceId,
      this.custInvoiceName,
      this.custInvoicePeriod,
      this.custVolUsage,
      this.invoiceId,
      this.invoicePeriod,
      this.isPaid,
      this.tBillIdr,
      this.tBillUsd,
      this.type,
      this.usagePeriod,
      this.availableGuarantee,
      this.paymentGuatantee,
      this.cmm,
      this.tagihanIDR,
      this.volumeNormal,
      this.volumeOverUsage,
      this.volumeUsage,
      this.others});

  factory DataCustInvoiceResidential.fromJson(Map<String, dynamic> json) {
    return DataCustInvoiceResidential(
      invoiceId: json['id'],
      custInvoiceId: json['customer_id'],
      custInvoiceName: json['customer_name'],
      custVolUsage: json['volume_usage'],
      tBillIdr: json['total_bill_idr'],
      tBillUsd: json['total_bill_usd'],
      isPaid: json['is_paid'],
      invoicePeriod: json['period'],
      usagePeriod: json['due_date'],
      custInvoicePeriod: json['custom_invoice_period'],
      type: json['type'],
      tagihanIDR: json['tagihan_idr'],
      volumeNormal: json['volume_normal'],
      volumeOverUsage: json['volume_over_usage'],
      volumeUsage: json['volume_usage'],
      others: parseDataOthers(json['other']),
      availableGuarantee: json['available_guarantee'],
      paymentGuatantee: json['payment_guarantee'],
      cmm: parseDataCMM(json['cmm']),
    );
  }
  static List<Others> parseDataOthers(datasJson) {
    var list = datasJson as List;
    List<Others> datasOther =
        list.map((data) => Others.fromJson(data)).toList();
    return datasOther;
  }

  static List<CMM> parseDataCMM(datasJson) {
    var list = datasJson as List;
    List<CMM> datasCmm = list.map((data) => CMM.fromJson(data)).toList();
    return datasCmm;
  }
}

class Others {
  String type;
  String idr;
  String usd;

  Others({this.idr, this.type, this.usd});

  factory Others.fromJson(Map<String, dynamic> json) {
    return Others(type: json['type'], idr: json['IDR'], usd: json['USD']);
  }
}

class CMM {
  dynamic standAwal;
  dynamic standAkhir;
  dynamic metodePerhitungan;
  dynamic metodePencatatan;

  CMM(
      {this.metodePerhitungan,
      this.standAkhir,
      this.standAwal,
      this.metodePencatatan});

  factory CMM.fromJson(Map<String, dynamic> json) {
    return CMM(
        standAwal: json['stand_awal'],
        standAkhir: json['stand_akhir'],
        metodePerhitungan: json['metode_perhitungan'],
        metodePencatatan: json['metode_pencatatan']);
  }
}

class Stand2 {
  dynamic standAwal;
  dynamic standAkhir;
  dynamic metodePerhitungan;

  Stand2({this.metodePerhitungan, this.standAkhir, this.standAwal});

  factory Stand2.fromJson(Map<String, dynamic> json) {
    return Stand2(
        standAwal: json['stand_awal'],
        standAkhir: json['stand_akhir'],
        metodePerhitungan: json['metode_perhitungan']);
  }
}
