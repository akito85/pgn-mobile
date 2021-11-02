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
  String id;
  int userId;
  String formId;
  String status;
  String name;
  String idCardNumber;

  String katPelanggan;
  String program;
  String reqType;
  int quotaYear;
  String bookNumb;

  String jenisBangunan;
  String registerDate;
  String rejectedDate;

  DataSubscription(
      {this.id,
      this.userId,
      this.formId,
      this.status,
      this.name,
      this.idCardNumber,
      this.katPelanggan,
      this.program,
      this.reqType,
      this.quotaYear,
      this.bookNumb,
      this.registerDate,
      this.rejectedDate});
  factory DataSubscription.fromJson(Map<String, dynamic> json) {
    return DataSubscription(
        id: json['id'],
        // userId: json['user_id'],
        formId: json['form_id'],
        status: json['status'],
        name: json['name'],
        idCardNumber: json['idcard_number'],
        katPelanggan: json['kelompok_pelanggan'],
        registerDate: json['registered_date'],
        rejectedDate: json['rejected_date']);
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

/////////// PROGRESS BERLANGGANAN DETAIL

class SubsProgDetail {
  List<DataDetailProg> dataDetailProg;
  String message;
  int code;

  SubsProgDetail({this.code, this.dataDetailProg, this.message});
  factory SubsProgDetail.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return SubsProgDetail(code: json['code'], message: json['message']);
    } else {
      return SubsProgDetail(
          dataDetailProg: parsedDetailDataSubsProg(json['data']));
    }
  }

  static List<DataDetailProg> parsedDetailDataSubsProg(dataJson) {
    var list = dataJson as List;
    List<DataDetailProg> detailDataSubsProg =
        list.map((data) => DataDetailProg.fromJson(data)).toList();
    return detailDataSubsProg;
  }
}

class DataDetailProg {
  String id;
  String formId;
  String name;
  String kelPelanggan;
  String idCardNumb;
  String regDate;
  String verDate;
  String bbgDate;
  String jarfasDate;
  String gasDate;
  String rejectedDate;
  String custId;
  String regBy;
  String verBy;
  String jarfasBy;
  String gasInBy;
  String rejectedBy;
  String status;

  DataDetailProg(
      {this.bbgDate,
      this.custId,
      this.formId,
      this.gasDate,
      this.gasInBy,
      this.id,
      this.idCardNumb,
      this.jarfasBy,
      this.jarfasDate,
      this.kelPelanggan,
      this.name,
      this.regBy,
      this.regDate,
      this.rejectedBy,
      this.rejectedDate,
      this.status,
      this.verBy,
      this.verDate});

  factory DataDetailProg.fromJson(Map<String, dynamic> json) {
    return DataDetailProg(
        id: json['id'],
        formId: json['form_id'],
        name: json['name'],
        kelPelanggan: json['kelompok_pelanggan'],
        idCardNumb: json['idcard_number'],
        regDate: json['registered_date'],
        verDate: json['verified_date'],
        bbgDate: json['bbg_issued_date'],
        jarfasDate: json['jarfas_date'],
        gasDate: json['gas_in_date'],
        rejectedDate: json['rejected_date'],
        custId: json['customer_id'],
        regBy: json['registered_by'],
        verBy: json['verified_by'],
        jarfasBy: json['jarfas_by'],
        gasInBy: json['gas_in_by'],
        rejectedBy: json['rejected_by'],
        status: json['status']);
  }
}
