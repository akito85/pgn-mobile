class ChartUsageDetailRealtime {
  List<UsageDetailChar> data;
  String message;

  ChartUsageDetailRealtime({this.data, this.message});

  factory ChartUsageDetailRealtime.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartUsageDetailRealtime(
        data: parseDataUsageDetail(json['data']),
      );
    else
      return ChartUsageDetailRealtime(
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
  CounterVolume counterVolume;
  DateUsageDetail date;
  Flow flow;

  UsageDetailChar({this.counterVolume, this.date, this.flow});

  factory UsageDetailChar.fromJson(Map<String, dynamic> json) {
    return UsageDetailChar(
        counterVolume: CounterVolume.fromJson(json['counter_volume']),
        flow: Flow.fromJson(json['flow']),
        date: DateUsageDetail.fromJson(json['date']));
  }
}

class CounterVolume {
  int value;
  String display;

  CounterVolume({this.display, this.value});

  factory CounterVolume.fromJson(Map<String, dynamic> json) {
    return CounterVolume(value: json['value'], display: json['display']);
  }
}

class Flow {
  int value;
  String display;

  Flow({this.display, this.value});

  factory Flow.fromJson(Map<String, dynamic> json) {
    return Flow(value: json['value'], display: json['display']);
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

///////// DETAIL REALTIME
class ChartUsageDetailRealtimeDetail {
  List<UsageDetailList> data;
  String message;

  ChartUsageDetailRealtimeDetail({this.data, this.message});

  factory ChartUsageDetailRealtimeDetail.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartUsageDetailRealtimeDetail(
        data: parseDataUsageDetail(json['data']),
      );
    else
      return ChartUsageDetailRealtimeDetail(
        message: json['message'],
      );
  }

  static List<UsageDetailList> parseDataUsageDetail(datasJson) {
    var list = datasJson as List;
    List<UsageDetailList> datasUsageDetail =
        list.map((data) => UsageDetailList.fromJson(data)).toList();
    return datasUsageDetail;
  }
}

class UsageDetailList {
  CounterVolumeList counterVolume;
  PressureVolumeList pressureVolumeList;
  TempratureList tempratureList;
  DateUsageDetailList date;
  FlowList flow;

  UsageDetailList(
      {this.counterVolume,
      this.date,
      this.flow,
      this.pressureVolumeList,
      this.tempratureList});

  factory UsageDetailList.fromJson(Map<String, dynamic> json) {
    return UsageDetailList(
        counterVolume: CounterVolumeList.fromJson(json['counter_volume']),
        flow: FlowList.fromJson(json['flow']),
        tempratureList: TempratureList.fromJson(json['temperature']),
        pressureVolumeList:
            PressureVolumeList.fromJson(json['pressure_volume']),
        date: DateUsageDetailList.fromJson(json['date']));
  }
}

class PressureVolumeList {
  int value;
  String display;

  PressureVolumeList({this.display, this.value});

  factory PressureVolumeList.fromJson(Map<String, dynamic> json) {
    return PressureVolumeList(value: json['value'], display: json['display']);
  }
}

class TempratureList {
  int value;
  String display;

  TempratureList({this.display, this.value});

  factory TempratureList.fromJson(Map<String, dynamic> json) {
    return TempratureList(value: json['value'], display: json['display']);
  }
}

class CounterVolumeList {
  int value;
  String display;

  CounterVolumeList({this.display, this.value});

  factory CounterVolumeList.fromJson(Map<String, dynamic> json) {
    return CounterVolumeList(value: json['value'], display: json['display']);
  }
}

class FlowList {
  int value;
  String display;

  FlowList({this.display, this.value});

  factory FlowList.fromJson(Map<String, dynamic> json) {
    return FlowList(value: json['value'], display: json['display']);
  }
}

class DateUsageDetailList {
  String value;
  String display;

  DateUsageDetailList({this.display, this.value});

  factory DateUsageDetailList.fromJson(Map<String, dynamic> json) {
    return DateUsageDetailList(value: json['value'], display: json['display']);
  }
}
