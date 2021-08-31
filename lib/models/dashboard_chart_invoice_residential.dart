class ChartInvoiceResidential {
  List<DataChartInvoiceResi> data;
  String message;
  ChartInvoiceResidential({this.data, this.message});

  factory ChartInvoiceResidential.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return ChartInvoiceResidential(data: parseDataChartUsd(json['data']));
    else
      return ChartInvoiceResidential(message: json['message']);
  }

  static List<DataChartInvoiceResi> parseDataChartUsd(datasJson) {
    var list = datasJson as List;
    List<DataChartInvoiceResi> datasChartInvoiceRei =
        list.map((data) => DataChartInvoiceResi.fromJson(data)).toList();
    return datasChartInvoiceRei;
  }
}

class DataChartInvoiceResi {
  String value;
  String dateVal;

  DataChartInvoiceResi({this.value, this.dateVal});

  factory DataChartInvoiceResi.fromJson(Map<String, dynamic> json) {
    return DataChartInvoiceResi(
      value: json['total_bill_idr'], 
      dateVal: json['custom_invoice_period']
    );
  }
}