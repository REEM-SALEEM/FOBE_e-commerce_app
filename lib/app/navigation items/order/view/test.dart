// import 'dart:developer';

// import 'package:finalproject/sqflite/db/paymntdatabase.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   void initState() {
//     Paymentprov().getallPayment();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Paymentprov>(
//       builder: (context, value, child) {
//         return Scaffold(
//             body: Center(
//           child: ListView.builder(
//             itemCount: value.paymentlistNotifier.length,
//             itemBuilder: (context, index) {
//               final data = value.paymentlistNotifier[index];
//               log("naaaaaaaaaaaaaaaaaaame: ${data.name}");
//               return Container(color: Colors.red, child: Text(data.name));
//             },
//           ),
//         ));
//       },
//     );
//   }
// }
