
class MonthlyUsageTrend {
  List<UsageTrendChar> data;
  String message;
  MetaDataUsageTrend meta;

  MonthlyUsageTrend({this.data, this.meta, this.message});

  factory MonthlyUsageTrend.fromJson(Map<String, dynamic> json){
    if (json['data'] != null)
    return MonthlyUsageTrend( 
      data: parseDataUsageTrend(json['data']),
      meta: MetaDataUsageTrend.fromJson(json['meta'])
    );
    else
    return MonthlyUsageTrend(
      message: json['message']
    );
  }

  static List<UsageTrendChar> parseDataUsageTrend(datasJson){
    var list = datasJson as List;
    List<UsageTrendChar> datasUsageTrend = 
    list.map((data) => UsageTrendChar.fromJson(data)).toList();
    return datasUsageTrend;
  }
}

class UsageTrendChar{
  Usage usage;
  DateUsageTrend date;

  UsageTrendChar({this.usage, this.date});

  factory UsageTrendChar.fromJson(Map<String, dynamic> json){
    return UsageTrendChar(
      usage: Usage.fromJson(json['usage']),
      date: DateUsageTrend.fromJson(json['date'])
    );
  }
}

class Usage{
  int value;
  String display;

  Usage ({this.display, this.value});

  factory Usage.fromJson(Map<String, dynamic>json){
    return Usage(
      value: json['value'],
      display: json['display']
    );
  }
}

class DateUsageTrend{
  String value;
  String display;

  DateUsageTrend ({this.display, this.value});

  factory DateUsageTrend.fromJson(Map<String, dynamic>json){
    return DateUsageTrend(
      value: json['value'],
      display: json['display']
    );
  }
}

class MetaDataUsageTrend{
  StartDate startDate;
  EndDate endDate;

  MetaDataUsageTrend({this.endDate, this.startDate});

  factory MetaDataUsageTrend.fromJson(Map<String, dynamic>json){
    return MetaDataUsageTrend(
      startDate: StartDate.fromJson(json['start_date']),
      endDate: EndDate.fromJson(json['end_date'])
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

//////////////////////////////////////////////////////////////////////
class SalesUsageTrend {
   List<SalesTrendChar> data;
   String message;
  MetaDataSalesTrend meta;

  SalesUsageTrend({this.data, this.meta, this.message});

  factory SalesUsageTrend.fromJson(Map<String, dynamic> json){
    if (json['data'] != null)
    return SalesUsageTrend(
      data: parseDataUsageTrend(json['data']),
      meta: MetaDataSalesTrend.fromJson(json['meta'])
    );
    else
    return SalesUsageTrend(
      message: json['message']
    );
  }

  static List<SalesTrendChar> parseDataUsageTrend(datasJson){
    var list = datasJson as List;
    List<SalesTrendChar> datasUsageTrend = 
    list.map((data) => SalesTrendChar.fromJson(data)).toList();
    return datasUsageTrend;
  }
}

class SalesTrendChar{
  MaxUsageSales maxUsage;
  MinUsageSales minUsage;
  UsageSales usageSales;
  DateSalesTrend date;
  AccumulatedUsage accumulatedUsage;

  SalesTrendChar({this.accumulatedUsage, this.maxUsage, this.minUsage, this.usageSales, this.date});

  factory SalesTrendChar.fromJson(Map<String, dynamic>json){
    return SalesTrendChar(
      maxUsage: MaxUsageSales.fromJson(json['max_usage']),
      minUsage: MinUsageSales.fromJson(json['min_usage']),
      usageSales: UsageSales.fromJson(json['usage']),
      date: DateSalesTrend.fromJson(json['date']),
      accumulatedUsage: AccumulatedUsage.fromJson(json['accumulated_usage'])
    );
  }
}

class MaxUsageSales {
  int valueEnd;
  String displayEnd;

  MaxUsageSales({this.displayEnd, this.valueEnd});

  factory MaxUsageSales.fromJson(Map<String, dynamic> json){
    return MaxUsageSales(
      valueEnd: json['value'],
      displayEnd: json['display']
    );
  }
}

class MinUsageSales {
  int valueEnd;
  String displayEnd;

  MinUsageSales({this.displayEnd, this.valueEnd});

  factory MinUsageSales.fromJson(Map<String, dynamic> json){
    return MinUsageSales(
      valueEnd: json['value'],
      displayEnd: json['display']
    );
  }
}

class UsageSales {
  int valueEnd;
  String displayEnd;

  UsageSales({this.displayEnd, this.valueEnd});

  factory UsageSales.fromJson(Map<String, dynamic> json){
    return UsageSales(
      valueEnd: json['value'],
      displayEnd: json['display']
    );
  }
}

class AccumulatedUsage {
  int valueEnd;
  String displayEnd;

  AccumulatedUsage({this.displayEnd, this.valueEnd});

  factory AccumulatedUsage.fromJson(Map<String, dynamic> json){
    return AccumulatedUsage(
      valueEnd: json['value'],
      displayEnd: json['display']
    );
  }
}

class DateSalesTrend{
  String value;
  String display;

  DateSalesTrend ({this.display, this.value});

  factory DateSalesTrend.fromJson(Map<String, dynamic>json){
    return DateSalesTrend(
      value: json['value'],
      display: json['display']
    );
  }
}

class MetaDataSalesTrend{
  StartDate startDate;
  EndDate endDate;

  MetaDataSalesTrend({this.endDate, this.startDate});

  factory MetaDataSalesTrend.fromJson(Map<String, dynamic>json){
    return MetaDataSalesTrend(
      startDate: StartDate.fromJson(json['start_date']),
      endDate: EndDate.fromJson(json['end_date'])
    );
  }
}

class StartDateSales {
  String valueStart;
  String displayStart;

  StartDateSales({this.displayStart, this.valueStart});

  factory StartDateSales.fromJson(Map<String, dynamic> json){
    return StartDateSales(
      valueStart: json['value'],
      displayStart: json['display']
    );
  }
}

class EndDateSales {
  String valueEnd;
  String displayEnd;

  EndDateSales({this.displayEnd, this.valueEnd});

  factory EndDateSales.fromJson(Map<String, dynamic> json){
    return EndDateSales(
      valueEnd: json['value'],
      displayEnd: json['display']
    );
  }
}
