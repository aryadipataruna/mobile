// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../models/order.dart';
// import '../services/location_service.dart';

// class TrackingScreen extends StatefulWidget {
//   final DeliveryOrder order;

//   const TrackingScreen({super.key, required this.order});

//   @override
//   _TrackingScreenState createState() => _TrackingScreenState();
// }

// class _TrackingScreenState extends State<TrackingScreen> {
//   GoogleMapController? _mapController;
//   LatLng? _courierLocation;

//   @override
//   void initState() {
//     super.initState();
//     _getCourierLocation();
//   }

//   Future<void> _getCourierLocation() async {
//     try {
//       final position = await LocationService().getCurrentLocation();
//       setState(() {
//         _courierLocation = LatLng(position.latitude, position.longitude);
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Track Delivery')),
//       body: _courierLocation == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _courierLocation!,
//                 zoom: 14,
//               ),
//               markers: {
//                 Marker(
//                   markerId: const MarkerId('courier'),
//                   position: _courierLocation!,
//                   infoWindow: const InfoWindow(title: 'Courier Location'),
//                 ),
//                 Marker(
//                   markerId: const MarkerId('destination'),
//                   position:
//                       LatLng(widget.order.latitude, widget.order.longitude),
//                   infoWindow: InfoWindow(title: widget.order.customerName),
//                 ),
//               },
//               onMapCreated: (controller) {
//                 _mapController = controller;
//               },
//             ),
//     );
//   }
// }
