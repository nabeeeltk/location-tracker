class LocationModel {
int? id;
String sessionId;
double latitude;
double longitude;
double? accuracy;
double? speed;
DateTime timestamp;
bool synced;


LocationModel({
this.id,
required this.sessionId,
required this.latitude,
required this.longitude,
this.accuracy,
this.speed,
required this.timestamp,
this.synced = false,
});


Map<String, dynamic> toMap() => {
'id': id,
'session_id': sessionId,
'latitude': latitude,
'longitude': longitude,
'accuracy': accuracy,
'speed': speed,
'timestamp': timestamp.toIso8601String(),
'synced': synced ? 1 : 0,
};


factory LocationModel.fromMap(Map<String, dynamic> m) => LocationModel(
id: m['id'] as int?,
sessionId: m['session_id'] as String,
latitude: m['latitude'] as double,
longitude: m['longitude'] as double,
accuracy: m['accuracy'] == null ? null : (m['accuracy'] as num).toDouble(),
speed: m['speed'] == null ? null : (m['speed'] as num).toDouble(),
timestamp: DateTime.parse(m['timestamp'] as String),
synced: (m['synced'] as int) == 1,
);
}