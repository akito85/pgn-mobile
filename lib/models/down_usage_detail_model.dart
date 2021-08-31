class DownUsageDetail {
  List<DataDownUsage> data;
  MetaData meta;
  String message;

  DownUsageDetail({this.data, this.meta, this.message});

  factory DownUsageDetail.fromJson(Map<String, dynamic> json){
    if(json['data'] != null)
    {
      return DownUsageDetail(
        data: parseDataTopUsage(json['data']),
        meta: MetaData.fromJson(json['meta'])
      );
    }
    else {
      return DownUsageDetail(
        message: json['message']
      );
    }
    
  }

  static List<DataDownUsage> parseDataTopUsage(datasJson){
    var list = datasJson as List;
    List<DataDownUsage> datasTopUsage = 
    list.map((data) => DataDownUsage.fromJson(data)).toList();
    return datasTopUsage;
  }
}

class DataDownUsage{
  Usage usage;
  Customer customer;

  DataDownUsage({this.usage, this.customer});

  factory DataDownUsage.fromJson(Map<String, dynamic> json){
    return DataDownUsage(
      usage: Usage.fromJson(json['usage']),
      customer: Customer.fromJson(json['customer'])
    );
  }
}

class Usage {
  UsageBefore usageBefore;
  UsageAfter usageAfter;
  UsageDiff usageDiff;
  String percentageDiff;

  Usage({this.percentageDiff, this.usageAfter, this.usageBefore, this.usageDiff});

  factory Usage.fromJson(Map<String, dynamic> json){
    return Usage(
      usageBefore: UsageBefore.fromJson(json['usage_before']),
      usageAfter: UsageAfter.fromJson(json['usage_after']),
      usageDiff: UsageDiff.fromJson(json['usage_diff']),
      percentageDiff:  json['percentage_diff']
    );
  }
}

class UsageBefore{
  int value;
  String display;

  UsageBefore ({this.display, this.value});

  factory UsageBefore.fromJson(Map<String, dynamic>json){
    return UsageBefore(
      value: json['value'],
      display: json['display']
    );
  }
}

class UsageAfter{
  int value;
  String display;

  UsageAfter ({this.display, this.value});

  factory UsageAfter.fromJson(Map<String, dynamic>json){
    return UsageAfter(
      value: json['value'],
      display: json['display']
    );
  }
}

class UsageDiff{
  int value;
  String display;

  UsageDiff ({this.display, this.value});

  factory UsageDiff.fromJson(Map<String, dynamic>json){
    return UsageDiff(
      value: json['value'],
      display: json['display']
    );
  }
}

class Customer{
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

  Customer({this.cPersonName, this.imageUrl, this.cPersonMobile, this.prod, 
  this.phone, this.name, this.fax, this.address, this.aeId, this.id, 
  this.sectorIndustry, this.cPersonMail});

  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      id: json['id'],
      aeId: json['ae_id'],
      name: json['name'],
      address: json['address'],
      fax: json['fax'],
      phone: json['phone'],
      cPersonName:  json['contact_person_name'],
      prod: json['production'],
      sectorIndustry: json['sector_industry'],
      imageUrl: json['image_url'],
      cPersonMobile: json['contact_person_mobile_phone'],
      cPersonMail: json['contact_person_email']
    );
  }
}

class MetaData {
  StartDate startDate;
  EndDate endDate;
  String apiVersion;

  MetaData({this.apiVersion, this.endDate, this.startDate});

  factory MetaData.fromJson(Map<String, dynamic>json){
    return MetaData(
      startDate: StartDate.fromJson(json['start_date']),
      endDate: EndDate.fromJson(json['end_date']),
      apiVersion: json['api_version']
    );
  }
}

class StartDate {
  String valueStart;
  String displayStart;

  StartDate({this.displayStart, this.valueStart});

  factory StartDate.fromJson(Map<String, dynamic> json){
    return StartDate(
      valueStart: json['value'],
      displayStart: json['display']
    );
  }
}

class EndDate {
  String valueEnd;
  String displayEnd;

  EndDate({this.displayEnd, this.valueEnd});

  factory EndDate.fromJson(Map<String, dynamic> json){
    return EndDate(
      valueEnd: json['value'],
      displayEnd: json['display']
    );
  }
}
