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
      this.tBillIdr,
      this.tBillUsd,
      this.type,
      this.usagePeriod, 
      this.arrersIdr, this.arrersUsd, this.custInvoicePeriod, this.custVolUsage, this.tBillIdrS, this.invoicePeriodS, this.pGuaranteeIdrS, this.pGuaranteeUsdS, this.usagePeriodS});

  factory DataCustInvoice.fromJson(Map<String, dynamic> json) {
    print('INI JSON NYA ${json['type']}');
    if(json['type']== 'commercial')
    {
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
      paymentPlanSub: PaymentPlanSub.fromJson(json['payment_plan_submission']),
    );
    }else {
      return DataCustInvoice(
      invoiceId: json['id'],
      custInvoiceId: json['customer_id'],
      custInvoiceName: json['customer_name'],
      custVolUsage: json['volume_usage'],
      tBillIdrS: json['total_bill_idr'],
      pGuaranteeIdrS: json['payment_guarantee_idr'],
      pGuaranteeUsdS: json['payment_guarantee_usd'],
      arrersIdr: json['arrears_idr'],
      arrersUsd: json['arrears_usd'],
      isPaid: json['is_paid'],
      invoicePeriodS: json['invoice_period'],
      usagePeriodS: json['usage_period'],
      custInvoicePeriod: json['custom_invoice_period'],
      type: json['type']
    );
    }
    
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
