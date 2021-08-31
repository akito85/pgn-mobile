class UsageDetails {
  List<DataUsageDetail> data;
  PagingUsageDetail paging;
  String message;
  MetaDatas meta;

  UsageDetails({this.paging, this.data, this.meta, this.message});

  factory UsageDetails.fromJson(Map<String, dynamic> json) {
    print("INI PAGING ${json['paging']}");
    if (json['data'] != null)
      return UsageDetails(
          data: parseUsageDetail(json['data']),
          message: json['message'],
          paging: PagingUsageDetail.fromJson(json['paging']),
          meta: MetaDatas.fromJson(json['meta']));
    else
      return UsageDetails(message: json['message']);
  }

  static List<DataUsageDetail> parseUsageDetail(datasJson) {
    var list = datasJson as List;
    List<DataUsageDetail> datasUsageDetail =
        list.map((data) => DataUsageDetail.fromJson(data)).toList();
    return datasUsageDetail;
  }
}

class DataUsageDetail {
  GasUsage gasUsage;
  Customer customer;

  DataUsageDetail({this.customer, this.gasUsage});

  factory DataUsageDetail.fromJson(Map<String, dynamic> json) {
    return DataUsageDetail(
        gasUsage: GasUsage.fromJson(json['gas_usage']),
        customer: Customer.fromJson(json['customer']));
  }
}

class GasUsage {
  Usage usage;
  EstimationUsage estimationUsage;
  MaxUsage maxUsage;
  MinUsage minUsage;
  Status status;

  GasUsage(
      {this.estimationUsage,
      this.maxUsage,
      this.minUsage,
      this.status,
      this.usage});

  factory GasUsage.fromJson(Map<String, dynamic> json) {
    return GasUsage(
        usage: Usage.fromJson(json['usage']),
        estimationUsage: EstimationUsage.fromJson(json['estimation_usage']),
        maxUsage: MaxUsage.fromJson(json['max_usage']),
        minUsage: MinUsage.fromJson(json['min_usage']),
        status: Status.fromJson(json['status']));
  }
}

class Usage {
  int value;
  String display;

  Usage({this.display, this.value});

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(value: json['value'], display: json['display']);
  }
}

class EstimationUsage {
  int value;
  String display;

  EstimationUsage({this.value, this.display});

  factory EstimationUsage.fromJson(Map<String, dynamic> json) {
    return EstimationUsage(value: json['value'], display: json['display']);
  }
}

class MaxUsage {
  int value;
  String display;

  MaxUsage({this.display, this.value});

  factory MaxUsage.fromJson(Map<String, dynamic> json) {
    return MaxUsage(value: json['value'], display: json['display']);
  }
}

class MinUsage {
  int value;
  String display;

  MinUsage({this.display, this.value});

  factory MinUsage.fromJson(Map<String, dynamic> json) {
    return MinUsage(value: json['value'], display: json['display']);
  }
}

class Status {
  String id;
  String display;

  Status({this.display, this.id});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(id: json['id'], display: json['display']);
  }
}

class Customer {
  String custId;
  String aeId;
  String name;
  String address;
  String fax;
  String phone;
  String cPersonName;
  String prod;
  String sectoryIndustry;
  String imageUrl;
  String cPersonMobile;
  String cPersonEmail;

  Customer(
      {this.address,
      this.cPersonEmail,
      this.custId,
      this.fax,
      this.name,
      this.phone,
      this.prod,
      this.aeId,
      this.cPersonMobile,
      this.cPersonName,
      this.imageUrl,
      this.sectoryIndustry});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        custId: json['id'],
        aeId: json['ae_id'],
        name: json['name'],
        address: json['address'],
        fax: json['fax'],
        phone: json['phone'],
        cPersonName: json['contact_person_number'],
        prod: json['production'],
        sectoryIndustry: json['sector_industry'],
        imageUrl: json['image_url'],
        cPersonMobile: json['contact_person_mobile_phone'],
        cPersonEmail: json['contact_person_email']);
  }
}

class PagingUsageDetail {
  String current;
  String prev;
  String next;
  String count;

  PagingUsageDetail({this.count, this.current, this.next, this.prev});

  factory PagingUsageDetail.fromJson(Map<String, dynamic> json) {
    return PagingUsageDetail(
        current: json['current'], prev: json['prev'], next: json['next']);
  }
}

class MetaDatas {
  StartDate startDate;
  EndDate endDate;
  String apiVersion;

  MetaDatas({this.apiVersion, this.endDate, this.startDate});

  factory MetaDatas.fromJson(Map<String, dynamic> json) {
    return MetaDatas(
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

//Usage Detail Monthly
class ChartUsageDetailMonthly {
  List<UsageDetailCharMonthly> data;
  String message;
  MetaDataUsageDetailMonthly meta;

  ChartUsageDetailMonthly({this.data, this.meta, this.message});

  factory ChartUsageDetailMonthly.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartUsageDetailMonthly(
          data: parseDataUsageDetail(json['data']),
          meta: MetaDataUsageDetailMonthly.fromJson(json['meta']));
    else
      return ChartUsageDetailMonthly(message: json['message']);
  }

  static List<UsageDetailCharMonthly> parseDataUsageDetail(datasJson) {
    var list = datasJson as List;
    List<UsageDetailCharMonthly> datasUsageDetail =
        list.map((data) => UsageDetailCharMonthly.fromJson(data)).toList();
    return datasUsageDetail;
  }
}

class UsageDetailCharMonthly {
  MaxUsageDetail maxUsage;
  MinUsageDetail minUsageDetail;
  UsageDetailMonthly usageDetailMonthly;
  UsageDetailMonth month;

  UsageDetailCharMonthly(
      {this.maxUsage,
      this.minUsageDetail,
      this.month,
      this.usageDetailMonthly});

  factory UsageDetailCharMonthly.fromJson(Map<String, dynamic> json) {
    return UsageDetailCharMonthly(
        maxUsage: MaxUsageDetail.fromJson(json['max_usage']),
        minUsageDetail: MinUsageDetail.fromJson(json['min_usage']),
        usageDetailMonthly: UsageDetailMonthly.fromJson(json['usage']),
        month: UsageDetailMonth.fromJson(json['month']));
  }
}

class MaxUsageDetail {
  int value;
  String display;

  MaxUsageDetail({this.display, this.value});

  factory MaxUsageDetail.fromJson(Map<String, dynamic> json) {
    return MaxUsageDetail(value: json['value'], display: json['display']);
  }
}

class MinUsageDetail {
  int value;
  String display;

  MinUsageDetail({this.display, this.value});

  factory MinUsageDetail.fromJson(Map<String, dynamic> json) {
    return MinUsageDetail(value: json['value'], display: json['display']);
  }
}

class UsageDetailMonthly {
  int value;
  String display;

  UsageDetailMonthly({this.display, this.value});

  factory UsageDetailMonthly.fromJson(Map<String, dynamic> json) {
    return UsageDetailMonthly(value: json['value'], display: json['display']);
  }
}

class UsageDetailMonth {
  String value;
  String display;

  UsageDetailMonth({this.display, this.value});

  factory UsageDetailMonth.fromJson(Map<String, dynamic> json) {
    return UsageDetailMonth(value: json['value'], display: json['display']);
  }
}

class MetaDataUsageDetailMonthly {
  StartDateMonthly startDate;
  EndDateMonthly endDate;
  TotalMonthly total;

  MetaDataUsageDetailMonthly({this.endDate, this.startDate, this.total});

  factory MetaDataUsageDetailMonthly.fromJson(Map<String, dynamic> json) {
    return MetaDataUsageDetailMonthly(
        startDate: StartDateMonthly.fromJson(json['start_date']),
        endDate: EndDateMonthly.fromJson(json['end_date']),
        total: TotalMonthly.fromJson(json['total_usage']));
  }
}

class StartDateMonthly {
  String valueStart;
  String displayStart;

  StartDateMonthly({this.displayStart, this.valueStart});

  factory StartDateMonthly.fromJson(Map<String, dynamic> json) {
    return StartDateMonthly(
        valueStart: json['value'], displayStart: json['display']);
  }
}

class EndDateMonthly {
  String valueEnd;
  String displayEnd;

  EndDateMonthly({this.displayEnd, this.valueEnd});

  factory EndDateMonthly.fromJson(Map<String, dynamic> json) {
    return EndDateMonthly(valueEnd: json['value'], displayEnd: json['display']);
  }
}

class TotalMonthly {
  var valueTotal;
  String displayTotal;

  TotalMonthly({this.valueTotal, this.displayTotal});

  factory TotalMonthly.fromJson(Map<String, dynamic> json) {
    return TotalMonthly(
        valueTotal: json['value'], displayTotal: json['display']);
  }
}
//END

//UsageDetailDaily
class ChartUsageDetail {
  List<UsageDetailChar> data;
  MetaDataUsageDetail meta;
  String message;

  ChartUsageDetail({this.data, this.meta, this.message});

  factory ChartUsageDetail.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartUsageDetail(
          data: parseDataUsageDetail(json['data']),
          meta: MetaDataUsageDetail.fromJson(json['meta']));
    else
      return ChartUsageDetail(
        message: json['message'],
      );
  }

  static List<UsageDetailChar> parseDataUsageDetail(datasJson) {
    var list = datasJson as List;
    List<UsageDetailChar> datasUsageDetail =
        list.map((data) => UsageDetailChar.fromJson(data)).toList();
    return datasUsageDetail;
  }
}

class UsageDetailChar {
  UsageDetail usage;
  DateUsageDetail date;

  UsageDetailChar({this.usage, this.date});

  factory UsageDetailChar.fromJson(Map<String, dynamic> json) {
    return UsageDetailChar(
        usage: UsageDetail.fromJson(json['usage']),
        date: DateUsageDetail.fromJson(json['date']));
  }
}

class UsageDetail {
  int value;
  String display;

  UsageDetail({this.display, this.value});

  factory UsageDetail.fromJson(Map<String, dynamic> json) {
    return UsageDetail(value: json['value'], display: json['display']);
  }
}

class DateUsageDetail {
  String value;
  String display;

  DateUsageDetail({this.display, this.value});

  factory DateUsageDetail.fromJson(Map<String, dynamic> json) {
    return DateUsageDetail(value: json['value'], display: json['display']);
  }
}

class MetaDataUsageDetail {
  StartDateDetail startDate;
  EndDateDetail endDate;

  MetaDataUsageDetail({this.endDate, this.startDate});

  factory MetaDataUsageDetail.fromJson(Map<String, dynamic> json) {
    return MetaDataUsageDetail(
        startDate: StartDateDetail.fromJson(json['start_date']),
        endDate: EndDateDetail.fromJson(json['end_date']));
  }
}

class StartDateDetail {
  String valueStart;
  String displayStart;

  StartDateDetail({this.displayStart, this.valueStart});

  factory StartDateDetail.fromJson(Map<String, dynamic> json) {
    return StartDateDetail(
        valueStart: json['value'], displayStart: json['display']);
  }
}

class EndDateDetail {
  String valueEnd;
  String displayEnd;

  EndDateDetail({this.displayEnd, this.valueEnd});

  factory EndDateDetail.fromJson(Map<String, dynamic> json) {
    return EndDateDetail(valueEnd: json['value'], displayEnd: json['display']);
  }
}
//END
