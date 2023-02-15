// To parse this JSON data, do
//
//     final claims = claimsFromJson(jsonString);

import 'dart:convert';

List<Claims> claimsFromJson(String str) =>
    List<Claims>.from(json.decode(str).map((x) => Claims.fromJson(x)));

String claimsToJson(List<Claims> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Claims {
  Claims({
    required this.id,
    required this.claimId,
    required this.facilityId,
    required this.palletQuantity,
    required this.documentType,
    required this.claimedAmount,
    required this.paidAmount,
    required this.serviceProviderClaimId,
    required this.claimStatus,
    required this.claimType,
    required this.createdDate,
    required this.customerId,
    required this.masterAccount,
    required this.userId,
  });

  String id;
  String claimId;
  String facilityId;
  int palletQuantity;
  DocumentType documentType;
  String claimedAmount;
  String paidAmount;
  int serviceProviderClaimId;
  ClaimStatus claimStatus;
  ClaimType claimType;
  String createdDate;
  String customerId;
  String masterAccount;
  UserId userId;

  factory Claims.fromJson(Map<String, dynamic> json) => Claims(
        id: json["_id"],
        claimId: json["claimId"],
        facilityId: json["facilityId"],
        palletQuantity: json["palletQuantity"],
        documentType: documentTypeValues.map[json["documentType"]]!,
        claimedAmount: json["claimedAmount"],
        paidAmount: json["paidAmount"],
        serviceProviderClaimId: json["serviceProviderClaimId"],
        claimStatus: claimStatusValues.map[json["claimStatus"]]!,
        claimType: claimTypeValues.map[json["claimType"]]!,
        createdDate: json["createdDate"],
        customerId: json["customerId"],
        masterAccount: json["masterAccount"],
        userId: userIdValues.map[json["userId"]]!,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "claimId": claimId,
        "facilityId": facilityId,
        "palletQuantity": palletQuantity,
        "documentType": documentTypeValues.reverse[documentType],
        "claimedAmount": claimedAmount,
        "paidAmount": paidAmount,
        "serviceProviderClaimId": serviceProviderClaimId,
        "claimStatus": claimStatusValues.reverse[claimStatus],
        "claimType": claimTypeValues.reverse[claimType],
        "createdDate": createdDate,
        "customerId": customerId,
        "masterAccount": masterAccount,
        "userId": userIdValues.reverse[userId],
      };
}

enum ClaimStatus {
  PAID,
  REJECTED,
  CLOSED_DENIED,
  INVOICE_QUEUED,
  CLOSED,
  APPROVED,
  OPEN,
  CANCELLED,
  IN_PROGRESS
}

final claimStatusValues = EnumValues({
  "Approved": ClaimStatus.APPROVED,
  "Cancelled": ClaimStatus.CANCELLED,
  "Closed": ClaimStatus.CLOSED,
  "Closed - Denied": ClaimStatus.CLOSED_DENIED,
  "Invoice Queued": ClaimStatus.INVOICE_QUEUED,
  "In Progress": ClaimStatus.IN_PROGRESS,
  "Open": ClaimStatus.OPEN,
  "Paid": ClaimStatus.PAID,
  "Rejected": ClaimStatus.REJECTED
});

enum ClaimType { TRANSPORTATION, WAREHOUSE }

final claimTypeValues = EnumValues({
  "TRANSPORTATION": ClaimType.TRANSPORTATION,
  "WAREHOUSE": ClaimType.WAREHOUSE
});

enum DocumentType { OUTBOUND_ORDER, INBOUND_RECEIPT }

final documentTypeValues = EnumValues({
  "Inbound receipt": DocumentType.INBOUND_RECEIPT,
  "outbound order": DocumentType.OUTBOUND_ORDER
});

enum UserId {
  THE_63_BF0_EBDDA917_D2_BC2_DB8_B48,
  THE_63_CAC39_AB0_DD15020_C0_DAD5_C,
  THE_63_CACE52_B0_DD15020_C0_DAD66,
  THE_63_CACF61_B0_DD15020_C0_DAD68,
  THE_63_CADCF8_B0_DD15020_C0_DAD6_B,
  THE_63_CAEA0_DB0_DD15020_C0_DAD70,
  THE_63_CAFC78_B0_DD15020_C0_DAD72,
  THE_63_D0312_DE5_D87865_A0_A35_BC9
}

final userIdValues = EnumValues({
  "63bf0ebdda917d2bc2db8b48": UserId.THE_63_BF0_EBDDA917_D2_BC2_DB8_B48,
  "63cac39ab0dd15020c0dad5c": UserId.THE_63_CAC39_AB0_DD15020_C0_DAD5_C,
  "63cace52b0dd15020c0dad66": UserId.THE_63_CACE52_B0_DD15020_C0_DAD66,
  "63cacf61b0dd15020c0dad68": UserId.THE_63_CACF61_B0_DD15020_C0_DAD68,
  "63cadcf8b0dd15020c0dad6b": UserId.THE_63_CADCF8_B0_DD15020_C0_DAD6_B,
  "63caea0db0dd15020c0dad70": UserId.THE_63_CAEA0_DB0_DD15020_C0_DAD70,
  "63cafc78b0dd15020c0dad72": UserId.THE_63_CAFC78_B0_DD15020_C0_DAD72,
  "63d0312de5d87865a0a35bc9": UserId.THE_63_D0312_DE5_D87865_A0_A35_BC9
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
