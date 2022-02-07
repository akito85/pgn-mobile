class PemasanganKembaliModel {
  List<Datas> data;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  PemasanganKembaliModel({this.code, this.data, this.message, this.nextPage});
  factory PemasanganKembaliModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return PemasanganKembaliModel(
          code: json['code'], message: json['message']);
    } else {
      return PemasanganKembaliModel(
          data: parsedDataPemasanganKembali(json['data']),
          nextPage: json['next_page_url']);
    }
  }

  static List<Datas> parsedDataPemasanganKembali(dataJson) {
    var list = dataJson as List;
    List<Datas> datas = list.map((data) => Datas.fromJson(data)).toList();
    return datas;
  }
}

class Datas {
  int id;
  String idCust;
  String name;
  String reason;
  String createdAt;
  String subDate;
  String status;

  Datas(
      {this.id,
      this.createdAt,
      this.idCust,
      this.name,
      this.reason,
      this.status,
      this.subDate});

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
      id: json['id'],
      subDate: json['submission_date'],
      status: json['progress_status'],
      reason: json['reason'],
      idCust: json['customer_id'],
      name: json['customer_name'],
      createdAt: json['created_at'],
    );
  }
}

/// MODEL SUCCES CREATE PEMASANGAN KEMBALI
class Create {
  DataCreate dataCreate;
  Create({this.dataCreate});

  factory Create.fromJson(Map<String, dynamic> json) {
    return Create(
      dataCreate: DataCreate.fromJson(json['data']),
    );
  }
}

class DataCreate {
  String message;
  String formId;
  DataCreate({this.message, this.formId});

  factory DataCreate.fromJson(Map<String, dynamic> json) {
    if (json['report_number'] != null)
      return DataCreate(
          message: json['message'], formId: json['report_number']);

    return DataCreate(
      message: json['message'],
    );
  }
}

/// MODEL Get Detail Pemasangan kembali

class DetailData {
  int id;
  String custId;
  String custName;
  String gender;
  String bPlace;
  String bDate;
  String nik;
  String email;
  String phoneNumb;
  String address;
  String street;
  String rt;
  String rw;
  String kelurahan;
  String kecamatan;
  String kabupaten;
  String prov;
  String postalCode;
  String long;
  String lat;
  String locStat;
  String subDate;
  String reason;
  String sign;
  String status;
  String createdAt;
  String npwpFile;
  String npwpNumb;
  String ktpAddress;
  String ktpFile;
  DetailData(
      {this.address,
      this.bDate,
      this.bPlace,
      this.createdAt,
      this.custId,
      this.custName,
      this.email,
      this.gender,
      this.id,
      this.kecamatan,
      this.kabupaten,
      this.kelurahan,
      this.lat,
      this.locStat,
      this.long,
      this.nik,
      this.phoneNumb,
      this.postalCode,
      this.prov,
      this.reason,
      this.rt,
      this.rw,
      this.sign,
      this.status,
      this.street,
      this.subDate,
      this.ktpAddress,
      this.npwpFile,
      this.npwpNumb,
      this.ktpFile});
  factory DetailData.fromJson(Map<String, dynamic> json) {
    return DetailData(
        id: json['id'],
        subDate: json['submission_date'],
        status: json['progress_status'],
        reason: json['reason'],
        custId: json['customer_id'],
        custName: json['customer_name'],
        createdAt: json['created_at'],
        bDate: json['birth_date'],
        bPlace: json['birth_place'],
        gender: json['gender'],
        nik: json['id_card_number'],
        lat: json['latitude'],
        long: json['longitude'],
        rt: json['rt'],
        rw: json['rw'],
        kabupaten: json['kota_kabupaten'],
        sign: json['customer_signature'],
        street: json['street'],
        locStat: json['person_in_location_status'],
        kecamatan: json['kecamatan'],
        kelurahan: json['kelurahan'],
        phoneNumb: json['phone_number'],
        postalCode: json['postal_code'],
        prov: json['province'],
        address: json['address'],
        email: json['email'],
        npwpFile: json['npwp_file'],
        npwpNumb: json['npwp_number'],
        ktpAddress: json['ktp_address'],
        ktpFile: json['ktp_file']);
  }
}

class Biaya {
  Area1 area1;
  Area2 area2;
  Area3 area3;
  Area4 area4;
  Area5 area5;
  Area6 area6;
  Area7 area7;
  Area8 area8;
  Area9 area9;
  Area10 area10;
  Area11 area11;
  Area12 area12;
  Area13 area13;
  Biaya(
      {this.area1,
      this.area2,
      this.area3,
      this.area4,
      this.area10,
      this.area11,
      this.area12,
      this.area13,
      this.area5,
      this.area6,
      this.area7,
      this.area8,
      this.area9});

  factory Biaya.fromJson(Map<String, dynamic> json) {
    return Biaya(
      area1: Area1.fromJson(json['1']),
      area2: Area2.fromJson(json['2']),
      area3: Area3.fromJson(json['3']),
      area4: Area4.fromJson(json['4']),
      area5: Area5.fromJson(json['5']),
      area6: Area6.fromJson(json['6']),
      area7: Area7.fromJson(json['7']),
      area8: Area8.fromJson(json['8']),
      area9: Area9.fromJson(json['9']),
      area10: Area10.fromJson(json['10']),
      area11: Area11.fromJson(json['11']),
      area12: Area12.fromJson(json['12']),
      area13: Area13.fromJson(json['13']),
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
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
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
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
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
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area4 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area4(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area4.fromJson(Map<String, dynamic> json) {
    return Area4(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area5 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area5(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area5.fromJson(Map<String, dynamic> json) {
    return Area5(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area6 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area6(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area6.fromJson(Map<String, dynamic> json) {
    return Area6(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area7 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area7(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area7.fromJson(Map<String, dynamic> json) {
    return Area7(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area8 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area8(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area8.fromJson(Map<String, dynamic> json) {
    return Area8(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area9 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area9(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area9.fromJson(Map<String, dynamic> json) {
    return Area9(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area10 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area10(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area10.fromJson(Map<String, dynamic> json) {
    return Area10(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area11 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area11(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area11.fromJson(Map<String, dynamic> json) {
    return Area11(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area12 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area12(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area12.fromJson(Map<String, dynamic> json) {
    return Area12(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
    );
  }
}

class Area13 {
  String name;
  DataPenutupanG16 dataPenutupanG16;
  DataPenutupanG25 dataPenutupanG25;
  DataPenutupanG4 dataPenutupanG4;
  DataPenutupanG6 dataPenutupanG6;
  DataPenutupanG10 dataPenutupanG10;
  DataPenutupanG162 dataPenutupanG162;
  DataPenutupanG252 dataPenutupanG252;

  Area13(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6});
  factory Area13.fromJson(Map<String, dynamic> json) {
    return Area13(
      name: json['name'],
      dataPenutupanG10: DataPenutupanG10.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.10']),
      dataPenutupanG162: DataPenutupanG162.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.16']),
      dataPenutupanG16: DataPenutupanG16.fromJson(
          json["Pemasangan Kembali Pelanggan Meter G.1.6"]),
      dataPenutupanG252: DataPenutupanG252.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.25']),
      dataPenutupanG25: DataPenutupanG25.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.2.5']),
      dataPenutupanG4: DataPenutupanG4.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.4']),
      dataPenutupanG6: DataPenutupanG6.fromJson(
          json['Pemasangan Kembali Pelanggan Meter G.6']),
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
