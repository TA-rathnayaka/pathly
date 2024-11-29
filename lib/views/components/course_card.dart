// import 'package:pathly/config/app_theme.dart';
// import 'package:flutter/material.dart';
//
// class CourseCard extends StatelessWidget {
//   final String title;
//   final String count;
//   final String imagePath;
//   final String route;
//
//   CourseCard({
//     Key? key,
//     required this.title,
//     required this.count,
//     required this.imagePath,
//     required this.route,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Stack(
//             alignment: Alignment.center, // Center the button over the image
//             children: [
//               Container(
//                 height: 140.0,
//                 width: 250.0,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(imagePath),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               Positioned(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, route);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white.withOpacity(0.8),
//                     foregroundColor: Colors.black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   child: Text("Enroll"),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(
//             title,
//             style: isDarkMode
//                 ? AppTextStyles.categoryTitleDark
//                 : AppTextStyles.categoryTitleLight,
//           ),
//           SizedBox(height: 4),
//           Text(
//             "$count Courses",
//             style: isDarkMode
//                 ? AppTextStyles.subheadingDark
//                 : AppTextStyles.subheadingLight,
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pathly/config/app_theme.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String count;
  final String imagePath;
  final String route;
  final VoidCallback? onPressed;  // Added parameter for the onPressed callback

  CourseCard({
    Key? key,
    required this.title,
    required this.count,
    required this.imagePath,
    required this.route,
    this.onPressed, // Allow optional onPressed parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            alignment: Alignment.center, // Center the button over the image
            children: [
              Container(
                height: 140.0,
                width: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Positioned(
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text("Enroll"),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: isDarkMode
                ? AppTextStyles.categoryTitleDark
                : AppTextStyles.categoryTitleLight,
          ),
          SizedBox(height: 4),
          Text(
            "$count Courses",
            style: isDarkMode
                ? AppTextStyles.subheadingDark
                : AppTextStyles.subheadingLight,
          ),
        ],
      ),
    );
  }
}