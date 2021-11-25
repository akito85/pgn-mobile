class ChartUsageDetailSmartmeter {
  List<UsageDetailChar> data;
  String message;

  ChartUsageDetailSmartmeter({this.data, this.message});

  factory ChartUsageDetailSmartmeter.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartUsageDetailSmartmeter(
        data: parseDataUsageDetail(json['data']),
      );
    else
      return ChartUsageDetailSmartmeter(
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
