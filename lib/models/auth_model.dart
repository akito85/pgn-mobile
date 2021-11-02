class AuthSales {
  String accessToken;
  String tokenType;
  int expiresIn;
  String refreashToken;
  String customerId;
  User user;
  String message;
  VerificationStatus verificationStatus;
  Customer customer;
  String product;
  List<Menus> menus;

  AuthSales(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.refreashToken,
      this.customerId,
      this.verificationStatus,
      this.user,
      this.customer,
      this.message,
      this.product,
      this.menus});

  factory AuthSales.fromJson(Map<String, dynamic> json) {
    if (json['customer'] != null) {
      print("ISI CUSTOMER DARI MODEL: ${json['customer']}");
      return AuthSales(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        refreashToken: json['refresh_token'],
        customerId: json['customer_id'],
        verificationStatus:
            VerificationStatus.fromJson(json['verification_status']),
        customer: Customer.fromJson(json['customer']),
        user: User.fromJson(json['user']),
        product: json['product'],
        menus: parsedJsonMenus(json['menus']),
      );
    } else if (json['message'] != null) {
      return AuthSales(message: json['message']);
    } else {
      print("Tanpa CUSTOMER");
      print("Customer dari MODEL: ${json['customer']}");
      return AuthSales(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        refreashToken: json['refresh_token'],
        customerId: json['customer_id'],
        verificationStatus:
            VerificationStatus.fromJson(json['verification_status']),
        user: User.fromJson(json['user']),
        menus: parsedJsonMenus(json['menus']),
      );
    }
  }

  static List<Menus> parsedJsonMenus(datasJson) {
    var list = datasJson as List;
    List<Menus> datasMenus = list.map((data) => Menus.fromJson(data)).toList();
    return datasMenus;
  }
}

class Menus {
  int id;

  Menus({this.id});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(id: json['id']);
  }
}

class AuthSalesRegit {
  String message;
  String accessToken;
  String tokenType;
  int expiresIn;
  String refreashToken;
  String customerId;
  // Customer customer;

  AuthSalesRegit(
      {this.message,
      this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.refreashToken,
      this.customerId});

  factory AuthSalesRegit.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null)
      return AuthSalesRegit(message: json['message']);
    else
      return AuthSalesRegit(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        refreashToken: json['refresh_token'],
        customerId: json['customer_id'],
      );
  }
}

class VerificationStatus {
  String nextAction;
  String nextOtpTypeId;
  String message;
  String requestCode;
  String expiredDate;
  int resendCountLeft;

  VerificationStatus(
      {this.nextAction,
      this.nextOtpTypeId,
      this.message,
      this.expiredDate,
      this.requestCode,
      this.resendCountLeft});

  factory VerificationStatus.fromJson(Map<String, dynamic> json) {
    return VerificationStatus(
        nextAction: json['next_action'],
        nextOtpTypeId: json['next_otp_transaction_type_id'],
        message: json['message'],
        requestCode: json['request_code'],
        expiredDate: json['expired_date'],
        resendCountLeft: json['resend_count_left']);
  }
}

class Customer {
  String custId;
  String custName;
  String custAreaId;
  String custAeId;
  int groupId;

  Customer(
      {this.groupId,
      this.custAeId,
      this.custAreaId,
      this.custId,
      this.custName});

  factory Customer.fromJson(Map<String, dynamic> json) {
    print("CUST ID DARI MODEL: ${json['id']}");
    return Customer(
        custId: json['id'],
        custName: json['name'],
        custAreaId: json['area_id'],
        custAeId: json['ae_id'],
        groupId: json['group_id']);
  }
}

class User {
  String userID;
  String userName;
  String userEmail;
  String userMobilePhone;
  bool statusVerifyMobile;
  bool statusVerifyEmail;
  int userType;
  String userGroupId;

  User(
      {this.statusVerifyEmail,
      this.statusVerifyMobile,
      this.userEmail,
      this.userGroupId,
      this.userID,
      this.userMobilePhone,
      this.userName,
      this.userType});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userID: json['id'],
        userEmail: json['email'],
        userName: json['name'],
        userType: json['type'],
        userGroupId: json['usergroup_id'],
        userMobilePhone: json['mobile_phone'],
        statusVerifyEmail: json['is_email_verified'],
        statusVerifyMobile: json['is_mobile_phone_verified']);
  }
}

////////////////////////////////////////////////////////////////////
class PostRegisterResidential {
  String formId;
  bool status;
  int code;
  String message; //"gas tool usages wajib diisi."
  PostRegisterResidential({this.code, this.formId, this.message, this.status});

  factory PostRegisterResidential.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return PostRegisterResidential(
          code: json['code'], message: json['message']);
    } else {
      return PostRegisterResidential(
          formId: json['form_id'], status: json['status']);
    }
  }
}

class RegisteraUserPGN {
  int code;
  String message; //"gas tool usages wajib diisi."
  DataRegistUserPGN dataRegistUserPGN;
  RegisteraUserPGN({this.code, this.message, this.dataRegistUserPGN});

  factory RegisteraUserPGN.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      return RegisteraUserPGN(code: json['code'], message: json['message']);
    } else {
      return RegisteraUserPGN(
        dataRegistUserPGN: DataRegistUserPGN.fromJson(json['data']),
      );
    }
  }
}

class DataRegistUserPGN {
  String requestCode;
  String otpTransId;

  DataRegistUserPGN({this.otpTransId, this.requestCode});

  factory DataRegistUserPGN.fromJson(Map<String, dynamic> json) {
    return DataRegistUserPGN(
        requestCode: json['request_code'],
        otpTransId: json['otp_transaction_type_id']);
  }
}

class PostDataRegisterPGNUser {
  String accessToken;
  String customerId;
  String message;
  PostDataRegisterPGNUser({this.accessToken, this.customerId, this.message});

  factory PostDataRegisterPGNUser.fromJson(Map<String, dynamic> json) {
    return PostDataRegisterPGNUser(
        accessToken: json['access_token'],
        message: json['message'],
        customerId: json['customer_id']);
  }
}

class ResetPassword {
  String status;
  String message;

  ResetPassword({this.message, this.status});

  factory ResetPassword.fromJson(Map<String, dynamic> json) {
    return ResetPassword(status: json['status'], message: json['message']);
  }
}

class AuthCredClient {
  String accessToken;

  AuthCredClient({this.accessToken});

  factory AuthCredClient.fromJson(Map<String, dynamic> json) {
    return AuthCredClient(accessToken: json['access_token']);
  }
}

/////////////////////////
class ResetPass {
  String message;

  ResetPass({this.message});

  factory ResetPass.fromJson(Map<String, dynamic> json) {
    return ResetPass(message: json['message']);
  }
}

///////////////////////////////////////
class EquipmentData {
  String name;
  String fuelID;
  String fuelCOnsMont;
  String pressure;
  String pressureUnit;
  String totalWorkHours;
  String totalWorkDays;
  String estimationDate;
  EquipmentData(
      this.name,
      this.estimationDate,
      this.fuelCOnsMont,
      this.pressure,
      this.totalWorkDays,
      this.totalWorkHours,
      this.fuelID,
      this.pressureUnit);
  // EquipmentData.empty();
}
