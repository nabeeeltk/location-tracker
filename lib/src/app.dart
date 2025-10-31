import 'package:flutter/material.dart';
import 'package:location_tracker/src/providers/track_provider.dart';
import 'package:location_tracker/src/theme/theme.dart';
import 'package:location_tracker/src/view/home_screen.dart';
import 'package:provider/provider.dart';

class AdvancedLocationApp extends StatelessWidget {
  const AdvancedLocationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrackingProvider()..init(),
      child: Consumer<TrackingProvider>(
        builder: (context, prov, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Advanced Location Tracker',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: prov.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
