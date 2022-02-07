class CustomerInvoice {
  List<DataCustInvoice> data;
  String message;
  int code;
  CustomerInvoice({this.data, this.message, this.code});

  factory CustomerInvoice.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return CustomerInvoice(
        data: parseDataInvoice(json['data']),
      );
    else
      return CustomerInvoice(message: json['message'], code: json['code']);
  }

  static List<DataCustInvoice> parseDataInvoice(datasJson) {
    var list = datasJson as List;
    List<DataCustInvoice> datasInvoice =
        list.map((data) => DataCustInvoice.fromJson(data)).toList();
    return datasInvoice;
  }
}

class DataCustInvoice {
  String invoiceId;
  String custInvoiceId;
  String custInvoiceName;
  UsagePeriod usagePeriod;
  String invoicePeriodRT;
  InvoicePeriod invoicePeriod;
  String invoicePeriodS;
  String usagePeriodS;
  CountedEnergy countedEnergy;
  CountedVolume countedVolume;
  BilledEnergy billedEnergy;
  BilledVolume billedVolume;
  TBillIdr tBillIdr;
  String tBillIdrS;
  TBillUsd tBillUsd;
  MinUsage minUsage;
  MaxUsage maxUsage;
  PGuaranteeIdr pGuaranteeIdr;
  PGuaranteeUsd pGuaranteeUsd;
  String pGuaranteeIdrS;
  String pGuaranteeUsdS;
  int isPaid;
  String type;
  DueDate dueDate;
  String paidDate;
  PaymentStatus paymentStatus;
  PaymentPlanSub paymentPlanSub;
  String custVolUsage;
  String arrersIdr;
  String arrersUsd;
  String custInvoicePeriod;
  String denda;
  String biayaPengaliran;
  String biayaPemasangan;
  String biayaMigrasi;
  String biayaPelayanan;
  String tBillIdrRT;
  String tBillUsdRT;
  dynamic availableGuarantee;
  dynamic paymentGuatantee;
  String biayaSms;
  String volumeUsage;
  String volumeNormal;
  String volumeOverUsage;
  dynamic tagihanIDR;
  String usagePeriodRT;
  List<CMM> cmm;
  List<Others> others;

  DataCustInvoice(
      {this.maxUsage,
      this.minUsage,
      this.billedEnergy,
      this.billedVolume,
      this.countedEnergy,
      this.countedVolume,
      this.custInvoiceId,
      this.custInvoiceName,
      this.dueDate,
      this.invoiceId,
      this.invoicePeriod,
      this.isPaid,
      this.paidDate,
      this.paymentPlanSub,
      this.paymentStatus,
      this.pGuaranteeIdr,
      this.pGuaranteeUsd,
      this.availableGuarantee,
      this.paymentGuatantee,
      this.cmm,
      this.tagihanIDR,
      this.volumeNormal,
      this.volumeOverUsage,
      this.volumeUsage,
      this.others,
      this.tBillIdrRT,
      this.tBillUsdRT,
      this.type,
      this.usagePeriod,
      this.arrersIdr,
      this.arrersUsd,
      this.custInvoicePeriod,
      this.custVolUsage,
      this.tBillIdrS,
      this.invoicePeriodS,
      this.pGuaranteeIdrS,
      this.pGuaranteeUsdS,
      this.usagePeriodS,
      this.biayaMigrasi,
      this.biayaPelayanan,
      this.biayaPemasangan,
      this.biayaPengaliran,
      this.biayaSms,
      this.denda,
      this.tBillIdr,
      this.tBillUsd,
      this.invoicePeriodRT,
      this.usagePeriodRT});

  factory DataCustInvoice.fromJson(Map<String, dynamic> json) {
    //print('INI JSON NYA ${json['type']}');
    if (json['type'] == 'commercial') {
      return DataCustInvoice(
          invoiceId: json['id'],
          custInvoiceId: json['customer_id'],
          custInvoiceName: json['customer_name'],
          usagePeriod: UsagePeriod.fromJson(json['usage_period']),
          invoicePeriod: InvoicePeriod.fromJson(json['invoice_period']),
          countedEnergy: CountedEnergy.fromJson(json['counted_energy']),
          countedVolume: CountedVolume.fromJson(json['counted_volume']),
          billedEnergy: BilledEnergy.fromJson(json['billed_energy']),
          billedVolume: BilledVolume.fromJson(json['billed_volume']),
          tBillIdr: TBillIdr.fromJson(json['total_bill_idr']),
          tBillUsd: TBillUsd.fromJson(json['total_bill_usd']),
          minUsage: MinUsage.fromJson(json['min_usage']),
          maxUsage: MaxUsage.fromJson(json['max_usage']),
          pGuaranteeIdr: PGuaranteeIdr.fromJson(json['payment_guarantee_idr']),
          pGuaranteeUsd: PGuaranteeUsd.fromJson(json['payment_guarantee_usd']),
          isPaid: json['is_paid'],
          type: json['type'],
          dueDate: DueDate.fromJson(json['due_date']),
          paidDate: json['paid_date'],
          paymentStatus: PaymentStatus.fromJson(json['payment_status']),
          paymentPlanSub:
              PaymentPlanSub.fromJson(json['payment_plan_submission']),
          denda: json['denda'],
          biayaPengaliran: json['biaya_pengaliran_kembali'],
          biayaPelayanan: json['biaya_pelayanan'],
          biayaPemasangan: json['biaya_pemasangan_kembali'],
          biayaMigrasi: json['biaya_migrasi'],
          biayaSms: json['biasa_sms']);
    } else {
      return DataCustInvoice(
        invoiceId: json['id'],
        custInvoiceId: json['customer_id'],
        custInvoiceName: json['customer_name'],
        custVolUsage: json['volume_usage'],
        tBillIdrRT: json['total_bill_idr'],
        tBillUsdRT: json['total_bill_usd'],
        isPaid: json['is_paid'],
        invoicePeriodRT: json['period'],
        usagePeriodRT: json['due_date'],
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

class UsagePeriod {
  String value;
  String display;

  UsagePeriod({this.value, this.display});

  factory UsagePeriod.fromJson(Map<String, dynamic> json) {
    return UsagePeriod(value: json['value'], display: json['display']);
  }
}

class InvoicePeriod {
  String value;
  String display;

  InvoicePeriod({this.display, this.value});

  factory InvoicePeriod.fromJson(Map<String, dynamic> json) {
    return InvoicePeriod(value: json['value'], display: json['display']);
  }
}

class CountedEnergy {
  int value;
  String display;

  CountedEnergy({this.value, this.display});

  factory CountedEnergy.fromJson(Map<String, dynamic> json) {
    return CountedEnergy(value: json['value'], display: json['display']);
  }
}

class CountedVolume {
  int value;
  String display;

  CountedVolume({this.value, this.display});

  factory CountedVolume.fromJson(Map<String, dynamic> json) {
    return CountedVolume(value: json['value'], display: json['display']);
  }
}

class BilledEnergy {
  int value;
  String display;

  BilledEnergy({this.value, this.display});

  factory BilledEnergy.fromJson(Map<String, dynamic> json) {
    return BilledEnergy(value: json['value'], display: json['display']);
  }
}

class BilledVolume {
  int value;
  String display;

  BilledVolume({this.value, this.display});

  factory BilledVolume.fromJson(Map<String, dynamic> json) {
    return BilledVolume(value: json['value'], display: json['display']);
  }
}

class TBillIdr {
  var value;
  String display;

  TBillIdr({this.value, this.display});

  factory TBillIdr.fromJson(Map<String, dynamic> json) {
    return TBillIdr(value: json['value'], display: json['display']);
  }
}

class TBillUsd {
  var value;
  String display;

  TBillUsd({this.value, this.display});

  factory TBillUsd.fromJson(Map<String, dynamic> json) {
    return TBillUsd(value: json['value'], display: json['display']);
  }
}

class MinUsage {
  int value;
  String display;

  MinUsage({this.value, this.display});

  factory MinUsage.fromJson(Map<String, dynamic> json) {
    return MinUsage(value: json['value'], display: json['display']);
  }
}

class MaxUsage {
  int value;
  String display;

  MaxUsage({this.value, this.display});

  factory MaxUsage.fromJson(Map<String, dynamic> json) {
    return MaxUsage(value: json['value'], display: json['display']);
  }
}

class PGuaranteeIdr {
  int value;
  String display;

  PGuaranteeIdr({this.value, this.display});

  factory PGuaranteeIdr.fromJson(Map<String, dynamic> json) {
    return PGuaranteeIdr(value: json['value'], display: json['display']);
  }
}

class PGuaranteeUsd {
  var value;
  String display;

  PGuaranteeUsd({this.value, this.display});

  factory PGuaranteeUsd.fromJson(Map<String, dynamic> json) {
    return PGuaranteeUsd(value: json['value'], display: json['display']);
  }
}

class DueDate {
  String value;
  String display;

  DueDate({this.value, this.display});

  factory DueDate.fromJson(Map<String, dynamic> json) {
    return DueDate(value: json['value'], display: json['display']);
  }
}

class PaymentStatus {
  String id;
  String display;

  PaymentStatus({this.id, this.display});

  factory PaymentStatus.fromJson(Map<String, dynamic> json) {
    return PaymentStatus(id: json['id'], display: json['display']);
  }
}

class PaymentPlanSub {
  String id;
  String display;

  PaymentPlanSub({this.id, this.display});

  factory PaymentPlanSub.fromJson(Map<String, dynamic> json) {
    return PaymentPlanSub(id: json['id'], display: json['display']);
  }
}
