class SubscriptionsProgressModel {
  List<DataSubscription> dataSubscription;
  String message;
  int code;
  Paging paging;

  SubscriptionsProgressModel(
      {this.code, this.dataSubscription, this.message, this.paging});

  factory SubscriptionsProgressModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return SubscriptionsProgressModel(
          code: json['code'], message: json['message']);
    } else {
      return SubscriptionsProgressModel(
          dataSubscription: parsedDataSubsProg(json['data']),
          paging: Paging.fromJson(json['paging']));
    }
  }

  static List<DataSubscription> parsedDataSubsProg(dataJson) {
    var list = dataJson as List;
    List<DataSubscription> dataSubsProg =
        list.map((data) => DataSubscription.fromJson(data)).toList();
    return dataSubsProg;
  }
}

class DataSubscription {
  int id;
  int userId;
  String formId;
  String status;
  String name;
  String idCardNumber;
  String address;
  String kabupaten;
  String kecamatan;
  String kelurahan;
  String katPelanggan;
  String program;
  String reqType;
  int quotaYear;
  String bookNumb;
  String katWilayah;
  String jenisBangunan;

  DataSubscription(
      {this.id,
      this.userId,
      this.formId,
      this.status,
      this.name,
      this.idCardNumber,
      this.address,
      this.kabupaten,
      this.kecamatan,
      this.kelurahan,
      this.katPelanggan,
      this.program,
      this.reqType,
      this.quotaYear,
      this.bookNumb,
      this.katWilayah,
      this.jenisBangunan});
  factory DataSubscription.fromJson(Map<String, dynamic> json) {
    return DataSubscription(
      id: json['id'],
      userId: json['user_id'],
      formId: json['form_id'],
      status: json['status'],
      name: json['name'],
      idCardNumber: json['idcard_number'],
      address: json['address'],
      kabupaten: json['kota_kabupaten'],
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
      katPelanggan: json['kategori_pelanggan'],
      program: json['program'],
      reqType: json['jenis_rekening'],
      quotaYear: json['quota_year'],
      bookNumb: json['book_number'],
      katWilayah: json['kategori_wilayah'],
      jenisBangunan: json['jenis_bangunan'],
    );
  }
}

class Paging {
  String current;
  String next;
  int count;

  Paging({this.next, this.count, this.current});

  factory Paging.fromJson(Map<String, dynamic> json) {
    return Paging(
        current: json['current'], next: json['next'], count: json['count']);
  }
}

///////////////// Delete FormID
class DeleteFormId {
  String message;
  int code;
  DataDeleteFormId dataDeleteCustomerId;

  DeleteFormId({this.code, this.dataDeleteCustomerId, this.message});

  factory DeleteFormId.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return DeleteFormId(code: json['code'], message: json['message']);
    } else {
      return DeleteFormId(
        dataDeleteCustomerId: DataDeleteFormId.fromJson(json['data']),
      );
    }
  }
}

class DataDeleteFormId {
  String message;
  DataDeleteFormId({this.message});

  factory DataDeleteFormId.fromJson(Map<String, dynamic> json) {
    return DataDeleteFormId(
      message: json['message'],
    );
  }
}