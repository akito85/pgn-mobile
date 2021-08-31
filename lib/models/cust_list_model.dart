class CustListModel {
  List<DataListCust> data;
  PagingCust paging;
  String message;

  CustListModel({this.data, this.paging, this.message});

  factory CustListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return CustListModel(
        data: parseDataListCust(json['data']),
        paging: PagingCust.fromJson(json['paging']),
      );
    } else {
      return CustListModel(message: json['message']);
    }
  }

  static List<DataListCust> parseDataListCust(datasJson) {
    var list = datasJson as List;
    List<DataListCust> datasListCusts =
        list.map((data) => DataListCust.fromJson(data)).toList();
    return datasListCusts;
  }
}

class DataListCust {
  String id;
  String aeId;
  String name;
  String address;
  String fax;
  String phone;
  String cPersonName;
  String prod;
  String sectorIndustry;
  String imgUrl;
  String cPersonMobPhone;
  String cPersonEmail;
  LocationCustList locationCustList;

  DataListCust(
      {this.name,
      this.address,
      this.aeId,
      this.cPersonEmail,
      this.cPersonMobPhone,
      this.cPersonName,
      this.fax,
      this.id,
      this.imgUrl,
      this.phone,
      this.prod,
      this.sectorIndustry,
      this.locationCustList});

  factory DataListCust.fromJson(Map<String, dynamic> json) {
    if (json['location'] != null)
      return DataListCust(
          id: json['id'],
          aeId: json['ae_id'],
          name: json['name'],
          address: json['address'],
          fax: json['fax'],
          phone: json['phone'],
          cPersonName: json['contact_person_name'],
          prod: json['production'],
          sectorIndustry: json['sector_industry'],
          imgUrl: json['image_url'],
          cPersonMobPhone: json['contact_person_mobile_phone'],
          cPersonEmail: json['contact_person_email'],
          locationCustList: LocationCustList.fromJson(json['location']));
    else
      return DataListCust(
        id: json['id'],
        aeId: json['ae_id'],
        name: json['name'],
        address: json['address'],
        fax: json['fax'],
        phone: json['phone'],
        cPersonName: json['contact_person_name'],
        prod: json['production'],
        sectorIndustry: json['sector_industry'],
        imgUrl: json['image_url'],
        cPersonMobPhone: json['contact_person_mobile_phone'],
        cPersonEmail: json['contact_person_email'],
      );
  }
}

class PagingCust {
  String current;
  String prev;
  String next;
  int count;

  PagingCust({this.count, this.current, this.next, this.prev});

  factory PagingCust.fromJson(Map<String, dynamic> json) {
    return PagingCust(
      count: json['count'],
      prev: json['prev'],
      next: json['next'],
      current: json['current'],
    );
  }
}

class LocationCustList {
  String longitude;
  String latitude;

  LocationCustList({this.longitude, this.latitude});

  factory LocationCustList.fromJson(Map<String, dynamic> json) {
    return LocationCustList(
        latitude: json['latitude'] ?? '111',
        longitude: json['longitude'] ?? '111');
  }
}
