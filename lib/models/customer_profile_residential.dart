class CustomerProfileResidentialModel {
  DataCustProfileResidential data;
  String message; 

  CustomerProfileResidentialModel({this.data, this.message});

  factory CustomerProfileResidentialModel.fromJson(Map<String, dynamic>json){
    if (json['data'] != null)
    return CustomerProfileResidentialModel(
      data: DataCustProfileResidential.fromJson(json['data']),
    );
    else 
    return CustomerProfileResidentialModel(
      data: DataCustProfileResidential.fromJson(json['data']),
      message: json['message']
    );
  }
}

class DataCustProfileResidential {
  String id;
  String aeId;
  String name;
  String address;

  DataCustProfileResidential({this.address, this.id, this.name, this.aeId});

  factory DataCustProfileResidential.fromJson(Map<String, dynamic> json){
    return DataCustProfileResidential(
      id: json['id'],
      aeId: json['ae_id'],
      name: json['name'],
      address: json['address']
    );
  }
}