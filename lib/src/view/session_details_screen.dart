import 'package:flutter/material.dart';
import 'package:location_tracker/src/models/location_model.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/src/models/session_model.dart';
import 'package:location_tracker/src/providers/track_provider.dart';

import 'package:provider/provider.dart';

class SessionDetailScreen extends StatefulWidget {
  final SessionModel session;
  const SessionDetailScreen({Key? key, required this.session})
    : super(key: key);

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> {
  GoogleMapController? _mapController;
  List<LocationModel> _points = [];
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    final pts = await context.read<TrackingProvider>().getLocationsForSession(
      widget.session.sessionId,
    );
    setState(() {
      _points = pts;
      _buildPolylines();
    });
  }

  void _buildPolylines() {
    if (_points.isEmpty) return;
    final poly = Polyline(
      polylineId: const PolylineId('route'),
      points: _points.map((p) => LatLng(p.latitude, p.longitude)).toList(),
      width: 5,
    );
    _polylines.clear();
    _polylines.add(poly);

    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('start'),
        position: LatLng(_points.first.latitude, _points.first.longitude),
      ),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('end'),
        position: LatLng(_points.last.latitude, _points.last.longitude),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session ${widget.session.sessionId.substring(0, 6)}'),
      ),
      body: _points.isEmpty
          ? const Center(child: Text('No location points for this session.'))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_points.first.latitude, _points.first.longitude),
                zoom: 16,
              ),
              polylines: _polylines,
              markers: _markers,
              onMapCreated: (c) => _mapController = c,
            ),
    );
  }
}
