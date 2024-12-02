import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/roadmap_provider.dart';
import 'package:pathly/providers/create_screen_provider.dart'; // Import the state provider
import 'package:pathly/views/screens/stages_screen.dart'; // Screen for stages
import 'package:pathly/views/components/tech_path_list.dart'; // TechPathList component
import 'package:pathly/views/components/tech_card.dart';
import 'package:pathly/config/app_theme.dart'; // TechCard component

class CreatePathScreen extends StatelessWidget {
  static const String id = '/create_path';
  final _formKey = GlobalKey<FormState>();

  CreatePathScreen({super.key}); // Global key for the form

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Roadmap')),
      body: ChangeNotifierProvider(
        create: (_) => CreateScreenState(), // Provide the state
        child: Consumer<CreateScreenState>(
          builder: (context, createScreenState, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Form to add a new roadmap title, description, and icon
                  Form(
                    key: _formKey, // Assigning the global key
                    child: Column(
                      children: [
                        // TextFormField for entering the title
                        TextFormField(
                          initialValue: createScreenState.title,
                          onChanged: (value) => createScreenState.setTitle(value),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDarkMode
                                ? AppColors.darkCard.withOpacity(0.85)
                                : Colors.grey[200]!.withOpacity(0.85),
                            hintText: 'Enter title',
                            hintStyle: isDarkMode
                                ? AppTextStyles.searchHintDark
                                : AppTextStyles.searchHintLight,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // TextFormField for entering the description
                        TextFormField(
                          initialValue: createScreenState.description,
                          onChanged: (value) =>
                              createScreenState.setDescription(value),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDarkMode
                                ? AppColors.darkCard.withOpacity(0.85)
                                : Colors.grey[200]!.withOpacity(0.85),
                            hintText: 'Enter Description',
                            hintStyle: isDarkMode
                                ? AppTextStyles.searchHintDark
                                : AppTextStyles.searchHintLight,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // TextFormField for entering the image URL
                        TextFormField(
                          initialValue: createScreenState.imageUrl,
                          onChanged: (value) => createScreenState.setImageUrl(value),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDarkMode
                                ? AppColors.darkCard.withOpacity(0.85)
                                : Colors.grey[200]!.withOpacity(0.85),
                            hintText: 'Enter Image URL',
                            hintStyle: isDarkMode
                                ? AppTextStyles.searchHintDark
                                : AppTextStyles.searchHintLight,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an image URL';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Icon picker (Styled dropdown)
                        DropdownButtonFormField<IconData>(
                          value: createScreenState.selectedIcon,
                          onChanged: (IconData? newIcon) {
                            if (newIcon != null) {
                              createScreenState.setSelectedIcon(newIcon);
                            }
                          },
                          items: [
                            DropdownMenuItem(
                              value: Icons.star,
                              child: Row(
                                children: [
                                  Icon(Icons.star,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                  const SizedBox(width: 10),
                                  const Text('Star')
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: Icons.check_circle,
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                  const SizedBox(width: 10),
                                  const Text('Check Circle')
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: Icons.thumb_up,
                              child: Row(
                                children: [
                                  Icon(Icons.thumb_up,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                  const SizedBox(width: 10),
                                  const Text('Thumb Up')
                                ],
                              ),
                            ),
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDarkMode
                                ? AppColors.darkCard.withOpacity(0.85)
                                : Colors.grey[200]!.withOpacity(0.85),
                            hintText: 'Select an Icon',
                            hintStyle: isDarkMode
                                ? AppTextStyles.searchHintDark
                                : AppTextStyles.searchHintLight,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select an icon';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Button to add the title, description, and icon, and navigate
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final title = createScreenState.title;
                              final description = createScreenState.description;
                              final icon = createScreenState.selectedIcon;
                              final imageUrl = createScreenState.imageUrl;

                              // Add the new roadmap to the provider
                              Provider.of<RoadmapProvider>(context,
                                  listen: false)
                                  .addRoadmap(title, description, icon, imageUrl);

                              // Reset the form after adding the roadmap
                              createScreenState.resetForm();
                              _formKey.currentState!.reset(); // Clear form state
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(
                                  color: Colors.white, width: 1.5), // Border
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                          ),
                          child: const Text('Add Roadmap'),
                        ),
                      ],
                    ),
                  ),

                  // Display list of roadmaps using TechPathList and TechCard components
                  const SizedBox(height: 20),
                  const Text(
                    'Roadmap Titles:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  // Consumer widget to listen for updates in the roadmap list
                  Consumer<RoadmapProvider>(
                    builder: (context, roadmapProvider, child) {
                      return TechPathList(
                        groupTitle: 'Roadmap Paths',
                        techCards: roadmapProvider.roadmaps.map((roadmap) {
                          return TechCard(
                            icon: roadmap.icon, // Selected icon from the form
                            title: roadmap.title,
                            subtitle: roadmap.description,

                            iconBackgroundColor: Colors.blue.withOpacity(0.1),
                            iconColor: Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StagePage(roadmapId: roadmap.id),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}