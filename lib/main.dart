// import 'package:flutter/material.dart';
// import 'package:pathly/screens/roadmap/frontend_rodamap_page.dart';
// import 'package:pathly/screens/auth/login_screen.dart';
// import 'package:pathly/screens/auth/signup_screen.dart';
// import 'package:pathly/screens/startup_screen.dart';
// import 'package:pathly/screens/tech_paths_screen.dart';

// void main() {
//   runApp(PathlyApp());
// }

// class PathlyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         StartupScreen.id: (context) => StartupScreen(),
//         LoginScreen.id: (context) => LoginScreen(),
//         SignUpScreen.id: (context) => SignUpScreen(),
//         TechPathsScreen.id: (context) => TechPathsScreen(),
//         FrontendRoadmapPage.id: (context) => FrontendRoadmapPage(),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pathly/providers/roadmap_provider.dart';
import 'package:pathly/providers/user_provider.dart';
import 'package:pathly/screens/auth/login_screen.dart';
import 'package:pathly/screens/auth/signup_screen.dart';
import 'package:pathly/screens/roadmap/frontend_rodamap_page.dart';
import 'package:pathly/screens/tech_paths_screen.dart';
import 'package:provider/provider.dart';
// Import other roadmap screens here if they exist

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RoadmapProvider()),
      ],
      child: MaterialApp(
        title: 'Pathly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          TechPathsScreen.id: (context) => TechPathsScreen(),
          FrontendRoadmapScreen.id: (context) => FrontendRoadmapScreen(),
          // Define other screens similarly
          // Example:
          // BackendRoadmapScreen.id: (context) => BackendRoadmapScreen(),
          // DataScienceRoadmapScreen.id: (context) => DataScienceRoadmapScreen(),
        },
        onGenerateRoute: (settings) {
          // Dynamic route handling (if needed)
          switch (settings.name) {
            case '/tech_paths_screen':
              return MaterialPageRoute(builder: (context) => TechPathsScreen());
            case '/frontend_roadmap_page':
              return MaterialPageRoute(
                  builder: (context) => FrontendRoadmapScreen());
            // Add other cases for more dynamic routes if necessary
            default:
              return null;
          }
        },
      ),
    );
  }
}
