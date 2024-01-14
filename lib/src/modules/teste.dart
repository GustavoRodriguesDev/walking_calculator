// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController mapController;
//   LocationData currentLocation;
//   List<LatLng> pathPoints = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mapa com Caminho'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: const CameraPosition(å
//           target: LatLng(0.0, 0.0),
//           zoom: 15.0,
//         ),
//         myLocationEnabled: true,
//         compassEnabled: true,
//         markers: <Marker>{
//           Marker(
//             markerId: const MarkerId("current_location"),
//             position: LatLng(
//               currentLocation?.latitude ?? 0.0,
//               currentLocation?.longitude ?? 0.0,
//             ),
//             icon: BitmapDescriptor.defaultMarker,
//           ),
//         },
//         polylines: <Polyline>{
//           Polyline(
//             polylineId: const PolylineId("user_path"),
//             color: Colors.blue,
//             points: pathPoints,
//           ),
//         },
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });

//     _getLocation();
//   }

//   Future<void> _getLocation() async {
//     var location = Location();
//     try {
//       location.onLocationChanged.listen((LocationData currentLocation) {
//         mapController.animateCamera(
//           CameraUpdate.newLatLng(
//             LatLng(currentLocation.latitude, currentLocation.longitude),
//           ),
//         );
//         setState(() {
//           this.currentLocation = currentLocation;
//           pathPoints
//               .add(LatLng(currentLocation.latitude, currentLocation.longitude));
//         });
//       });
//     } catch (e) {
//       print("Erro ao obter localização: $e");
//     }
//   }
// }
