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
  String billTypeDesc;
  dynamic availableGuarantee;
  dynamic paymentGuatantee;
  String billDate;
  String volumeUsage;
  String volumeNormal;
  String volumeOverUsage;
  dynamic tagihanIDR;
  int isPaid;
  String usagePeriod;
  String invoicePeriod;
  String custInvoicePeriod;
  String type;
  TotalOther totalOther;
  TaxBase taxBase;
  Vat vat;
  List<CMM> cmm;
  List<Others> others;
  List<Piutang> piutang;

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
      this.others,
      this.billDate,
      this.taxBase,
      this.totalOther,
      this.vat,
      this.piutang,
      this.billTypeDesc});

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
      billTypeDesc: json['bill_type_desc'],
      others: parseDataOthers(json['other']),
      availableGuarantee: json['available_guarantee'],
      paymentGuatantee: json['payment_guarantee'],
      billDate: json['bill_date'],
      totalOther: TotalOther.fromJson(json['total_other']),
      taxBase: TaxBase.fromJson(json['tax_base']),
      vat: Vat.fromJson(json['vat']),
      cmm: parseDataCMM(json['cmm']),
      piutang: parseDataPiutang(json['piutang']),
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

  static List<Piutang> parseDataPiutang(datasJson) {
    var list = datasJson as List;
    List<Piutang> datasPiutang =
        list.map((data) => Piutang.fromJson(data)).toList();
    return datasPiutang;
  }
}

class Piutang {
  String idr;
  String period;

  Piutang({this.idr, this.period});

  factory Piutang.fromJson(Map<String, dynamic> json) {
    return Piutang(idr: json['IDR'], period: json['period']);
  }
}

class TotalOther {
  String idr;
  TotalOther({this.idr});
  factory TotalOther.fromJson(Map<String, dynamic> json) {
    return TotalOther(idr: json['IDR']);
  }
}

class Vat {
  String idr;
  Vat({this.idr});
  factory Vat.fromJson(Map<String, dynamic> json) {
    return Vat(idr: json['IDR']);
  }
}

class TaxBase {
  String idr;
  TaxBase({this.idr});
  factory TaxBase.fromJson(Map<String, dynamic> json) {
    return TaxBase(idr: json['IDR']);
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
        metodePerhitungan: json['status_meter'],
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
