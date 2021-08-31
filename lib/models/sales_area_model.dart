class GetSalesArea {
  DataSalesArea data;
  MetaSalesArea meta;

  GetSalesArea({this.data, this.meta});

  factory GetSalesArea.fromJson(Map<String, dynamic> json){
    return GetSalesArea(
      data: DataSalesArea.fromJson(json['data']),
      meta: MetaSalesArea.fromJson(json['meta'])
    );
  }
}

class DataSalesArea {
  int totalCustomer;
  TotalVolume totalVolume;
  TotalEnergy totalEnergy;
  List<ChartSalesArea> chart;

  DataSalesArea({this.chart, this.totalCustomer, this.totalEnergy,
  this.totalVolume});

  factory DataSalesArea.fromJson(Map<String, dynamic> json){
    return DataSalesArea(
      totalCustomer: json['total_customer'],
      totalVolume: TotalVolume.fromJson(json['total_volume']),
      totalEnergy: TotalEnergy.fromJson(json['total_energy']),
      chart: parseDataChartSectorInd(json['chart'])
    );
  }

  static List<ChartSalesArea> parseDataChartSectorInd(datasJson){
    var list = datasJson as List;
    List<ChartSalesArea> datasChartSectorInd = 
    list.map((data) => ChartSalesArea.fromJson(data)).toList();
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



class ChartSalesArea {
  String name;
  Energy energy;
  String percentage;

  ChartSalesArea({this.name, this.energy, this.percentage});

  factory ChartSalesArea.fromJson(Map<String, dynamic> json){
    return ChartSalesArea(
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

class MetaSalesArea {
  StartDate startDate;
  EndDate endDate;

  MetaSalesArea({this.endDate, this.startDate});

  factory MetaSalesArea.fromJson(Map<String, dynamic> json){
    return MetaSalesArea(
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