import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location_tracker/src/models/session_model.dart';
import 'package:location_tracker/src/view/session_details_screen.dart';


class SessionCard extends StatelessWidget {
final SessionModel session;
const SessionCard({Key? key, required this.session}) : super(key: key);


@override
Widget build(BuildContext context) {
final start = DateFormat.yMd().add_jm().format(session.startTime);
final end = session.endTime == null ? 'Ongoing' : DateFormat.yMd().add_jm().format(session.endTime!);
return Card(
margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
child: ListTile(
title: Text('Session ${session.sessionId.substring(0, 6)}'),
subtitle: Text('$start — $end'),
trailing: Icon(Icons.chevron_right),
onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SessionDetailScreen(session: session))),
),
);
}
}