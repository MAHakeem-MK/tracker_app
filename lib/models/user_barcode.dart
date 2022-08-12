import 'dart:convert';

class UserBarcode {
  final String userId;
  final DateTime timeStamp;
  final String userName;
  final String userEmail;
  final String barcode;
  UserBarcode({
    required this.userId,
    required this.timeStamp,
    required this.userName,
    required this.userEmail,
    required this.barcode,
  });

  UserBarcode copyWith({
    String? userId,
    DateTime? timeStamp,
    String? userName,
    String? userEmail,
    String? barcode,
  }) {
    return UserBarcode(
      userId: userId ?? this.userId,
      timeStamp: timeStamp ?? this.timeStamp,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      barcode: barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'time_stamp': timeStamp.toIso8601String(),
      'user_name': userName,
      'user_email': userEmail,
      'barcode': barcode,
    };
  }

  String toJson() => json.encode(toMap());
}
