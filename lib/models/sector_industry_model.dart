class GetSectorIndustry {
  DataSectorIndustry data;
  MetaSectorIndustry meta;

  GetSectorIndustry({this.data, this.meta});

  factory GetSectorIndustry.fromJson(Map<String, dynamic> json){
    return GetSectorIndustry(
      data: DataSectorIndustry.fromJson(json['data']),
      meta: MetaSectorIndustry.fromJson(json['meta'])
    );
  }
}

class DataSectorIndustry {
  int totalCustomer;
  TotalVolume totalVolume;
  TotalEnergy totalEnergy;
  List<ChartSectorInd> chart;

  DataSectorIndustry({this.chart, this.totalCustomer, this.totalEnergy,
  this.totalVolume});

  factory DataSectorIndustry.fromJson(Map<String, dynamic> json){
    return DataSectorIndustry(
      totalCustomer: json['total_customer'],
      totalVolume: TotalVolume.fromJson(json['total_volume']),
      totalEnergy: TotalEnergy.fromJson(json['total_energy']),
      chart: parseDataChartSectorInd(json['chart'])
    );
  }

  static List<ChartSectorInd> parseDataChartSectorInd(datasJson){
    var list = datasJson as List;
    List<ChartSectorInd> datasChartSectorInd = 
    list.map((data) => ChartSectorInd.fromJson(data)).toList();
    return datasChartSectorInd;
  }
}

class TotalVolume {
  int value;
  String display;

  TotalVolume({this.display, this.value});

  factory TotalVolume.fromJson(Map<String, dynamic> json){
    return TotalVolume(
      value: json['value'],
      display: json['display']
    );
  }
}

class TotalEnergy {
  int value;
  String display;

  TotalEnergy({this.display, this.value});

  factory TotalEnergy.fromJson(Map<String, dynamic> json){
    return TotalEnergy(
      value: json['value'],
      display: json['display']
    );
  }
}



class ChartSectorInd {
  String name;
  Energy energy;
  String percentage;

  ChartSectorInd({this.name, this.energy, this.percentage});

  factory ChartSectorInd.fromJson(Map<String, dynamic> json){
    return ChartSectorInd(
      name: json['name'],
      energy: Energy.fromJson(json['energy']),
      percentage: json['percentage']
    );
  }
}

class Energy{
  int value;
  String display;

  Energy({this.value, this.display});

  factory Energy.fromJson(Map<String, dynamic> json){
    return Energy(
        value: json['value'],
        display: json['display']
    );
  }
}

class MetaSectorIndustry {
  StartDate startDate;
  EndDate endDate;

  MetaSectorIndustry({this.endDate, this.startDate});

  factory MetaSectorIndustry.fromJson(Map<String, dynamic> json){
    return MetaSectorIndustry(
      startDate: StartDate.fromJson(json['start_date']),
      endDate: EndDate.fromJson(json['end_date'])
    );
  }
}

class StartDate{
  String value;
  String display;

  StartDate({this.display, this.value});

  factory StartDate.fromJson(Map<String, dynamic> json){
    return StartDate(
      value: json['value'],
      display: json['display']
    );
  }
}

class EndDate{
  String value;
  String display;

  EndDate({this.display, this.value});

  factory EndDate.fromJson(Map<String, dynamic> json){
    return EndDate(
      value: json['value'],
      display: json['display']
    );
  }
}