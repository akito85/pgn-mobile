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
  final String description_id;
  final String description_en;
  final String name_en;
  final String name_id;
  final String pic_name;
  final String pic_email;
  final String pic_phone;

  DataProduct(
      {this.id,
      this.image,
      this.description_en,
      this.description_id,
      this.name_en,
      this.name_id,
      this.pic_email,
      this.pic_name,
      this.pic_phone});

  factory DataProduct.fromJson(Map<String, dynamic> json) {
    return DataProduct(
        id: json['id'],
        image: json['image'],
        description_en: json['description_en'],
        description_id: json['description_id'],
        name_en: json['name_en'],
        name_id: json['name_id'],
        pic_email: json['pic_email'],
        pic_name: json['pic_name'],
        pic_phone: json['pic_phone']);
  }
}
