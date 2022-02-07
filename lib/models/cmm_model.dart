class CMMModel {
  List<DataListCMM> dataListCMM;
  String message;
  String statusCMM;

  CMMModel({this.dataListCMM, this.message, this.statusCMM});

  factory CMMModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      return CMMModel(message: json['message']);
    } else {
      return CMMModel(dataListCMM: parseDataListCMM(json['data']));
    }
  }
  static List<DataListCMM> parseDataListCMM(datasJson) {
    var list = datasJson as List;
    List<DataListCMM> dataListCMM =
        list.map((data) => DataListCMM.fromJson(data)).toList();
    return dataListCMM;
  }
}

class DataListCMM {
  String tanggal;
  String periodMonth;
  String kodeArea;
  int timeStamp;
  String kodePelanggan;
  String standAwal;
  String standAkhir;
  String selisih;
  String source;

  DataListCMM(
      {this.kodeArea,
      this.kodePelanggan,
      this.periodMonth,
      this.selisih,
      this.source,
      this.standAkhir,
      this.standAwal,
      this.tanggal});

  factory DataListCMM.fromJson(Map<String, dynamic> json) {
    return DataListCMM(
        kodeArea: json['KODE_AREA'],
        kodePelanggan: json['ID_PELANGGAN'],
        periodMonth: json['PERIOD_MONTH'],
        selisih: json['SELISIH'],
        source: json['SOURCE'],
        standAkhir: json['STAND_AKHIR'],
        tanggal: json['TANGGAL'],
        standAwal: json['STAND_AWAL']);
  }
}
