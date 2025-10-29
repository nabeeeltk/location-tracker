import 'dart:async';
import 'package:location/location.dart';


class LocationService {
final Location _location = Location();
Stream<LocationData>? _stream;


Future<void> init() async {
bool serviceEnabled = await _location.serviceEnabled();
if (!serviceEnabled) serviceEnabled = await _location.requestService();


PermissionStatus permission = await _location.hasPermission();
if (permission == PermissionStatus.denied) {
permission = await _location.requestPermission();
}


await _location.changeSettings(accuracy: LocationAccuracy.high, interval: 5000, distanceFilter: 5);
await _location.enableBackgroundMode(enable: true);
}


Stream<LocationData> get locationStream {
_stream ??= _location.onLocationChanged;
return _stream!;
}
}