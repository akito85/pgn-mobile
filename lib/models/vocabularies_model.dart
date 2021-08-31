class GetVocabularies {
  List<DataVocabularies> data;

  GetVocabularies({this.data});

  factory GetVocabularies.fromJson(Map<String, dynamic> json){
    return GetVocabularies(
      data : parseDataSpbg(json['data']),
    );
  }

  static List<DataVocabularies> parseDataSpbg(datasJson){
    var list = datasJson as List;
    List<DataVocabularies> datasVocabularies = 
    list.map((data) => DataVocabularies.fromJson(data)).toList();
    return datasVocabularies;
  }
}

class DataVocabularies{
  String id;
  String title;

  DataVocabularies({this.id, this.title});

  factory DataVocabularies.fromJson(Map<String, dynamic> json){
    return DataVocabularies(
      id: json['id'],
      title: json['title'],
    );
  }

}

class GetVocabularieDetail{
  DataVocabularieDetail data;

  GetVocabularieDetail({this.data});

  factory GetVocabularieDetail.fromJson(Map<String, dynamic> json){
    return GetVocabularieDetail(
      data: DataVocabularieDetail.fromJson(json['data'])
    );
  }
}

class DataVocabularieDetail{
  String title;
  String description;
  String imageUrl;

  DataVocabularieDetail({this.title, this.description, this.imageUrl});

  factory DataVocabularieDetail.fromJson(Map<String, dynamic> json){
    return DataVocabularieDetail(
      imageUrl: json['image_url'],
      title: json['title'],
      description: json['description'],
    );
  }
}