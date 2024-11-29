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
                              "All paths",
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
                              "Please select a study path",
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                      return CourseCard(
                        key: UniqueKey(),
                        title: "Path ${index + 1}",
                        count: "24",
                        imagePath: "images/1.jpg",
                        route: FrontendRoadmapScreen.id, // Example image
                      );
                    },
                  ),
                ),

                // Horizontal Scrollable Daily Tips Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Daily Tips",
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

                // Horizontal Scrollable Section for Daily Tips
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        DailyTipCard(
                          title: "Stay focused!",
                          description: "Maintain a routine to stay on track.",
                        ),
                        DailyTipCard(
                          title: "Keep practicing!",
                          description: "Practice consistently to master new skills.",
                        ),
                        DailyTipCard(
                          title: "Take breaks!",
                          description: "Remember to take short breaks while studying.",
                        ),
                        DailyTipCard(
                          title: "Set goals!",
                          description: "Break your work into manageable chunks.",
                        ),
                        DailyTipCard(
                          title: "Stay positive!",
                          description: "A positive mindset can help you achieve more.",
                        ),
                      ],
                    ),
                  ),
                ),

                // Recently Viewed Section (Card-style display)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Recently Viewed",
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

                // Dynamically generate recently viewed items
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Recently();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

