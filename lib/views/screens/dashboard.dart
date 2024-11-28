import 'package:flutter/material.dart';
import 'package:pathly/config/app_theme.dart';
import 'package:pathly/views/components/course_card.dart';
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
                isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
                isDarkMode ? AppColors.darkAccent : AppColors.lightAccent,
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Header Section
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/1.jpg"),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 108),
                        Text(
                          "All paths",
                          style: isDarkMode
                              ? AppTextStyles.headingDark
                              : AppTextStyles.headingLight,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Please select a study path",
                          style: isDarkMode
                              ? AppTextStyles.subheadingDark
                              : AppTextStyles.subheadingLight,
                        ),
                      ],
                    ),
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                          ? AppColors.darkCard
                          : Colors.white,
                      hintText: 'Search',
                      hintStyle: isDarkMode
                          ? AppTextStyles.searchHintDark
                          : AppTextStyles.searchHintLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),

                // Category Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "All Subjects",
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

                // Course Cards
                Container(
                  height: 210,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return CourseCard(
                        key: UniqueKey(),
                        title: "Figma Design",
                        count: "24",
                        imagePath: "images/1.jpg",
                      );
                    },
                  ),
                ),

                // Recently Viewed Section
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