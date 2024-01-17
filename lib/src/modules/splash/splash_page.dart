// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:walking_calculator/src/core/services/geolocator/geolocator_service.dart';
import 'package:walking_calculator/src/core/widget/map_widget/map_controller.dart';
import 'package:walking_calculator/src/get_it_injection.dart';
import 'package:walking_calculator/src/modules/start_walk/start_walk_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    await getIt.get<IGeolocatorService>().checkPermissions();
    await getIt.get<MapController>().setFirstPosition();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const StartWalkPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
