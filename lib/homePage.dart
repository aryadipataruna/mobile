// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/order.dart';
// import '../providers/app_provider.dart';
// import '../services/database_service.dart';
// import 'penjualanPage.dart';
// import 'loginPage.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<AppProvider>(context).user;
//     if (user == null) {
//       return loginPage();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome, ${user.name}'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await Provider.of<AppProvider>(context, listen: false).signOut();
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => loginPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: StreamBuilder<List<DeliveryOrder>>(
//         stream: DatabaseService().getOrders(user.id),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(child: Text('Error loading orders'));
//           }
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final orders = snapshot.data!;
//           if (orders.isEmpty) {
//             return const Center(child: Text('No orders assigned'));
//           }
//           return ListView.builder(
//             itemCount: orders.length,
//             itemBuilder: (context, index) {
//               final order = orders[index];
//               return ListTile(
//                 title: Text('Order for ${order.customerName}'),
//                 subtitle: Text('Status: ${order.status}'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => penjualanPage(order: order),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
