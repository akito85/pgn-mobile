class Customer {
  DataCustomer data;
  String message;
  Customer({this.data, this.message});

  factory Customer.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return Customer(
        data: DataCustomer.fromJson(json['data']),
      );
    else
      return Customer(
        message: json['message'],
      );
  }
}

class DataCustomer {
  String custId;
  String ae_id;
  String name;
  String address;
  String fax;
  String phone;
  String contactPersonName;
  String production;
  String sectorIndustry;
  String imageUrl;
  String personNumber;
  String personEmail;
  int pointReward;
  String groupId;
  LocationCustomer location;

  DataCustomer(
      {this.custId,
      this.groupId,
      this.address,
      this.ae_id,
      this.contactPersonName,
      this.fax,
      this.imageUrl,
      this.location,
      this.name,
      this.personEmail,
      this.personNumber,
      this.phone,
      this.pointReward,
      this.production,
      this.sectorIndustry});

  factory DataCustomer.fromJson(Map<String, dynamic> json) {
    if (json['location'] != null) {
      return DataCustomer(
          // contactPersonName: json['contact_person_name'] ?? json['id'],
          // custId: json['id'],
          // personEmail: json['contact_person_email'],
          // personNumber: json['contact_person_mobile_phone'],
          sectorIndustry: json['sector_industry'],
          phone: json['phone'],
          custId: json['id'],
          pointReward: json[' '],
          production: json['production'],
          imageUrl: json['image_url'],
          ae_id: json['ae_id'],
          name: json['name'],
          address: json['address'],
          fax: json['fax'],
          location: LocationCustomer.fromJson(json['location']));
    } else {
      return DataCustomer(
        // contactPersonName: json['contact_person_name'] ?? json['id'],
        // custId: json['id'],
        // personEmail: json['contact_person_email'],
        // personNumber: json['contact_person_mobile_phone'],
        sectorIndustry: json['sector_industry'],
        phone: json['phone'],
        pointReward: json[' '],
        custId: json['id'],
        production: json['production'],
        imageUrl: json['image_url'],
        ae_id: json['ae_id'],
        name: json['name'],
        address: json['address'],
        fax: json['fax'],
      );
    }
  }
}

class LocationCustomer {
  String longitude;
  String latitude;

  LocationCustomer({this.latitude, this.longitude});

  factory LocationCustomer.fromJson(Map<String, dynamic> json) {
    return LocationCustomer(
        latitude: json['latitude'], longitude: json['longitude']);
  }
}

class GetContract {
  List<DataCustContract> data;
  PagingContract paging;
  String message;

  GetContract({this.data, this.paging, this.message});

  factory GetContract.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return GetContract(
          data: parseDataContract(json['data']),
          paging: PagingContract.fromJson(json['paging']));
    else
      return GetContract(message: json['message']);
  }

  static List<DataCustContract> parseDataContract(datasJson) {
    var list = datasJson as List;
    List<DataCustContract> datasCustomer =
        list.map((data) => DataCustContract.fromJson(data)).toList();
    return datasCustomer;
  }
}

class DataCustContract {
  String contractId;
  String numbContract;
  MinUsage minUsage;
  MaxUsage maxUsage;
  ApprovedDate approvedDate;
  StartDate startDate;
  EndDate endDate;
  String custContractID;
  StatusContract statusContract;
  String custContractName;

  DataCustContract(
      {this.approvedDate,
      this.contractId,
      this.custContractID,
      this.custContractName,
      this.endDate,
      this.maxUsage,
      this.minUsage,
      this.numbContract,
      this.startDate,
      this.statusContract});

  factory DataCustContract.fromJson(Map<String, dynamic> json) {
    return DataCustContract(
        contractId: json['id'],
        numbContract: json['number'],
        minUsage: MinUsage.fromJson(json['min_usage']),
        maxUsage: MaxUsage.fromJson(json['max_usage']),
        approvedDate: ApprovedDate.fromJson(json['approved_date']),
        startDate: StartDate.fromJson(json['start_date']),
        endDate: EndDate.fromJson(json['end_date']),
        custContractID: json['customer_id'],
        statusContract: StatusContract.fromJson(json['status']),
        custContractName: json['customer_name']);
  }
}

class MinUsage {
  int value;
  String display;

  MinUsage({this.display, this.value});

  factory MinUsage.fromJson(Map<String, dynamic> json) {
    return MinUsage(value: json['value'], display: json['display']);
  }
}

class MaxUsage {
  int value;
  String display;

  MaxUsage({this.display, this.value});

  factory MaxUsage.fromJson(Map<String, dynamic> json) {
    return MaxUsage(value: json['value'], display: json['display']);
  }
}

class ApprovedDate {
  String value;
  String display;

  ApprovedDate({this.display, this.value});

  factory ApprovedDate.fromJson(Map<String, dynamic> json) {
    return ApprovedDate(value: json['value'], display: json['display']);
  }
}

class StartDate {
  String value;
  String display;

  StartDate({this.display, this.value});

  factory StartDate.fromJson(Map<String, dynamic> json) {
    return StartDate(value: json['value'], display: json['display']);
  }
}

class EndDate {
  String value;
  String display;

  EndDate({this.display, this.value});

  factory EndDate.fromJson(Map<String, dynamic> json) {
    return EndDate(value: json['value'], display: json['display']);
  }
}

class StatusContract {
  String value;
  String display;

  StatusContract({this.display, this.value});

  factory StatusContract.fromJson(Map<String, dynamic> json) {
    return StatusContract(value: json['id'], display: json['display']);
  }
}

class PagingContract {
  String current;
  String prev;
  String next;
  int count;

  PagingContract({this.current, this.prev, this.count, this.next});

  factory PagingContract.fromJson(Map<String, dynamic> json) {
    return PagingContract(
        current: json['current'],
        prev: json['prev'],
        count: json['count'],
        next: json['next']);
  }
}

class GetGuarantees {
  List<DataCustGuarantees> data;
  PagingGuarantees paging;
  String message;

  GetGuarantees({this.data, this.paging, this.message});

  factory GetGuarantees.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return GetGuarantees(
          data: parseDataContract(json['data']),
          paging: PagingGuarantees.fromJson(json['paging']));
    else
      return GetGuarantees(message: json['message']);
  }

  static List<DataCustGuarantees> parseDataContract(datasJson) {
    var list = datasJson as List;
    List<DataCustGuarantees> datasGuarantess =
        list.map((data) => DataCustGuarantees.fromJson(data)).toList();
    return datasGuarantess;
  }
}

class DataCustGuarantees {
  String idGuarantees;
  String guratanteesNumb;
  String guaranteesPublisher;
  String guaranteesType;
  String gStartDate;
  String gEndDate;
  String gCurrency;
  String gBalance;
  bool gStatus;
  String gCustId;
  String gCustname;

  DataCustGuarantees(
      {this.gBalance,
      this.gCurrency,
      this.gCustId,
      this.gCustname,
      this.gEndDate,
      this.gStartDate,
      this.gStatus,
      this.guaranteesPublisher,
      this.guaranteesType,
      this.guratanteesNumb,
      this.idGuarantees});

  factory DataCustGuarantees.fromJson(Map<String, dynamic> json) {
    return DataCustGuarantees(
        idGuarantees: json['id'],
        guratanteesNumb: json['number'],
        guaranteesPublisher: json['publisher'],
        guaranteesType: json['type'],
        gStatus: json['status'],
        gEndDate: json['end_date'],
        gCurrency: json['currency'],
        gBalance: json['balance'],
        gStartDate: json['start_date'],
        gCustId: json['customer_id'],
        gCustname: json['customer_name']);
  }
}

class PagingGuarantees {
  String current;
  String prev;
  String next;
  int count;

  PagingGuarantees({this.current, this.prev, this.count, this.next});

  factory PagingGuarantees.fromJson(Map<String, dynamic> json) {
    return PagingGuarantees(
        current: json['current'],
        prev: json['prev'],
        count: json['count'],
        next: json['next']);
  }
}

class GetEquipCust {
  List<DataCustEquip> data;
  PagingEquip paging;
  String message;

  GetEquipCust({this.data, this.paging, this.message});

  factory GetEquipCust.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return GetEquipCust(
        data: parseDataEquip(json['data']),
        paging: PagingEquip.fromJson(json['paging']),
      );
    else
      return GetEquipCust(message: json['message']);
  }

  static List<DataCustEquip> parseDataEquip(datasJson) {
    var list = datasJson as List;
    List<DataCustEquip> datasCustomer =
        list.map((data) => DataCustEquip.fromJson(data)).toList();
    return datasCustomer;
  }
}

class DataCustEquip {
  String idEquip;
  String title;
  String minCap;
  String maxCap;
  int numbHour;
  int numbDay;
  String custId;
  String custName;

  DataCustEquip(
      {this.idEquip,
      this.title,
      this.minCap,
      this.maxCap,
      this.numbHour,
      this.numbDay,
      this.custId,
      this.custName});

  factory DataCustEquip.fromJson(Map<String, dynamic> json) {
    return DataCustEquip(
        idEquip: json['id'],
        title: json['title'],
        minCap: json['min_capacity'],
        maxCap: json['max_capacity'],
        numbHour: json['number_operation_hour'],
        numbDay: json['number_operation_day'],
        custId: json['customer_id'],
        custName: json['customer_name']);
  }
}

class PagingEquip {
  String current;
  String prev;
  String next;
  int count;

  PagingEquip({this.current, this.prev, this.count, this.next});

  factory PagingEquip.fromJson(Map<String, dynamic> json) {
    return PagingEquip(
        current: json['current'],
        prev: json['prev'],
        count: json['count'],
        next: json['next']);
  }
}
