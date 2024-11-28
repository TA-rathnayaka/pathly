// import 'package:flutter/material.dart';
// import 'package:pathly/views/screens/_all.dart';
//
// class StartupScreen extends StatelessWidget {
//   static final String id = '/';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Top logo and design
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Logo and icon
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.sports_soccer, color: Colors.red, size: 30),
//                       SizedBox(width: 8),
//                       Text(
//                         'PATHLY',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // Placeholder for the background star design
//                   Image.asset('assets/path_design.png', height: 200),
//                 ],
//               ),
//             ),
//
//             // Main content - title and subtitle
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     'KEEP AN EYE ON YOUR PATH',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Watch sports live or highlights, read every news from your smartphone',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black.withOpacity(0.7),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Buttons
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, LoginScreen.id);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: kPrimaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12), // Rounded edges
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: Text(
//                       "LOGIN",
//                       style: kPrimaryButtonTextStyle,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, SignupScreen.id);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: kSecondaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12), // Rounded edges
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: Text(
//                       "CREATE ACCOUNT",
//                       style: kSecondaryButtonTextStyle,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
// }