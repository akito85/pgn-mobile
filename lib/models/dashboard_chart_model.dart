class ChartUsd {
  List<DataChartUsd> data;
  String message;
  ChartUsd({this.data, this.message});

  factory ChartUsd.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartUsd(data: parseDataChartUsd(json['data']));
    else
      return ChartUsd(message: json['message']);
  }

  static List<DataChartUsd> parseDataChartUsd(datasJson) {
    var list = datasJson as List;
    List<DataChartUsd> datasChartUsd =
        list.map((data) => DataChartUsd.fromJson(data)).toList();
    return datasChartUsd;
  }
}

class DataChartUsd {
  String value;
  int month;
  int year;

  DataChartUsd({this.value, this.month, this.year});

  factory DataChartUsd.fromJson(Map<String, dynamic> json) {
    return DataChartUsd(
        value: json['value'], month: json['month'], year: json['year']);
  }
}

//Chart IDR
class ChartIdr {
  List<DataChartIdr> data;
  String message;
  ChartIdr({this.data, this.message});

  factory ChartIdr.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartIdr(data: parseDataChartIdr(json['data']));
    else
      return ChartIdr(message: json['message']);
  }

  static List<DataChartIdr> parseDataChartIdr(datasJson) {
    // data.add(DataChartIdr(value: '', month: item.month, year: 2019));

    var list = datasJson as List;
    List<DataChartIdr> datasChartIdr =
        list.map((data) => DataChartIdr.fromJson(data)).toList();
    return datasChartIdr;
  }
}

class DataChartIdr {
  String value;
  int month;
  int year;

  DataChartIdr({this.value, this.month, this.year});

  factory DataChartIdr.fromJson(Map<String, dynamic> json) {
    return DataChartIdr(
        value: json['value'], month: json['month'], year: json['year']);
  }
}

class ChartDaily {
  List<UsageDailyChart> data;
  MetaDataDaily meta;
  String message;

  ChartDaily({this.data, this.meta, this.message});

  factory ChartDaily.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartDaily(
          data: parseDataDaily(json['data']),
          meta: MetaDataDaily.fromJson(json['meta']));
    else
      return ChartDaily(
        message: json['message'],
      );
  }

  static List<UsageDailyChart> parseDataDaily(datasJson) {
    var list = datasJson as List;
    List<UsageDailyChart> datasUsageDaily =
        list.map((data) => UsageDailyChart.fromJson(data)).toList();
    return datasUsageDaily;
  }
}

class UsageDailyChart {
  Usage usage;
  DateUsageDaily date;

  UsageDailyChart({this.usage, this.date});

  factory UsageDailyChart.fromJson(Map<String, dynamic> json) {
    return UsageDailyChart(
        usage: Usage.fromJson(json['usage']),
        date: DateUsageDaily.fromJson(json['date']));
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

class DateUsageDaily {
  String value;
  String display;

  DateUsageDaily({this.display, this.value});

  factory DateUsageDaily.fromJson(Map<String, dynamic> json) {
    return DateUsageDaily(value: json['value'], display: json['display']);
  }
}

class MetaDataDaily {
  StartDate startDate;
  EndDate endDate;

  MetaDataDaily({this.endDate, this.startDate});

  factory MetaDataDaily.fromJson(Map<String, dynamic> json) {
    return MetaDataDaily(
        startDate: StartDate.fromJson(json['start_date']),
        endDate: EndDate.fromJson(json['end_date']));
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

//MODEL CHART MONTHLY
class ChartMonthly {
  List<UsageMonthlyChart> data;
  MetaDataMonthly meta;
  String message;
  int code;

  ChartMonthly({this.data, this.meta, this.message, this.code});

  factory ChartMonthly.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartMonthly(
          data: parseDataDaily(json['data']),
          meta: MetaDataMonthly.fromJson(json['meta']));
    else
      return ChartMonthly(message: json['message'], code: json['code']);
  }

  static List<UsageMonthlyChart> parseDataDaily(datasJson) {
    var list = datasJson as List;
    List<UsageMonthlyChart> datasUsageMonthly =
        list.map((data) => UsageMonthlyChart.fromJson(data)).toList();
    return datasUsageMonthly;
  }
}

class UsageMonthlyChart {
  UsageMonthly usage;
  MonthUsageMonthly date;

  UsageMonthlyChart({this.usage, this.date});

  factory UsageMonthlyChart.fromJson(Map<String, dynamic> json) {
    return UsageMonthlyChart(
        usage: UsageMonthly.fromJson(json['usage']),
        date: MonthUsageMonthly.fromJson(json['month']));
  }
}

class UsageMonthly {
  int value;
  String display;

  UsageMonthly({this.display, this.value});

  factory UsageMonthly.fromJson(Map<String, dynamic> json) {
    return UsageMonthly(value: json['value'], display: json['display']);
  }
}

class MonthUsageMonthly {
  String value;
  String display;

  MonthUsageMonthly({this.display, this.value});

  factory MonthUsageMonthly.fromJson(Map<String, dynamic> json) {
    return MonthUsageMonthly(value: json['value'], display: json['display']);
  }
}

class MetaDataMonthly {
  StartDateMonthly startDate;
  EndDateMonthly endDate;
  TotalUsage totalUsage;

  MetaDataMonthly({this.endDate, this.startDate, this.totalUsage});

  factory MetaDataMonthly.fromJson(Map<String, dynamic> json) {
    return MetaDataMonthly(
        startDate: StartDateMonthly.fromJson(json['start_date']),
        endDate: EndDateMonthly.fromJson(json['end_date']),
        totalUsage: TotalUsage.fromJson(json['total_usage']));
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

class TotalUsage {
  int valueTUsage;
  String displayTUsage;

  TotalUsage({this.valueTUsage, this.displayTUsage});

  factory TotalUsage.fromJson(Map<String, dynamic> json) {
    return TotalUsage(
        valueTUsage: json['value'], displayTUsage: json['display']);
  }
}

// getSumChart
class UsageSumChart {
  DataUsageSum data;
  MetaDataSum meta;
  String message;

  UsageSumChart({this.data, this.meta, this.message});

  factory UsageSumChart.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return UsageSumChart(
          data: DataUsageSum.fromJson(json['data']),
          meta: MetaDataSum.fromJson(json['meta']));
    else
      return UsageSumChart(message: json['message']);
  }

  // static List<DataUsageSum> parseDataSum(datasJson){
  //   var list = datasJson as List;
  //   List<DataUsageSum> datasUsageSum =
  //   list.map((data) => DataUsageSum.fromJson(data)).toList();
  //   return datasUsageSum;
  // }
}

class DataUsageSum {
  TMinUsage totalMinUsage;
  TMaxUsage totalMaxUsage;
  EstUsage estimationUsage;
  UsageSum usageSum;
  String percentage;
  StatusSum statusSum;
  String custName;
  String pLegend;

  DataUsageSum(
      {this.custName,
      this.estimationUsage,
      this.percentage,
      this.statusSum,
      this.totalMaxUsage,
      this.totalMinUsage,
      this.usageSum,
      this.pLegend});

  factory DataUsageSum.fromJson(Map<String, dynamic> json) {
    return DataUsageSum(
        percentage: json['percentage'],
        pLegend: json['percentage_legend'],
        custName: json['customer_name'],
        totalMaxUsage: TMaxUsage.fromJson(json['total_max_usage']),
        totalMinUsage: TMinUsage.fromJson(json['total_min_usage']),
        estimationUsage: EstUsage.fromJson(json['estimation_usage']),
        usageSum: UsageSum.fromJson(json['usage']),
        statusSum: StatusSum.fromJson(json['status']));
  }
}

class TMaxUsage {
  int valueStart;
  String displayStart;

  TMaxUsage({this.displayStart, this.valueStart});

  factory TMaxUsage.fromJson(Map<String, dynamic> json) {
    return TMaxUsage(valueStart: json['value'], displayStart: json['display']);
  }
}

class TMinUsage {
  int valueStart;
  String displayStart;

  TMinUsage({this.displayStart, this.valueStart});

  factory TMinUsage.fromJson(Map<String, dynamic> json) {
    return TMinUsage(valueStart: json['value'], displayStart: json['display']);
  }
}

class EstUsage {
  int valueStart;
  String displayStart;

  EstUsage({this.displayStart, this.valueStart});

  factory EstUsage.fromJson(Map<String, dynamic> json) {
    return EstUsage(valueStart: json['value'], displayStart: json['display']);
  }
}

class UsageSum {
  int valueStart;
  String displayStart;

  UsageSum({this.displayStart, this.valueStart});

  factory UsageSum.fromJson(Map<String, dynamic> json) {
    return UsageSum(valueStart: json['value'], displayStart: json['display']);
  }
}

class StatusSum {
  String valueStart;
  String displayStart;

  StatusSum({this.displayStart, this.valueStart});

  factory StatusSum.fromJson(Map<String, dynamic> json) {
    return StatusSum(valueStart: json['id'], displayStart: json['display']);
  }
}

class MetaDataSum {
  StartDateSum startDate;
  EndDateSum endDate;

  MetaDataSum({this.endDate, this.startDate});

  factory MetaDataSum.fromJson(Map<String, dynamic> json) {
    return MetaDataSum(
        startDate: StartDateSum.fromJson(json['start_date']),
        endDate: EndDateSum.fromJson(json['end_date']));
  }
}

class StartDateSum {
  String valueStart;
  String displayStart;

  StartDateSum({this.displayStart, this.valueStart});

  factory StartDateSum.fromJson(Map<String, dynamic> json) {
    return StartDateSum(
        valueStart: json['value'], displayStart: json['display']);
  }
}

class EndDateSum {
  String valueEnd;
  String displayEnd;

  EndDateSum({this.displayEnd, this.valueEnd});

  factory EndDateSum.fromJson(Map<String, dynamic> json) {
    return EndDateSum(valueEnd: json['value'], displayEnd: json['display']);
  }
}

class UsdArea {
  List<UsdAreaData> data;
  String message;

  UsdArea({this.data, this.message});

  factory UsdArea.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return UsdArea(
        data: parseDataUsdArea(json['data']),
      );
    else
      return UsdArea(message: json['message']);
  }

  static List<UsdAreaData> parseDataUsdArea(datasJson) {
    var list = datasJson as List;
    List<UsdAreaData> datasUsdArea =
        list.map((data) => UsdAreaData.fromJson(data)).toList();
    return datasUsdArea;
  }
}

class UsdAreaData {
  String id;
  String name;
  String value;
  String percentage;

  UsdAreaData({this.id, this.name, this.value, this.percentage});
  factory UsdAreaData.fromJson(Map<String, dynamic> json) {
    return UsdAreaData(
        id: json['id'],
        name: json['name'],
        value: json['value'],
        percentage: json['percentage']);
  }
}

class IdrArea {
  List<IdrAreaData> data;

  IdrArea({this.data});

  factory IdrArea.fromJson(Map<String, dynamic> json) {
    return IdrArea(data: parseDataUsdArea(json['data']));
  }

  static List<IdrAreaData> parseDataUsdArea(datasJson) {
    var list = datasJson as List;
    List<IdrAreaData> datasUsdArea =
        list.map((data) => IdrAreaData.fromJson(data)).toList();
    return datasUsdArea;
  }
}

class IdrAreaData {
  int id;
  String name;
  String value;
  double percentage;

  IdrAreaData({this.id, this.name, this.value, this.percentage});
  factory IdrAreaData.fromJson(Map<String, dynamic> json) {
    return IdrAreaData(
        id: json['id'],
        name: json['name'],
        value: json['value'],
        percentage: json['percentage']);
  }
}

class HarianDetailCustDashboard {
  List<DataHourlyUsage> data;
  PagingHourlyUsage paging;
  String message;

  HarianDetailCustDashboard({this.data, this.message});

  factory HarianDetailCustDashboard.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return HarianDetailCustDashboard(
        data: parseDataHourlyUsage(json['data']),
        // paging: PagingHourlyUsage.fromJson(json['paging'])
      );
    else
      return HarianDetailCustDashboard(message: json['message']);
  }

  static List<DataHourlyUsage> parseDataHourlyUsage(datasJson) {
    var list = datasJson as List;
    List<DataHourlyUsage> datasHourlyUsage =
        list.map((data) => DataHourlyUsage.fromJson(data)).toList();
    return datasHourlyUsage;
  }
}

class DataHourlyUsage {
  // int id;
  DateDaily date;
  String meterId;
  Pressure pressure;
  String cFactor;
  CIndex cIndex;
  UnCIndex unCIndex;
  Temp temp;
  Volume volume;
  Energy energy;
  MeterCap meterCap;
  MeterStat meterStat;
  String capPer;

  DataHourlyUsage(
      {this.cFactor,
      this.cIndex,
      this.date,
      this.energy,
      this.meterId,
      this.pressure,
      this.temp,
      this.unCIndex,
      this.volume,
      this.meterCap,
      this.meterStat,
      this.capPer});

  factory DataHourlyUsage.fromJson(Map<String, dynamic> json) {
    return DataHourlyUsage(
      // id: json['id'],
      date: DateDaily.fromJson(json['date']),
      meterId: json['meter_id'],
      pressure: Pressure.fromJson(json['pressure']),
      cFactor: json['correction_factor'],
      cIndex: CIndex.fromJson(json['corrected_index']),
      unCIndex: UnCIndex.fromJson(json['uncorrected_index']),
      temp: Temp.fromJson(json['temperature']),
      volume: Volume.fromJson(json['volume']),
      energy: Energy.fromJson(json['energy']),
      meterCap: MeterCap.fromJson(json['meter_capacity']),
      meterStat: MeterStat.fromJson(json['meter_status']),
      capPer: json['capacity_percentage'],
    );
  }
}

class MeterStat {
  int value;
  String display;

  MeterStat({this.display, this.value});

  factory MeterStat.fromJson(Map<String, dynamic> json) {
    return MeterStat(
      value: json['value'],
      display: json['display'],
    );
  }
}

class MeterCap {
  int value;
  String display;

  MeterCap({this.display, this.value});

  factory MeterCap.fromJson(Map<String, dynamic> json) {
    return MeterCap(
      value: json['value'],
      display: json['display'],
    );
  }
}

class Energy {
  int value;
  String display;

  Energy({this.display, this.value});

  factory Energy.fromJson(Map<String, dynamic> json) {
    return Energy(
      value: json['value'] ?? '0',
      display: json['display'],
    );
  }
}

class Volume {
  int value;
  String display;

  Volume({this.display, this.value});

  factory Volume.fromJson(Map<String, dynamic> json) {
    return Volume(
      value: json['value'],
      display: json['display'],
    );
  }
}

class Temp {
  int value;
  String display;

  Temp({this.display, this.value});

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      value: json['value'],
      display: json['display'],
    );
  }
}

class UnCIndex {
  int value;
  String display;

  UnCIndex({this.display, this.value});

  factory UnCIndex.fromJson(Map<String, dynamic> json) {
    return UnCIndex(
      value: json['value'],
      display: json['display'],
    );
  }
}

class CIndex {
  int value;
  String display;

  CIndex({this.display, this.value});

  factory CIndex.fromJson(Map<String, dynamic> json) {
    return CIndex(
      value: json['value'],
      display: json['display'],
    );
  }
}

class Pressure {
  int value;
  String display;

  Pressure({this.display, this.value});

  factory Pressure.fromJson(Map<String, dynamic> json) {
    return Pressure(
      value: json['value'],
      display: json['display'],
    );
  }
}

class DateDaily {
  String value;
  String display;

  DateDaily({this.display, this.value});

  factory DateDaily.fromJson(Map<String, dynamic> json) {
    return DateDaily(
      value: json['value'],
      display: json['display'],
    );
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
