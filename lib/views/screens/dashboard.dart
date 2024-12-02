import 'package:flutter/material.dart';
import 'package:pathly/config/app_theme.dart';
import 'package:pathly/views/components/course_card.dart';
import 'package:pathly/views/components/daily_tip_card.dart';
import 'package:pathly/views/screens/_all.dart';
import 'recently.dart';

class Dashboard extends StatefulWidget {
  static const String id = '/dashboard-screen';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _controller = TextEditingController();
  List<bool> isHovered = List.filled(6, false); // Track hover state for each card

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
              stops: [0.3, 0.7],
              colors: [
                isDarkMode
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
                isDarkMode ? AppColors.darkAccent : AppColors.lightBackground,
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Header Section with an Image and Text
                Container(
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/1.jpg"),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
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
                            SizedBox(height: 108),
                            Text(
                              "Pathly shows the PATH",
                              style: AppTextStyles.headingDark.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Please select a  PATH",
                              style: AppTextStyles.subheadingDark.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),

                // Explore Paths Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Explore PATHS",
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

                // GridView for Explore Paths
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GridView.builder(
                    shrinkWrap: true, // So it doesn't take up all screen space
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns in the grid
                      crossAxisSpacing: 16.0, // Space between columns
                      mainAxisSpacing: 16.0, // Space between rows
                      childAspectRatio: 0.75, // Aspect ratio of the cards
                    ),
                    itemCount: 6, // Number of paths to display
                    itemBuilder: (BuildContext context, int index) {
                      final paths = [
                        {
                          "title": "Frontend Development",
                          "count": "24",
                          "imagePath": "images/front.jpg",
                          "route": FrontendRoadmapScreen.id,
                        },
                        {
                          "title": "Backend Development",
                          "count": "18",
                          "imagePath": "images/back.jpg",
                          "route": BackendRoadmapScreen.id,
                        },
                        {
                          "title": "Full Stack Development",
                          "count": "30",
                          "imagePath": "images/full.jpg",
                          "route": FrontendRoadmapScreen.id,
                        },
                        {
                          "title": "Data Science",
                          "count": "20",
                          "imagePath": "images/data.jpg",
                          "route": DataScienceRoadmapScreen.id,
                        },
                        {
                          "title": "DevOps",
                          "count": "15",
                          "imagePath": "images/devOps.jpg",
                          "route": FrontendRoadmapScreen.id,
                        },
                        {
                          "title": "Cybersecurity",
                          "count": "12",
                          "imagePath": "images/cyber.jpg",
                          "route": FrontendRoadmapScreen.id,
                        },
                      ];

                      final path = paths[index];

                      return MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isHovered[index] = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            isHovered[index] = false;
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CourseCard(
                              key: UniqueKey(),
                              title: path["title"]!,
                              count: path["count"]!,
                              imagePath: path["imagePath"]!,
                              route: path["route"]!,
                            ),
                            if (isHovered[index])
                              Positioned(
                                bottom: 10,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, path["route"]!);
                                  },
                                  child: Text("Explore"),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Other Sections (Daily Tips, Recently Viewed) remain unchanged...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
