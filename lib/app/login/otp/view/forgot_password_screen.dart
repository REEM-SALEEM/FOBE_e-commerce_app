// import 'package:flutter/material.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 250,
//               ),
//               Stack(children: const [
//                 Text(
//                   'Forgot Password?',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w900,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
//                   child: Text(
//                     'Forgot Password?',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w900,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ]),
//               const SizedBox(height: 5),
//               const Text(
//                 'Plaese enter your username \n or email ',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: "",
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black, width: 1.5),
//                     ),
//                     hintStyle: TextStyle(color: Colors.grey),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.black,
//                   disabledForegroundColor: Colors.grey,
//                   elevation: 20,
//                   minimumSize: const Size(315, 50),
//                 ),
//                 onPressed: () {},
//                 child: const Text('Sign in'),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
