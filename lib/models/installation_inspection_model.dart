class InstallationInspectionModel {
  final String id;
  final CustomerModel customer;
  final String inspectionBy;
  final String inspectionDate;
  final String summary;
  final List<InspectionModel> inspection;
  final String acknowledgeBy;
  final String acknowledgeDate;

  InstallationInspectionModel(
      {this.id,
      this.customer,
      this.inspectionBy,
      this.inspectionDate,
      this.summary,
      this.inspection,
      this.acknowledgeBy,
      this.acknowledgeDate});

  factory InstallationInspectionModel.fromJson(Map<String, dynamic> json) {
    return InstallationInspectionModel(
        id: json['id'],
        customer: CustomerModel.fromJson(json['customer']),
        inspectionBy: json['inspected_by'],
        inspectionDate: json['inspection_date'],
        summary: json['summary'],
        inspection: parseDataJson(json['inspection']),
        acknowledgeBy: json['acknowledge_by'],
        acknowledgeDate: json['acknowledge_date']);
  }

  static List<InspectionModel> parseDataJson(data) {
    var list = data as List;
    List<InspectionModel> datas =
        list.map((datas) => InspectionModel.fromJson(datas)).toList();
    return datas;
  }
}

class CustomerModel {
  final String id;
  final String name;
  final String areaName;
  final String address;

  CustomerModel({this.id, this.name, this.areaName, this.address});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
        id: json['id'],
        name: json['name'],
        areaName: json['area_name'],
        address: json['address']);
  }
}

class InspectionModel {
  final String segment;
  final String notes;
  final List<String> item;

  InspectionModel({this.segment, this.notes, this.item});

  factory InspectionModel.fromJson(Map<String, dynamic> json) {
    return InspectionModel(
        segment: json['segment'],
        notes: json['notes'],
        item: parseDatas(json['item']));
  }

  static List<String> parseDatas(datas) {
    return new List<String>.from(datas);
  }
}
