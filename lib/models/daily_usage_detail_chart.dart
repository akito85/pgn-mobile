class DailyUsageDetailChart {
  List<DataDailyUsageChart> data;
  PagingDailyDetailChart paging;
  String message;
  DailyUsageDetailChart({this.data, this.paging, this.message});

  factory DailyUsageDetailChart.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return DailyUsageDetailChart(
          data: parseDataHourlyUsage(json['data']),
          paging: PagingDailyDetailChart.fromJson(json['paging']));
    else
      return DailyUsageDetailChart(message: json['message']);
  }

  static List<DataDailyUsageChart> parseDataHourlyUsage(datasJson) {
    var list = datasJson as List;
    List<DataDailyUsageChart> datasHourlyUsage =
        list.map((data) => DataDailyUsageChart.fromJson(data)).toList();
    return datasHourlyUsage;
  }
}

class DataDailyUsageChart {
  int id;
  DateDetail date;
  String meterId;
  Pressure pressure;
  String cFactor;
  CIndex cIndex;
  UnIndex unCIndex;
  Temperature temp;
  Volume volume;
  Energy energy;
  MeterCap meterCap;
  MeterStat meterStat;
  String capPercentage;

  DataDailyUsageChart(
      {this.id,
      this.cFactor,
      this.cIndex,
      this.date,
      this.meterId,
      this.pressure,
      this.temp,
      this.unCIndex,
      this.volume,
      this.capPercentage,
      this.energy,
      this.meterCap,
      this.meterStat});

  factory DataDailyUsageChart.fromJson(Map<String, dynamic> json) {
    return DataDailyUsageChart(
        id: json['id'],
        date: DateDetail.fromJson(json['date']),
        meterId: json['meter_id'],
        pressure: Pressure.fromJson(json['pressure']),
        cFactor: json['correction_factor'],
        cIndex: CIndex.fromJson(json['corrected_index']),
        unCIndex: UnIndex.fromJson(json['uncorrected_index']),
        temp: Temperature.fromJson(json['temperature']),
        volume: Volume.fromJson(json['volume']),
        energy: Energy.fromJson(json['energy']),
        meterCap: MeterCap.fromJson(json['meter_capacity']),
        meterStat: MeterStat.fromJson(json['meter_status']),
        capPercentage: json['capacity_percentage']);
  }
}

class DateDetail {
  String value;
  String display;

  DateDetail({this.value, this.display});

  factory DateDetail.fromJson(Map<String, dynamic> json) {
    return DateDetail(value: json['value'], display: json['display']);
  }
}

class Pressure {
  int value;
  String display;

  Pressure({this.value, this.display});

  factory Pressure.fromJson(Map<String, dynamic> json) {
    return Pressure(value: json['value'], display: json['display']);
  }
}

class CFactor {
  int value;
  String display;

  CFactor({this.value, this.display});

  factory CFactor.fromJson(Map<String, dynamic> json) {
    return CFactor(value: json['value'], display: json['display']);
  }
}

class CIndex {
  int value;
  String display;

  CIndex({this.value, this.display});

  factory CIndex.fromJson(Map<String, dynamic> json) {
    return CIndex(value: json['value'], display: json['display']);
  }
}

class UnIndex {
  int value;
  String display;

  UnIndex({this.value, this.display});

  factory UnIndex.fromJson(Map<String, dynamic> json) {
    return UnIndex(value: json['value'], display: json['display']);
  }
}

class Temperature {
  int value;
  String display;

  Temperature({this.value, this.display});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(value: json['value'], display: json['display']);
  }
}

class Volume {
  int value;
  String display;

  Volume({this.value, this.display});

  factory Volume.fromJson(Map<String, dynamic> json) {
    return Volume(value: json['value'], display: json['display']);
  }
}

class Energy {
  int value;
  String display;

  Energy({this.value, this.display});

  factory Energy.fromJson(Map<String, dynamic> json) {
    return Energy(value: json['value'], display: json['display']);
  }
}

class MeterCap {
  int value;
  String display;

  MeterCap({this.value, this.display});

  factory MeterCap.fromJson(Map<String, dynamic> json) {
    return MeterCap(value: json['value'], display: json['display']);
  }
}

class MeterStat {
  int value;
  String display;

  MeterStat({this.value, this.display});

  factory MeterStat.fromJson(Map<String, dynamic> json) {
    return MeterStat(value: json['value'], display: json['display']);
  }
}

class PagingDailyDetailChart {
  String current;
  String prev;
  String next;
  int count;

  PagingDailyDetailChart({this.count, this.current, this.next, this.prev});

  factory PagingDailyDetailChart.fromJson(Map<String, dynamic> json) {
    return PagingDailyDetailChart(
      count: json['count'],
      prev: json['prev'],
      next: json['next'],
      current: json['current'],
    );
  }
}
