class PenghentianSementaraModel {
  List<DataPenghentianSementara> dataPenghentianSementara;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  PenghentianSementaraModel(
      {this.code, this.dataPenghentianSementara, this.message, this.nextPage});
  factory PenghentianSementaraModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return PenghentianSementaraModel(
          code: json['code'], message: json['message']);
    } else {
      return PenghentianSementaraModel(
          dataPenghentianSementara:
              parsedDataPenghentianSementara(json['data']),
          nextPage: json['next_page_url']);
    }
  }

  static List<DataPenghentianSementara> parsedDataPenghentianSementara(
      dataJson) {
    var list = dataJson as List;
    List<DataPenghentianSementara> dataPenghentianSementara =
        list.map((data) => DataPenghentianSementara.fromJson(data)).toList();
    return dataPenghentianSementara;
  }
}

class DataPenghentianSementara {
  int id;
  String idCust;
  String name;
  String reason;
  String createdAt;
  String subDateSuspend;
  String subDateEnable;
  String status;

  DataPenghentianSementara(
      {this.id,
      this.createdAt,
      this.idCust,
      this.name,
      this.reason,
      this.status,
      this.subDateSuspend,
      this.subDateEnable});

  factory DataPenghentianSementara.fromJson(Map<String, dynamic> json) {
    return DataPenghentianSementara(
      id: json['id'],
      subDateSuspend: json['submission_suspend_date'],
      status: json['progress_status'],
      reason: json['reason'],
      idCust: json['customer_id'],
      name: json['customer_name'],
      createdAt: json['created_at'],
      subDateEnable: json['submission_enable_date'],
    );
  }
}

/// MODEL SUCCES CREATE BERHENTI BERLANGGANAN
class CreatePenghentianSementara {
  DataCreate dataCreate;
  CreatePenghentianSementara({this.dataCreate});

  factory CreatePenghentianSementara.fromJson(Map<String, dynamic> json) {
    return CreatePenghentianSementara(
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

/// MODEL Get Detail Berhenti Berlangganan

class DetailPenghentianSementara {
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
  String subDateSuspend;
  String subDateEnable;
  String reason;
  String sign;
  String status;
  String createdAt;
  String npwpFile;
  String npwpNumb;
  String ktpAddress;
  String ktpFile;
  DetailPenghentianSementara(
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
      this.subDateEnable,
      this.subDateSuspend,
      this.ktpAddress,
      this.npwpFile,
      this.npwpNumb,
      this.ktpFile});
  factory DetailPenghentianSementara.fromJson(Map<String, dynamic> json) {
    return DetailPenghentianSementara(
        id: json['id'],
        subDateSuspend: json['submission_suspend_date'],
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
        subDateEnable: json['submission_enable_date'],
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
  Biaya({this.area1, this.area2, this.area3});

  factory Biaya.fromJson(Map<String, dynamic> json) {
    return Biaya(
      area1: Area1.fromJson(json['1']),
      area2: Area2.fromJson(json['2']),
      area3: Area3.fromJson(json['3']),
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
  DataPengaliaranG16 dataPengaliaranG16;
  DataPengaliaranG25 dataPengaliaranG25;
  DataPengaliaranG4 dataPengaliaranG4;
  DataPengaliaranG6 dataPengaliaranG6;
  DataPengaliaranG10 dataPengaliaranG10;
  DataPengaliaranG162 dataPengaliaranG162;
  DataPengaliaranG252 dataPengaliaranG252;

  Area1(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6,
      this.dataPengaliaranG10,
      this.dataPengaliaranG16,
      this.dataPengaliaranG162,
      this.dataPengaliaranG25,
      this.dataPengaliaranG252,
      this.dataPengaliaranG4,
      this.dataPengaliaranG6});
  factory Area1.fromJson(Map<String, dynamic> json) {
    return Area1(
        name: json['name'],
        dataPenutupanG10:
            DataPenutupanG10.fromJson(json['Penutupan Aliran Gas Meter G.10']),
        dataPenutupanG162:
            DataPenutupanG162.fromJson(json['Penutupan Aliran Gas Meter G.16']),
        dataPenutupanG16:
            DataPenutupanG16.fromJson(json['Penutupan Aliran Gas Meter G.1.6']),
        dataPenutupanG252:
            DataPenutupanG252.fromJson(json['Penutupan Aliran Gas Meter G.25']),
        dataPenutupanG25:
            DataPenutupanG25.fromJson(json['Penutupan Aliran Gas Meter G.2.5']),
        dataPenutupanG4:
            DataPenutupanG4.fromJson(json['Penutupan Aliran Gas Meter G.4']),
        dataPenutupanG6:
            DataPenutupanG6.fromJson(json['Penutupan Aliran Gas Meter G.6']),
        dataPengaliaranG10: DataPengaliaranG10.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.10']),
        dataPengaliaranG162: DataPengaliaranG162.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.16']),
        dataPengaliaranG16: DataPengaliaranG16.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.1.6']),
        dataPengaliaranG252: DataPengaliaranG252.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.25']),
        dataPengaliaranG25: DataPengaliaranG25.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.2.5']),
        dataPengaliaranG4: DataPengaliaranG4.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.4']),
        dataPengaliaranG6: DataPengaliaranG6.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.6']));
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
  DataPengaliaranG16 dataPengaliaranG16;
  DataPengaliaranG25 dataPengaliaranG25;
  DataPengaliaranG4 dataPengaliaranG4;
  DataPengaliaranG6 dataPengaliaranG6;
  DataPengaliaranG10 dataPengaliaranG10;
  DataPengaliaranG162 dataPengaliaranG162;
  DataPengaliaranG252 dataPengaliaranG252;

  Area2(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6,
      this.dataPengaliaranG10,
      this.dataPengaliaranG16,
      this.dataPengaliaranG162,
      this.dataPengaliaranG25,
      this.dataPengaliaranG252,
      this.dataPengaliaranG4,
      this.dataPengaliaranG6});
  factory Area2.fromJson(Map<String, dynamic> json) {
    return Area2(
        name: json['name'],
        dataPenutupanG10:
            DataPenutupanG10.fromJson(json['Penutupan Aliran Gas Meter G.10']),
        dataPenutupanG162:
            DataPenutupanG162.fromJson(json['Penutupan Aliran Gas Meter G.16']),
        dataPenutupanG16:
            DataPenutupanG16.fromJson(json['Penutupan Aliran Gas Meter G.1.6']),
        dataPenutupanG252:
            DataPenutupanG252.fromJson(json['Penutupan Aliran Gas Meter G.25']),
        dataPenutupanG25:
            DataPenutupanG25.fromJson(json['Penutupan Aliran Gas Meter G.2.5']),
        dataPenutupanG4:
            DataPenutupanG4.fromJson(json['Penutupan Aliran Gas Meter G.4']),
        dataPenutupanG6:
            DataPenutupanG6.fromJson(json['Penutupan Aliran Gas Meter G.6']),
        dataPengaliaranG10: DataPengaliaranG10.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.10']),
        dataPengaliaranG162: DataPengaliaranG162.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.16']),
        dataPengaliaranG16: DataPengaliaranG16.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.1.6']),
        dataPengaliaranG252: DataPengaliaranG252.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.25']),
        dataPengaliaranG25: DataPengaliaranG25.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.2.5']),
        dataPengaliaranG4: DataPengaliaranG4.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.4']),
        dataPengaliaranG6: DataPengaliaranG6.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.6']));
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
  DataPengaliaranG16 dataPengaliaranG16;
  DataPengaliaranG25 dataPengaliaranG25;
  DataPengaliaranG4 dataPengaliaranG4;
  DataPengaliaranG6 dataPengaliaranG6;
  DataPengaliaranG10 dataPengaliaranG10;
  DataPengaliaranG162 dataPengaliaranG162;
  DataPengaliaranG252 dataPengaliaranG252;

  Area3(
      {this.name,
      this.dataPenutupanG10,
      this.dataPenutupanG16,
      this.dataPenutupanG162,
      this.dataPenutupanG25,
      this.dataPenutupanG252,
      this.dataPenutupanG4,
      this.dataPenutupanG6,
      this.dataPengaliaranG10,
      this.dataPengaliaranG16,
      this.dataPengaliaranG162,
      this.dataPengaliaranG25,
      this.dataPengaliaranG252,
      this.dataPengaliaranG4,
      this.dataPengaliaranG6});
  factory Area3.fromJson(Map<String, dynamic> json) {
    return Area3(
        name: json['name'],
        dataPenutupanG10:
            DataPenutupanG10.fromJson(json['Penutupan Aliran Gas Meter G.10']),
        dataPenutupanG162:
            DataPenutupanG162.fromJson(json['Penutupan Aliran Gas Meter G.16']),
        dataPenutupanG16:
            DataPenutupanG16.fromJson(json['Penutupan Aliran Gas Meter G.1.6']),
        dataPenutupanG252:
            DataPenutupanG252.fromJson(json['Penutupan Aliran Gas Meter G.25']),
        dataPenutupanG25:
            DataPenutupanG25.fromJson(json['Penutupan Aliran Gas Meter G.2.5']),
        dataPenutupanG4:
            DataPenutupanG4.fromJson(json['Penutupan Aliran Gas Meter G.4']),
        dataPenutupanG6:
            DataPenutupanG6.fromJson(json['Penutupan Aliran Gas Meter G.6']),
        dataPengaliaranG10: DataPengaliaranG10.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.10']),
        dataPengaliaranG162: DataPengaliaranG162.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.16']),
        dataPengaliaranG16: DataPengaliaranG16.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.1.6']),
        dataPengaliaranG252: DataPengaliaranG252.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.25']),
        dataPengaliaranG25: DataPengaliaranG25.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.2.5']),
        dataPengaliaranG4: DataPengaliaranG4.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.4']),
        dataPengaliaranG6: DataPengaliaranG6.fromJson(
            json['Penutupan Aliran Gas dan Pencabutan Meter G.6']));
  }
}

class DataPenutupanG16 {
  String type;
  String cost;
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

class DataPengaliaranG16 {
  String type;
  String cost;
  DataPengaliaranG16({this.cost, this.type});
  factory DataPengaliaranG16.fromJson(Map<String, dynamic> json) {
    return DataPengaliaranG16(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPengaliaranG25 {
  String type;
  String cost;
  DataPengaliaranG25({this.cost, this.type});
  factory DataPengaliaranG25.fromJson(Map<String, dynamic> json) {
    return DataPengaliaranG25(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPengaliaranG4 {
  String type;
  String cost;
  DataPengaliaranG4({this.cost, this.type});
  factory DataPengaliaranG4.fromJson(Map<String, dynamic> json) {
    return DataPengaliaranG4(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPengaliaranG6 {
  String type;
  String cost;
  DataPengaliaranG6({this.cost, this.type});
  factory DataPengaliaranG6.fromJson(Map<String, dynamic> json) {
    return DataPengaliaranG6(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPengaliaranG10 {
  String type;
  String cost;
  DataPengaliaranG10({this.cost, this.type});
  factory DataPengaliaranG10.fromJson(Map<String, dynamic> json) {
    return DataPengaliaranG10(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPengaliaranG162 {
  String type;
  String cost;
  DataPengaliaranG162({this.cost, this.type});
  factory DataPengaliaranG162.fromJson(Map<String, dynamic> json) {
    return DataPengaliaranG162(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}

class DataPengaliaranG252 {
  String type;
  String cost;
  DataPengaliaranG252({this.cost, this.type});
  factory DataPengaliaranG252.fromJson(Map<String, dynamic> json) {
    return DataPengaliaranG252(
      cost: json['total_cost'],
      type: json['type'],
    );
  }
}
