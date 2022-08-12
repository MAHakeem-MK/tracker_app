import 'package:geolocator/geolocator.dart';
import 'package:tracker_app/models/user_location.dart';

Future<UserLocation> getLocation(UserLocation userLocation) async {
  Position position = await Geolocator.getCurrentPosition();
  return userLocation.copyWith(latitude: position.latitude.toString(), longitude: position.longitude.toString());
}