import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_tracker/src/services/db_sevice.dart';



class FirebaseService {
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final DBService _db = DBService();


Future<void> syncUnsynced() async {
final db = await _db.database;


final unsyncedSessions = await db.query('sessions', where: 'synced = 0');
for (final s in unsyncedSessions) {
// Create a session doc
final sessionRef = await _firestore.collection('sessions').add({
'session_id': s['session_id'],
'start_time': s['start_time'],
'end_time': s['end_time'],
});
// Mark session as synced
await db.update('sessions', {'synced': 1}, where: 'id = ?', whereArgs: [s['id']]);
}


final unsyncedLocs = await db.query('locations', where: 'synced = 0');
for (final l in unsyncedLocs) {
await _firestore.collection('locations').add({
'session_id': l['session_id'],
'latitude': l['latitude'],
'longitude': l['longitude'],
'accuracy': l['accuracy'],
'speed': l['speed'],
'timestamp': l['timestamp'],
});
await db.update('locations', {'synced': 1}, where: 'id = ?', whereArgs: [l['id']]);
}
}
}