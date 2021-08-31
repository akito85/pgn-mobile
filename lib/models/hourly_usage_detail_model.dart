class HourlyUsageDetail {
  List<DataHourlyUsage> data;
  PagingHourlyUsage paging;
  String message;
  int code;
  HourlyUsageDetail({this.data, this.paging, this.message, this.code});

  factory HourlyUsageDetail.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return HourlyUsageDetail(
          data: parseDataHourlyUsage(json['data']),
          paging: PagingHourlyUsage.fromJson(json['paging']));
    else
      return HourlyUsageDetail(
        message: json['message'],
        code: json['code'],
      );
  }

  static List<DataHourlyUsage> parseDataHourlyUsage(datasJson) {
    var list = datasJson as List;
    List<DataHourlyUsage> datasHourlyUsage =
        list.map((data) => DataHourlyUsage.fromJson(data)).toList();
    return datasHourlyUsage;
  }
}

class DataHourlyUsage {
  String id;
  String date;
  String meterId;
  String pressure;
  String cFactor;
  String cIndex;
  String unCIndex;
  String temp;
  String volume;
  int hour;

  DataHourlyUsage(
      {this.id,
      this.cFactor,
      this.cIndex,
      this.date,
      this.hour,
      this.meterId,
      this.pressure,
      this.temp,
      this.unCIndex,
      this.volume});

  factory DataHourlyUsage.fromJson(Map<String, dynamic> json) {
    return DataHourlyUsage(
        id: json['id'],
        date: json['date'],
        meterId: json['meter_id'],
        pressure: json['pressure'],
        cFactor: json['correction_factor'],
        cIndex: json['corrected_index'],
        unCIndex: json['uncorrected_index'],
        temp: json['temperature'],
        volume: json['volume'],
        hour: json['hour']);
  }
}

class PagingHourlyUsage {
  String current;
  String prev;
  String next;
  int count;

  PagingHourlyUsage({this.count, this.current, this.next, this.prev});

  factory PagingHourlyUsage.fromJson(Map<String, dynamic> json) {
    return PagingHourlyUsage(
      count: json['count'],
      prev: json['prev'],
      next: json['next'],
      current: json['current'],
    );
  }
}
