// import 'package:flutter/material.dart';
// import 'package:pathly/config/app_theme.dart';
// import 'package:pathly/views/screens/login_screen.dart';
// import 'package:pathly/services/auth_service.dart';
// import 'package:pathly/views/screens/main_screen.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class SplashScreen extends StatelessWidget {
//   static const String id = '/';
//
//   const SplashScreen({super.key});
//
//   Future<void> _navigateToLoginOrDashboard(BuildContext context) async {
//     bool isAuthenticated = await AuthService().isUserAuthenticated();
//     if (isAuthenticated) {
//       Navigator.pushReplacementNamed(context, MainScreen.id);
//     } else {
//       Navigator.pushReplacementNamed(context, LoginScreen.id);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: GestureDetector(
//         onTap: () {
//           _navigateToLoginOrDashboard(context);
//         },
//         child: Padding(
//           padding: const EdgeInsets.only(right: 16.0, bottom: 32),
//           child: Container(
//             child: Text(
//               "Get Started",
//               style: GoogleFonts.roboto(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("images/splash.jpg"),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "Learn from the Best",
//                 style: GoogleFonts.roboto(
//                   color: Colors.white,
//                   fontSize: 18,
//                   letterSpacing: 0.9,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 "Pathly",
//                 style: AppTextStyles.pathly
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:pathly/config/app_theme.dart';
import 'package:pathly/views/screens/login_screen.dart';
import 'package:pathly/services/auth_service.dart';
import 'package:pathly/views/screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the controller
    super.dispose();
  }

  Future<void> _navigateToLoginOrDashboard() async {
    bool isAuthenticated = await AuthService().isUserAuthenticated();
    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, MainScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with black and white wave
          CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: BackgroundPainter(),
          ),
          // Main content with fade animation
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(  // Center the column content
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,  // Center vertically
                  crossAxisAlignment: CrossAxisAlignment.center,  // Center horizontally
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Text(
                      "Eureka.",
                      style: AppTextStyles.pathly,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          // Innovative circular button positioned lower and centered
          Positioned(
            bottom: 32, // Bringing the button lower
            left: 0,
            right: 0, // To center it horizontally
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: GestureDetector(
                onTap: () {
                  _navigateToLoginOrDashboard();
                },
                child: Container(
                  width: 60, // Set width for the circular button
                  height: 60, // Set height for the circular button
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,  // Button background color set to white
                    shape: BoxShape.circle, // Make it circular
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_forward, // Use an arrow icon for a forward gesture
                    color: Colors.black,
                    size: 30, // Icon size
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Custom Painter to create the black-to-white wave background
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        colors: [Colors.black, Colors.black],  // Transition from black to white
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    final Path path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, size.height * 0.6) // Control the height of the wave
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.8, size.width * 0.5, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.6, size.width, size.height * 0.65)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint the wave unless changes occur
  }
}
