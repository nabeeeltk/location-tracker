import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:location_tracker/src/models/session_model.dart';
import 'package:location_tracker/src/services/db_sevice.dart';
import '../services/location_service.dart';


import '../models/location_model.dart';
import '../services/sync_service.dart';
import 'package:location/location.dart';


class TrackingProvider extends ChangeNotifier {
final LocationService _locService = LocationService();
final DBService _db = DBService();
final SyncService _sync = SyncService();


StreamSubscription<LocationData>? _sub;
SessionModel? _currentSession;
bool isTracking = false;
bool isDark = false;


List<SessionModel> sessions = [];


Future<void> init() async {
await _locService.init();
_sync.start();
await _loadSessions();
}


Future<void> _loadSessions() async {
final rows = await _db.query('sessions', orderBy: 'start_time DESC');
sessions = rows.map((r) => SessionModel.fromMap(r)).toList();
notifyListeners();
}


Future<void> startTracking() async {
if (isTracking) return;
final s = SessionModel(startTime: DateTime.now());
final id = await _db.insert('sessions', s.toMap());
s.id = id;
_currentSession = s;
isTracking = true;


_sub = _locService.locationStream.listen((loc) async {
if (_currentSession == null) return;
final l = LocationModel(
sessionId: _currentSession!.sessionId,
latitude: loc.latitude ?? 0.0,
longitude: loc.longitude ?? 0.0,
accuracy: loc.accuracy,
speed: loc.speed,
timestamp: DateTime.now(),
);
await _db.insert('locations', l.toMap());
});


await _loadSessions();
notifyListeners();
}


Future<void> stopTracking() async {
if (!isTracking || _currentSession == null) return;
_sub?.cancel();
_currentSession!.endTime = DateTime.now();
await _db.update('sessions', {'end_time': _currentSession!.endTime!.toIso8601String(), 'synced': 0}, where: 'id = ?', whereArgs: [_currentSession!.id]);
_currentSession = null;
isTracking = false;
await _loadSessions();
notifyListeners();
}


Future<List<LocationModel>> getLocationsForSession(String sessionId) async {
final rows = await _db.query('locations', where: 'session_id = ?', whereArgs: [sessionId], orderBy: 'timestamp ASC');
return rows.map((r) => LocationModel.fromMap(r)).toList();
}


void toggleTheme() {
isDark = !isDark;
notifyListeners();
}
}