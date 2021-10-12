class NoVirtualAccount {
  List<DataVirtualAccount> data;

  NoVirtualAccount({this.data});

  factory NoVirtualAccount.fromJson(Map<String, dynamic> json) {
    return NoVirtualAccount(
      data: parseDataNoVirtual(json['data']),
    );
  }

  static List<DataVirtualAccount> parseDataNoVirtual(datasJson) {
    var list = datasJson as List;
    List<DataVirtualAccount> datasNoVirtualAccount =
        list.map((data) => DataVirtualAccount.fromJson(data)).toList();
    return datasNoVirtualAccount;
  }
}

class DataVirtualAccount {
  String id;
  String number;
  BankVirtualAccount bank;

  DataVirtualAccount({this.id, this.number, this.bank});

  factory DataVirtualAccount.fromJson(Map<String, dynamic> json) {
    return DataVirtualAccount(
        id: json['id'],
        number: json['number'],
        bank: BankVirtualAccount.fromJson(json['bank']));
  }
}

class BankVirtualAccount {
  String bankId;
  String bankName;
  String bankIcon;

  BankVirtualAccount({this.bankIcon, this.bankId, this.bankName});

  factory BankVirtualAccount.fromJson(Map<String, dynamic> json) {
    return BankVirtualAccount(
        bankIcon: json['icon_url'], bankId: json['id'], bankName: json['name']);
  }
}

///////////////////////////////////////////////////////////////
class PutPaymentPlan {
  MetaPaymentPlan meta;

  PutPaymentPlan({this.meta});

  factory PutPaymentPlan.fromJson(Map<String, dynamic> json) {
    return PutPaymentPlan(
      meta: MetaPaymentPlan.fromJson(json['meta']),
    );
  }
}

class MetaPaymentPlan {
  String apiVersion;

  MetaPaymentPlan({this.apiVersion});

  factory MetaPaymentPlan.fromJson(Map<String, dynamic> json) {
    return MetaPaymentPlan(apiVersion: json['api_version']);
  }
}

////////////////////////////////////////////////////////////////////////////////////
class PaymentPlan {
  List<DataPaymentPlan> data;
  PagingPaymentPlan paging;
  String message;

  PaymentPlan({this.data, this.paging, this.message});

  factory PaymentPlan.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      return PaymentPlan(message: json['message']);
    } else {
      return PaymentPlan(
          data: parseDataPaymentPlan(json['data']),
          paging: PagingPaymentPlan.fromJson(json['paging']));
    }
  }

  static List<DataPaymentPlan> parseDataPaymentPlan(datasJson) {
    var list = datasJson as List;
    List<DataPaymentPlan> datasDataPaymentPlan =
        list.map((data) => DataPaymentPlan.fromJson(data)).toList();
    return datasDataPaymentPlan;
  }
}

class DataPaymentPlan {
  String idPP;
  InvoicePaymentPlan invoicePP;
  String paymentDate;
  String paymentUSD;

  DataPaymentPlan(
      {this.idPP, this.invoicePP, this.paymentUSD, this.paymentDate});

  factory DataPaymentPlan.fromJson(Map<String, dynamic> json) {
    return DataPaymentPlan(
        idPP: json['id'],
        invoicePP: InvoicePaymentPlan.fromJson(json['invoice']),
        paymentDate: json['payment_date'],
        paymentUSD: json['payment_usd']);
  }
}

class InvoicePaymentPlan {
  String idInvoice;
  String usagePeriod;
  String totalBilingUSD;
  String dueDate;

  InvoicePaymentPlan(
      {this.idInvoice, this.totalBilingUSD, this.usagePeriod, this.dueDate});

  factory InvoicePaymentPlan.fromJson(Map<String, dynamic> json) {
    return InvoicePaymentPlan(
        idInvoice: json['id'],
        usagePeriod: json['usage_period'],
        totalBilingUSD: json['total_billing_usd'],
        dueDate: json['due_date']);
  }
}

class PagingPaymentPlan {
  String current;
  String prev;
  String next;
  int count;

  PagingPaymentPlan({this.count, this.current, this.next, this.prev});

  factory PagingPaymentPlan.fromJson(Map<String, dynamic> json) {
    return PagingPaymentPlan(
        current: json['current'],
        prev: json['prev'],
        next: json['next'],
        count: json['count']);
  }
}

/////////////////////////////////////////////////////////////////////////////
class GetHolidayDays {
  List<DataHolidays> data;

  GetHolidayDays({this.data});

  factory GetHolidayDays.fromJson(Map<String, dynamic> json) {
    return GetHolidayDays(
      data: parseDataHolidays(json['data']),
    );
  }

  static List<DataHolidays> parseDataHolidays(datasJson) {
    var list = datasJson as List;
    List<DataHolidays> datasHolidays =
        list.map((data) => DataHolidays.fromJson(data)).toList();
    return datasHolidays;
  }
}

class DataHolidays {
  String id;
  String startDate;
  String endDate;
  String title;

  DataHolidays({this.endDate, this.id, this.startDate, this.title});

  factory DataHolidays.fromJson(Map<String, dynamic> json) {
    return DataHolidays(
        id: json['id'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        title: json['title']);
  }
}

/////////////////////
class ReturnCreatePaymentPlan {
  String message;

  ReturnCreatePaymentPlan({this.message});

  factory ReturnCreatePaymentPlan.fromJson(Map<String, dynamic> json) {
    return ReturnCreatePaymentPlan(message: json['message']);
  }
}
//////// DETAIL PAYMENT PLAN

class DetaiPaymentPlan {
  DataDetailPayment dataDetailPayment;
  DetaiPaymentPlan({this.dataDetailPayment});

  factory DetaiPaymentPlan.fromJson(Map<String, dynamic> json) {
    return DetaiPaymentPlan(
      dataDetailPayment: DataDetailPayment.fromJson(json['data']),
    );
  }
}

class DataDetailPayment {
  InvoicePaymentPlan invoicePP;
  String paymentUsd;
  String paymentDate;
  DataVirtualAccount dataVirtualAccount;
  PICInfo picInfo;

  DataDetailPayment(
      {this.dataVirtualAccount,
      this.invoicePP,
      this.paymentDate,
      this.paymentUsd,
      this.picInfo});

  factory DataDetailPayment.fromJson(Map<String, dynamic> json) {
    return DataDetailPayment(
      paymentDate: json['payment_date'],
      paymentUsd: json['payment_usd'],
      invoicePP: InvoicePaymentPlan.fromJson(json['invoice']),
      dataVirtualAccount: DataVirtualAccount.fromJson(json['virtual_account']),
      picInfo: PICInfo.fromJson(json['pic']),
    );
  }
}

class PICInfo {
  String idPic;
  String namePic;
  String emailPic;
  String phonePic;

  PICInfo({this.emailPic, this.idPic, this.namePic, this.phonePic});

  factory PICInfo.fromJson(Map<String, dynamic> json) {
    return PICInfo(
        idPic: json['id'],
        namePic: json['name'],
        emailPic: json['email'],
        phonePic: json['mobile_phone']);
  }
}
