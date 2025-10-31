import 'package:flutter/material.dart';
import 'package:location_tracker/src/providers/track_provider.dart';
import 'package:location_tracker/src/view/widgets/session_card.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withOpacity(0.08),
              colorScheme.surface,
              colorScheme.surface,
            ],
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const _Body(),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0), 
            child: AppBar(
              elevation: 0,
              backgroundColor: colorScheme.surface.withOpacity(0.95), 
              title: Text(
                'Tracking Sessions',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: colorScheme.onSurface,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.brightness_6_outlined,
                    color: colorScheme.primary, 
                  ),
                  onPressed: () => context.read<TrackingProvider>().toggleTheme(),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const _TrackingFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.explore_outlined,
                    size: 110,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'Start Your First Journey',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tap the button below to begin tracking your movement and visualize your path on a map.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7)), // Off-white
                  ),
                ],
              ),
            ),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0.0, 0.1),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: ListView.separated(
            key: ValueKey(prov.sessions.length),
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 120),
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemCount: prov.sessions.length,
            itemBuilder: (context, i) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  color: Colors.transparent, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Hero(
                    tag: 'session_${prov.sessions[i].id}',
                    child: Material(
                      color: Colors.transparent,
                      child: SessionCard(
                        session: prov.sessions[i],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
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
        final isTracking = prov.isTracking;
        final colorScheme = Theme.of(context).colorScheme;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          child: FloatingActionButton.extended(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: isTracking
                ? Colors.redAccent.shade700 
                : colorScheme.primary,
            foregroundColor: isTracking
                ? Colors.white
                : colorScheme.onPrimary,
            label: Text(
              isTracking ? 'STOP TRACKING' : 'START TRACKING',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                fontSize: 16,
              ),
            ),
            icon: Icon(
              isTracking ? Icons.stop_circle_rounded : Icons.my_location_rounded,
              size: 28,
            ),
            onPressed: () async {
              if (isTracking) {
                await prov.stopTracking();
              } else {
                await prov.startTracking();
              }
            },
          ),
        );
      },
    );
  }
}