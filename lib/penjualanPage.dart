// import 'package:flutter/material.dart';
// import '../models/order.dart';
// import '../services/database_service.dart';
// import 'tracking_screen.dart';

// class OrderDetailScreen extends StatelessWidget {
//   final DeliveryOrder order;

//   const OrderDetailScreen({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Order for ${order.customerName}')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Address: ${order.address}',
//                 style: const TextStyle(fontSize: 16)),
//             Text('Status: ${order.status}',
//                 style: const TextStyle(fontSize: 16)),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TrackingScreen(order: order),
//                   ),
//                 );
//               },
//               child: const Text('Track Delivery'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await DatabaseService().updateOrderStatus(
//                     order.id,
//                     order.status == 'pending' ? 'in_progress' : 'delivered',
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Status updated')),
//                   );
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Error: $e')),
//                   );
//                 }
//               },
//               child: Text(
//                 order.status == 'pending'
//                     ? 'Start Delivery'
//                     : 'Mark as Delivered',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
