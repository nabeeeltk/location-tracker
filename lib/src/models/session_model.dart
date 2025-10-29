import 'package:uuid/uuid.dart';

class SessionModel {
  int? id;
  String sessionId;
  DateTime startTime;
  DateTime? endTime;
  bool synced;

  SessionModel({
    this.id,
    String? sessionId,
    required this.startTime,
    this.endTime,
    this.synced = false,
  }) : sessionId = sessionId ?? const Uuid().v4();

  Map<String, dynamic> toMap() => {
        'id': id,
        'session_id': sessionId,
        'start_time': startTime.toIso8601String(),
        'end_time': endTime?.toIso8601String(),
        'synced': synced ? 1 : 0,
      };

  factory SessionModel.fromMap(Map<String, dynamic> m) => SessionModel(
        id: m['id'] as int?,
        sessionId: m['session_id'] as String,
        startTime: DateTime.parse(m['start_time'] as String),
        endTime:
            m['end_time'] == null ? null : DateTime.parse(m['end_time'] as String),
        synced: (m['synced'] as int) == 1,
      );
}
