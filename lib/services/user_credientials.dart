import 'package:flutter/material.dart';

class UserCred extends ChangeNotifier {
  String accessToken,
      tokenType,
      verStatusNextAction,
      verStatusOtpTypeId,
      verStatusRequestCode,
      custId,
      custName,
      userName,
      userId,
      userEmail,
      userType,
      userGroupId,
      customerGroupId;

  void userCred(
      {String accessToken,
      String tokenType,
      String verStatusNextAction,
      String verStatusOtpTypeId,
      String verStatusRequestCode,
      String custId,
      String custName,
      String customerGroupId,
      String userName,
      String userId,
      String userEmail,
      String userType,
      String userGroupId}) {
    this.accessToken = accessToken;
    this.tokenType = tokenType;
    this.verStatusNextAction = verStatusNextAction;
    this.verStatusOtpTypeId = verStatusOtpTypeId;
    this.verStatusRequestCode = verStatusRequestCode;
    this.custId = custId;
    this.custName = custName;
    this.customerGroupId = customerGroupId;
    this.userName = userName;
    this.userId = userId;
    this.userEmail = userEmail;
    this.userType = userType;
    this.userGroupId = userGroupId;
  }
}
