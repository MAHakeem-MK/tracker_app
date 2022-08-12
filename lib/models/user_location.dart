import 'dart:convert';

class UserLocation {
  final String userId;
  final DateTime timeStamp;
  final String userName;
  final String userEmail;
  final String latitude;
  final String longitude;
  UserLocation({
    required this.userId,
    required this.timeStamp,
    required this.userName,
    required this.userEmail,
    required this.latitude,
    required this.longitude,
  });

  UserLocation.empty() : userId = "",timeStamp = DateTime.now().toUtc(), userEmail = "", userName = "",latitude = "", longitude = "";

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'time_stamp': timeStamp.toIso8601String(),
      'user_name': userName,
      'user_email': userEmail,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      userId: map['user_id'],
      timeStamp: DateTime.parse(map['time_stamp']).toLocal(),
      userName: map['user_name'],
      userEmail: map['user_email'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLocation.fromJson(String source) =>
      UserLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return '$userName is at lat: $latitude & lon: $longitude';
  }

  UserLocation copyWith({
    String? userId,
    DateTime? timeStamp,
    String? userName,
    String? userEmail,
    String? latitude,
    String? longitude,
  }) {
    return UserLocation(
      userId: userId ?? this.userId,
      timeStamp: timeStamp ?? this.timeStamp,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
