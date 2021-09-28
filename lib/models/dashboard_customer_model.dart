class DashboardCustomerModel {
  String message;
  int code;
  DataDashboardCustIdList dashboardCustIdList;

  DashboardCustomerModel({this.code, this.dashboardCustIdList, this.message});

  factory DashboardCustomerModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return DashboardCustomerModel(
          code: json['code'], message: json['message']);
    } else {
      return DashboardCustomerModel(
        dashboardCustIdList: DataDashboardCustIdList.fromJson(json['data']),
      );
    }
  }
}

class DataDashboardCustIdList {
  String userId;
  String selectedReqId;
  String selectedCustId;
  String selectedCustName;
  List<ListCustomerId> listCustomerId;

  DataDashboardCustIdList(
      {this.listCustomerId,
      this.selectedCustId,
      this.selectedCustName,
      this.selectedReqId,
      this.userId});
  factory DataDashboardCustIdList.fromJson(Map<String, dynamic> json) {
    return DataDashboardCustIdList(
      userId: json['user_id'],
      selectedCustId: json['selected_customer_id'],
      selectedReqId: json['selected_request_id'],
      selectedCustName: json['selected_customer_name'],
      listCustomerId: parsedDataCustId(json['customer']),
    );
  }

  static List<ListCustomerId> parsedDataCustId(datasJson) {
    var list = datasJson as List;
    List<ListCustomerId> datasCustomerId =
        list.map((data) => ListCustomerId.fromJson(data)).toList();
    return datasCustomerId;
  }
}

class ListCustomerId {
  String reqId;
  String custId;
  String nameCust;
  int verified;
  int active;
  int deleted;

  ListCustomerId(
      {this.active,
      this.custId,
      this.deleted,
      this.nameCust,
      this.reqId,
      this.verified});

  factory ListCustomerId.fromJson(Map<String, dynamic> json) {
    return ListCustomerId(
        reqId: json['request_id'],
        custId: json['customer_id'],
        nameCust: json['name'],
        verified: json['verified'],
        active: json['active'],
        deleted: json['deleted']);
  }
}

//////////////////// GET Switch Cust Model
class SwitchCustomerId {
  String message;
  int code;
  DataSwitchCustomerId dataSwitchCustomerId;

  SwitchCustomerId({this.code, this.dataSwitchCustomerId, this.message});

  factory SwitchCustomerId.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return SwitchCustomerId(code: json['code'], message: json['message']);
    } else {
      return SwitchCustomerId(
        dataSwitchCustomerId: DataSwitchCustomerId.fromJson(json['data']),
      );
    }
  }
}

class DataSwitchCustomerId {
  String custID;
  String message;
  String custName;
  DataSwitchCustomerId({this.custID, this.message, this.custName});

  factory DataSwitchCustomerId.fromJson(Map<String, dynamic> json) {
    return DataSwitchCustomerId(
      custID: json['customer_id'],
      message: json['message'],
      custName: json['customer_name'],
    );
  }
}
