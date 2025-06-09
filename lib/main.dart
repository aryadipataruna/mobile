// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'providers/app_provider.dart';
// import 'screens/login_screen.dart';
// import 'services/auth_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const CourierApp());
// }

// class CourierApp extends StatelessWidget {
//   const CourierApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => AppProvider(),
//       child: MaterialApp(
//         title: 'Courier App',
//         theme: ThemeData(primarySwatch: Colors.blue),
//         home: Consumer<AppProvider>(
//           builder: (context, provider, child) {
//             return StreamBuilder(
//               stream: AuthService().user,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.active) {
//                   return snapshot.hasData ? HomeScreen() : LoginScreen();
//                 }
//                 return const Center(child: CircularProgressIndicator());
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
