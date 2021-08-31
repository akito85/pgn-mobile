class TopUsageDetail {
  List<DataTopUsage> data;
  MetaDataTop meta;
  String message;
  int code;

  TopUsageDetail({this.data, this.meta, this.message, this.code});

  factory TopUsageDetail.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return TopUsageDetail(
          data: parseDataTopUsage(json['data']),
          meta: MetaDataTop.fromJson(json['meta']));
    } else {
      return TopUsageDetail(message: json['message'], code: json['code']);
    }
  }

  static List<DataTopUsage> parseDataTopUsage(datasJson) {
    var list = datasJson as List;
    List<DataTopUsage> datasTopUsage =
        list.map((data) => DataTopUsage.fromJson(data)).toList();
    return datasTopUsage;
  }
}

class DataTopUsage {
  Usage usage;
  Customer customer;

  DataTopUsage({this.usage, this.customer});

  factory DataTopUsage.fromJson(Map<String, dynamic> json) {
    return DataTopUsage(
        usage: Usage.fromJson(json['usage']),
        customer: Customer.fromJson(json['customer']));
  }
}

class Usage {
  UsageBefore usageBefore;
  UsageAfter usageAfter;
  UsageDiff usageDiff;
  String percentageDiff;

  Usage(
      {this.percentageDiff, this.usageAfter, this.usageBefore, this.usageDiff});

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
        usageBefore: UsageBefore.fromJson(json['usage_before']),
        usageAfter: UsageAfter.fromJson(json['usage_after']),
        usageDiff: UsageDiff.fromJson(json['usage_diff']),
        percentageDiff: json['percentage_diff']);
  }
}

class UsageBefore {
  int value;
  String display;

  UsageBefore({this.display, this.value});

  factory UsageBefore.fromJson(Map<String, dynamic> json) {
    return UsageBefore(value: json['value'], display: json['display']);
  }
}

class UsageAfter {
  int value;
  String display;

  UsageAfter({this.display, this.value});

  factory UsageAfter.fromJson(Map<String, dynamic> json) {
    return UsageAfter(value: json['value'], display: json['display']);
  }
}

class UsageDiff {
  int value;
  String display;

  UsageDiff({this.display, this.value});

  factory UsageDiff.fromJson(Map<String, dynamic> json) {
    return UsageDiff(value: json['value'], display: json['display']);
  }
}

class Customer {
  String id;
  String aeId;
  String name;
  String address;
  String fax;
  String phone;
  String cPersonName;
  String prod;
  String sectorIndustry;
  String imageUrl;
  String cPersonMobile;
  String cPersonMail;

  Customer(
      {this.cPersonName,
      this.imageUrl,
      this.cPersonMobile,
      this.prod,
      this.phone,
      this.name,
      this.fax,
      this.address,
      this.aeId,
      this.id,
      this.sectorIndustry,
      this.cPersonMail});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        aeId: json['ae_id'],
        name: json['name'],
        address: json['address'],
        fax: json['fax'],
        phone: json['phone'],
        cPersonName: json['contact_person_name'],
        prod: json['production'],
        sectorIndustry: json['sector_industry'],
        imageUrl: json['image_url'],
        cPersonMobile: json['contact_person_mobile_phone'],
        cPersonMail: json['contact_person_email']);
  }
}

class MetaDataTop {
  StartDate startDate;
  EndDate endDate;
  String apiVersion;

  MetaDataTop({this.apiVersion, this.endDate, this.startDate});

  factory MetaDataTop.fromJson(Map<String, dynamic> json) {
    return MetaDataTop(
        startDate: StartDate.fromJson(json['start_date']),
        endDate: EndDate.fromJson(json['end_date']),
        apiVersion: json['api_version']);
  }
}

class StartDate {
  String valueStart;
  String displayStart;

  StartDate({this.displayStart, this.valueStart});

  factory StartDate.fromJson(Map<String, dynamic> json) {
    return StartDate(valueStart: json['value'], displayStart: json['display']);
  }
}

class EndDate {
  String valueEnd;
  String displayEnd;

  EndDate({this.displayEnd, this.valueEnd});

  factory EndDate.fromJson(Map<String, dynamic> json) {
    return EndDate(valueEnd: json['value'], displayEnd: json['display']);
  }
}
