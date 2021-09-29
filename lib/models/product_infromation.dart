import 'package:pgn_mobile/models/down_usage_detail_model.dart';

class GetProductInformation {
  List<DataProduct> data;
  MetaData metaData;

  GetProductInformation({this.data, this.metaData});

  factory GetProductInformation.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return GetProductInformation(data: parseDataProduct(json['data']));
    } else {
      return GetProductInformation(metaData: json['meta']);
    }
  }

  static List<DataProduct> parseDataProduct(dataJson) {
    var list = dataJson as List;
    List<DataProduct> datasProduct =
        list.map((data) => DataProduct.fromJson(data)).toList();
    return datasProduct;
  }
}

class DataProduct {
  final int id;
  final String image;
  final String description;
  final String name;
  final String pic_name;
  final String pic_email;
  final String pic_phone;

  DataProduct(
      {this.id,
      this.image,
      this.description,
      this.name,
      this.pic_email,
      this.pic_name,
      this.pic_phone});

  factory DataProduct.fromJson(Map<String, dynamic> json) {
    return DataProduct(
        id: json['id'],
        image: json['image'],
        description: json['description'],
        name: json['name'],
        pic_email: json['pic_email'],
        pic_name: json['pic_name'],
        pic_phone: json['pic_phone']);
  }
}
