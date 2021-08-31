class GetSpbg {
  List<DataSpbg> data;
  PagingSpbg paging;

  GetSpbg({this.data, this.paging});

  factory GetSpbg.fromJson(Map<String, dynamic> json){
    return GetSpbg(
      data : parseDataSpbg(json['data']),
      paging: PagingSpbg.fromJson(json['paging'])
    );
  }

  static List<DataSpbg> parseDataSpbg(datasJson){
    var list = datasJson as List;
    List<DataSpbg> datasSpbg = 
    list.map((data) => DataSpbg.fromJson(data)).toList();
    return datasSpbg;
  }
}

class DataSpbg{
  String id;
  String title;
  LocationSpbg location;
  String address;

  DataSpbg({this.address, this.id, this.title, this.location});

  factory DataSpbg.fromJson(Map<String, dynamic> json){
    return DataSpbg(
      id: json['id'],
      title: json['title'],
      address: json['address'],
      location: LocationSpbg.fromJson(json['location']),
    );
  }

}

class LocationSpbg {
  String longitude;
  String latitude;

  LocationSpbg({this.longitude, this.latitude});

  factory LocationSpbg.fromJson(Map<String, dynamic> json){
    return LocationSpbg(
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}

class PagingSpbg{
  String current;
  String prev;
  String next;
  int count;

  PagingSpbg({this.count, this.current, this.next, this.prev});

  factory PagingSpbg.fromJson(Map<String, dynamic> json){
    return PagingSpbg(
      count: json['count'],
      prev: json['prev'],
      next: json['next'],
      current: json['current'],
    );
  }
}
