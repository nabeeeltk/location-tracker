import 'package:flutter/material.dart';
import 'package:location_tracker/src/providers/track_provider.dart';
import 'package:location_tracker/src/view/widgets/session_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Location Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<TrackingProvider>().toggleTheme(),
          ),
        ],
      ),
      body: const _Body(),
      floatingActionButton: const _TrackingFab(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingProvider>(
      builder: (context, prov, _) {
        if (prov.sessions.isEmpty) {
          return const Center(child: Text('No sessions yet. Start tracking!'));
        }
        return ListView.builder(
          itemCount: prov.sessions.length,
          itemBuilder: (context, i) => SessionCard(session: prov.sessions[i]),
        );
      },
    );
  }
}

class _TrackingFab extends StatelessWidget {
  const _TrackingFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingProvider>(
      builder: (context, prov, _) {
        return FloatingActionButton.extended(
          heroTag: 'track_fab',
          label: Text(prov.isTracking ? 'Stop' : 'Start'),
          icon: Icon(prov.isTracking ? Icons.stop : Icons.play_arrow),
          onPressed: () async {
            if (prov.isTracking) {
              await prov.stopTracking();
            } else {
              await prov.startTracking();
            }
          },
        );
      },
    );
  }
}
