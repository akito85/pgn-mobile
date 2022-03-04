class Biaya {
  Area1 area1;
  Area2 area2;
  Area3 area3;
  Biaya({this.area1, this.area2, this.area3});

  factory Biaya.fromJson(Map<String, dynamic> json) {
    return Biaya(
      area1: Area1.fromJson(json['1']),
      area2: Area2.fromJson(json['2']),
      area3: Area3.fromJson(json['3']),
    );
  }
}

class Area1 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area1(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area1.fromJson(Map<String, dynamic> json) {
    //print('INI JSON NYA ${json["Pemasangan Kembali Pelanggan Meter G.1.6 "]}');
    return Area1(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(json['G.1.6']),
      dataPenutupanG162: DataPenutupanG162.fromJson(json['G.2.5']),
      dataPenutupanG16: DataPenutupanG16.fromJson(json["G.4"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(json['G.6']),
      dataPenutupanG25: DataPenutupanG25.fromJson(json['G.10']),
      dataPenutupanG4: DataPenutupanG4.fromJson(json['G.16']),
      dataPenutupanG6: DataPenutupanG6.fromJson(json['G.20']),
    );
  }
}

class Area2 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area2(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area2.fromJson(Map<String, dynamic> json) {
    return Area2(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(json['G.1.6']),
      dataPenutupanG162: DataPenutupanG162.fromJson(json['G.2.5']),
      dataPenutupanG16: DataPenutupanG16.fromJson(json["G.4"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(json['G.6']),
      dataPenutupanG25: DataPenutupanG25.fromJson(json['G.10']),
      dataPenutupanG4: DataPenutupanG4.fromJson(json['G.16']),
      dataPenutupanG6: DataPenutupanG6.fromJson(json['G.20']),
    );
  }
}

class Area3 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area3(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area3.fromJson(Map<String, dynamic> json) {
    return Area3(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(json['G.1.6']),
      dataPenutupanG162: DataPenutupanG162.fromJson(json['G.2.5']),
      dataPenutupanG16: DataPenutupanG16.fromJson(json["G.4"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(json['G.6']),
      dataPenutupanG25: DataPenutupanG25.fromJson(json['G.10']),
      dataPenutupanG4: DataPenutupanG4.fromJson(json['G.16']),
      dataPenutupanG6: DataPenutupanG6.fromJson(json['G.20']),
    );
  }
}

class DataPenutupanG16 {
  String type;
  dynamic cost;
  DataPenutupanG16({this.cost, this.type});
  factory DataPenutupanG16.fromJson(Map<String, dynamic> json) {
    return DataPenutupanG16(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPenutupanG25 {
  String type;
  String cost;
  DataPenutupanG25({this.cost, this.type});
  factory DataPenutupanG25.fromJson(Map<String, dynamic> json) {
    return DataPenutupanG25(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPenutupanG4 {
  String type;
  String cost;
  DataPenutupanG4({this.cost, this.type});
  factory DataPenutupanG4.fromJson(Map<String, dynamic> json) {
    return DataPenutupanG4(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPenutupanG6 {
  String type;
  String cost;
  DataPenutupanG6({this.cost, this.type});
  factory DataPenutupanG6.fromJson(Map<String, dynamic> json) {
    return DataPenutupanG6(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPenutupanG10 {
  String type;
  String cost;
  DataPenutupanG10({this.cost, this.type});
  factory DataPenutupanG10.fromJson(Map<String, dynamic> json) {
    return DataPenutupanG10(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPenutupanG162 {
  String type;
  String cost;
  DataPenutupanG162({this.cost, this.type});
  factory DataPenutupanG162.fromJson(Map<String, dynamic> json) {
    return DataPenutupanG162(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPenutupanG252 {
  String type;
  String cost;
  DataPenutupanG252({this.cost, this.type});
  factory DataPenutupanG252.fromJson(Map<String, dynamic> json) {
    return DataPenutupanG252(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}
