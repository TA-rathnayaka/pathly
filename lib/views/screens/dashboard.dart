// import 'package:flutter/material.dart';
// import 'package:pathly/config/app_theme.dart';
// import 'package:pathly/providers/user_provider.dart';
// import 'package:pathly/views/components/course_card.dart';
// import 'package:pathly/views/screens/_all.dart';
// import 'package:pathly/providers/roadmap_provider.dart';
// import 'package:provider/provider.dart'; // Ensure you import provider package
//
// class Dashboard extends StatefulWidget {
//   static const String id = '/dashboard-screen';
//
//   const Dashboard({super.key});
//
//   @override
//   _DashboardState createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.topRight,
//               stops: const [0.3, 0.7],
//               colors: [
//                 isDarkMode
//                     ? AppColors.darkBackground
//                     : AppColors.lightBackground,
//                 isDarkMode ? AppColors.darkAccent : AppColors.lightBackground,
//               ],
//             ),
//           ),
//           child: SingleChildScrollView(
//             physics: const ClampingScrollPhysics(),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 // Header Section with an Image and Text
//                 Container(
//                   width: double.infinity,
//                   height: 280,
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(40),
//                       bottomRight: Radius.circular(40),
//                     ),
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage("images/1.jpg"),
//                     ),
//                   ),
//                   child: Stack(
//                     children: <Widget>[
//                       Positioned.fill(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(40),
//                               bottomRight: Radius.circular(40),
//                             ),
//                             color: Colors.black.withOpacity(0.4),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             const SizedBox(height: 108),
//                             Text(
//                               "All paths",
//                               style: AppTextStyles.headingDark.copyWith(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 shadows: [
//                                   Shadow(
//                                     blurRadius: 10.0,
//                                     color: Colors.black.withOpacity(0.5),
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             Text(
//                               "Please select a study path",
//                               style: AppTextStyles.subheadingDark.copyWith(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.normal,
//                                 shadows: [
//                                   Shadow(
//                                     blurRadius: 10.0,
//                                     color: Colors.black.withOpacity(0.5),
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Search Bar (Modern and Interactive)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 16.0),
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           Icons.search,
//                           color: isDarkMode ? Colors.white : Colors.black,
//                           size: 32,
//                         ),
//                         onPressed: () {},
//                       ),
//                       filled: true,
//                       fillColor: isDarkMode
//                           ? AppColors.darkCard.withOpacity(0.85)
//                           : Colors.grey[200]!.withOpacity(0.85),
//                       hintText: 'Search',
//                       hintStyle: isDarkMode
//                           ? AppTextStyles.searchHintDark
//                           : AppTextStyles.searchHintLight,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//                     ),
//                   ),
//                 ),
//
//                 // Explore Paths Section (Grid Layout)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         "Explore Paths",
//                         style: isDarkMode
//                             ? AppTextStyles.categoryTitleDark
//                             : AppTextStyles.categoryTitleLight,
//                       ),
//                       Text(
//                         "See all",
//                         style: isDarkMode
//                             ? AppTextStyles.seeAllDark
//                             : AppTextStyles.seeAllLight,
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // GridView for Explore Paths using Consumer to access roadmap data
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: Consumer<RoadmapProvider>(
//                     builder: (context, roadmapProvider, child) {
//                       final roadmaps = roadmapProvider.roadmaps;
//
//                       return GridView.builder(
//                         shrinkWrap: true,
//                         // So it doesn't take up all screen space
//                         physics: const NeverScrollableScrollPhysics(),
//                         // Disable scrolling
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2, // 2 columns in the grid
//                           crossAxisSpacing: 16.0, // Space between columns
//                           mainAxisSpacing: 16.0, // Space between rows
//                           childAspectRatio: 0.75, // Aspect ratio of the cards
//                         ),
//                         itemCount: roadmaps.length,
//                         // Dynamically set item count based on roadmaps
//                         itemBuilder: (BuildContext context, int index) {
//                           final roadmap = roadmaps[index];
//
//                           return CourseCard(
//                               key: UniqueKey(),
//                               title: roadmap.title,
//                               count: "${roadmap.stages.length}",
//                               imagePath: roadmap.imageUrl ??"images/1.jpg",
//                               // Replace with actual image path
//                               route: LoginScreen.id,
//                               onPressed: () {
//                                 final provider = Provider.of<UserProvider>(
//                                     context,
//                                     listen: false);
//                                 provider.enrollInRoadmap(roadmap.id);
//                               } // Update with the correct screen route
//                               );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//
//                 // Other sections (Daily Tips, Recently Viewed, etc.)...
//                 // Similar structure can be applied to other sections if needed
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:pathly/config/app_theme.dart';
import 'package:pathly/providers/user_provider.dart';
import 'package:pathly/views/components/course_card.dart';
import 'package:pathly/views/screens/_all.dart';
import 'package:pathly/providers/roadmap_provider.dart';
import 'package:provider/provider.dart'; // Ensure you import provider package

class Dashboard extends StatefulWidget {
  static const String id = '/dashboard-screen';

  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: const [0.3, 0.7],
              colors: [
                isDarkMode
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
                isDarkMode ? AppColors.darkAccent : AppColors.lightBackground,
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Header Section with a black background and the lightbulb icon on the right side
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: Colors.black, // Set a black background
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 108),
                            Text(
                              "Tech Journeys",
                              style: AppTextStyles.headingDark.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "",
                              style: AppTextStyles.subheadingDark.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.lightGreenAccent.withOpacity(0.5),
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0, // Position the bulb icon on the right
                        top: 50, // Position the bulb vertically from the top
                        child: Icon(
                          Icons.lightbulb_outline, // Lightbulb icon
                          color: Colors.lightGreenAccent,
                          size: 150, // Increase the size of the icon
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar (Modern and Interactive)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 32,
                        ),
                        onPressed: () {},
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? AppColors.darkCard.withOpacity(0.85)
                          : Colors.grey[200]!.withOpacity(0.85),
                      hintText: 'Search',
                      hintStyle: isDarkMode
                          ? AppTextStyles.searchHintDark
                          : AppTextStyles.searchHintLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),

                // Explore Paths Section (Grid Layout)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Explore Paths",
                        style: isDarkMode
                            ? AppTextStyles.categoryTitleDark
                            : AppTextStyles.categoryTitleLight,
                      ),
                      Text(
                        "See all",
                        style: isDarkMode
                            ? AppTextStyles.seeAllDark
                            : AppTextStyles.seeAllLight,
                      ),
                    ],
                  ),
                ),

                // GridView for Explore Paths using Consumer to access roadmap data
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Consumer<RoadmapProvider>(
                    builder: (context, roadmapProvider, child) {
                      final roadmaps = roadmapProvider.roadmaps;

                      return GridView.builder(
                        shrinkWrap: true,
                        // So it doesn't take up all screen space
                        physics: const NeverScrollableScrollPhysics(),
                        // Disable scrolling
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns in the grid
                          crossAxisSpacing: 16.0, // Space between columns
                          mainAxisSpacing: 16.0, // Space between rows
                          childAspectRatio: 0.75, // Aspect ratio of the cards
                        ),
                        itemCount: roadmaps.length,
                        // Dynamically set item count based on roadmaps
                        itemBuilder: (BuildContext context, int index) {
                          final roadmap = roadmaps[index];

                          return CourseCard(
                              key: UniqueKey(),
                              title: roadmap.title,
                              count: "${roadmap.stages.length}",
                              imagePath: roadmap.imageUrl ?? "images/1.jpg", // Replace with actual image path
                              route: LoginScreen.id,
                              onPressed: () {
                                final provider = Provider.of<UserProvider>(
                                    context,
                                    listen: false);
                                provider.enrollInRoadmap(roadmap.id);
                              });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
