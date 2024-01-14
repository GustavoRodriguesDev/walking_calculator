import 'package:flutter/material.dart';
import 'package:walking_calculator/src/modules/start_walk/walk_controller.dart';

import '../../core/services/geolocator/geolocator_service.dart';
import '../../core/widget/map_widget.dart';
import 'state/walk_state.dart';

class StartWalkPage extends StatefulWidget {
  const StartWalkPage({super.key});

  @override
  State<StartWalkPage> createState() => _StartWalkPageState();
}

class _StartWalkPageState extends State<StartWalkPage> {
  final GeoLocatorService geoLocatorService = GeoLocatorService();
  final WalkController walkController = WalkController();

  @override
  void initState() {
    super.initState();
    geoLocatorService.checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.red,
        body: ValueListenableBuilder<WalkState>(
          valueListenable: walkController,
          builder: (context, state, child) {
            return Column(
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: 1,
                              strokeWidth: 15,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5),
                            ),
                            CircularProgressIndicator(
                              value: state.targetPercentageAchieved,
                              strokeWidth: 15,
                              strokeCap: StrokeCap.round,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Icon(
                              Icons.directions_run_rounded,
                              size: 45,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${state.walkingDistance.toStringAsPrecision(2)} km",
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const Text('Meta'),
                          Text(
                            '${state.walkingGoal} KM',
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (state.walkButtonState == ButtonState.stop) ...{
                        ElevatedButton(
                          onPressed: () {
                            walkController.startWalk();
                          },
                          child: const Text('Iniciar'),
                        )
                      } else ...{
                        ElevatedButton(
                          onPressed: () {
                            walkController.stop();
                          },
                          child: const Text('Parar'),
                        )
                      }
                    ],
                  ),
                ),
                MapWidget(
                  positions: const [],
               
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}