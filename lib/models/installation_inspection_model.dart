class InstallationInspectionModel {
  String id;
  CustomerModel customer;
  String inspectionBy;
  String inspectionDate;
  String summary;
  InstallationInspectionModel(
      {this.id,
      this.customer,
      this.inspectionBy,
      this.inspectionDate,
      this.summary});

  factory InstallationInspectionModel.fromJson(Map<String, dynamic> json) {
    return InstallationInspectionModel(
        id: json['id'],
        customer: CustomerModel.fromJson(json['customer']),
        inspectionBy: json['inspected_by'],
        inspectionDate: json['inspection_date'],
        summary: json['summary']);
  }
}

class CustomerModel {
  String id;
  String name;
  String areaName;
  String address;

  CustomerModel({this.id, this.name, this.areaName, this.address});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
        id: json['id'],
        name: json['name'],
        areaName: json['area_name'],
        address: json['address']);
  }
}
