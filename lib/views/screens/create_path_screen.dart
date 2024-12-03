import 'package:flutter/material.dart';
import 'package:pathly/views/screens/stages_screen.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/roadmap_provider.dart';
import 'package:pathly/providers/create_screen_provider.dart';
import 'package:pathly/views/components/tech_path_list.dart';
import 'package:pathly/views/components/tech_card.dart';
import 'package:pathly/config/app_theme.dart';

class CreatePathScreen extends StatelessWidget {
  static const String id = '/create_path';

  const CreatePathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Roadmap'),
        backgroundColor: Colors.black, // Set the background color to black
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (_) => CreateScreenState(),
          child: Consumer<CreateScreenState>(
            builder: (context, createScreenState, child) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: Consumer<RoadmapProvider>(
                      builder: (context, roadmapProvider, child) {
                        return TechPathList(
                          groupTitle: 'Roadmap Paths',
                          techCards: roadmapProvider.roadmaps.map((roadmap) {
                            return TechCard(
                              icon: roadmap.icon,
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
                                );},
                              onEdit: () {
                                // Handle the edit logic here
                              //   showDialog(
                              //     context: context,
                              //     builder: (context) => AlertDialog(
                              //       title: Text('Edit Roadmap'),
                              //       content: Column(
                              //         children: [
                              //           TextField(
                              //             controller: TextEditingController(text: roadmap.title),
                              //             onChanged: (value) {
                              //               roadmapProvider.setTitle(value);
                              //             },
                              //             decoration: InputDecoration(labelText: 'Title'),
                              //           ),
                              //           TextField(
                              //             controller: TextEditingController(text: roadmap.description),
                              //             onChanged: (value) {
                              //               roadmapProvider.setDescription(value);
                              //             },
                              //             decoration: InputDecoration(labelText: 'Description'),
                              //           ),
                              //           // Add more fields if necessary (like icon, imageUrl)
                              //         ],
                              //       ),
                              //       actions: [
                              //         TextButton(
                              //           onPressed: () {
                              //             roadmapProvider.updateRoadmap(
                              //               roadmap.id,
                              //               roadmapProvider.title,
                              //               roadmapProvider.description,
                              //               roadmapProvider.selectedIcon,
                              //               roadmapProvider.imageUrl,
                              //             );
                              //             Navigator.pop(context);
                              //           },
                              //           child: Text('Save'),
                              //         ),
                              //         TextButton(
                              //           onPressed: () {
                              //             Navigator.pop(context); // Close the dialog
                              //           },
                              //           child: Text('Cancel'),
                              //         ),
                              //       ],
                              //     ),
                              //   );
                               },
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Confirm Deletion'),
                                    content: Text('Are you sure you want to delete this roadmap? This action cannot be undone.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Call the delete function from the provider
                                          roadmapProvider.deleteRoadmap(roadmap.id);
                                          Navigator.pop(context);  // Close the dialog
                                        },
                                        child: Text('Delete'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);  // Close the dialog if user cancels
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );

                          }).toList()
                            ..cast<TechCard>(),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateRoadmapBottomSheet(context, isDarkMode);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateRoadmapBottomSheet(BuildContext context, bool isDarkMode) {
    final createScreenState = Provider.of<CreateScreenState>(context, listen: false);
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title input
                  TextFormField(
                    initialValue: createScreenState.title,
                    onChanged: createScreenState.setTitle,
                    decoration: _buildInputDecoration(isDarkMode, 'Enter Title'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a title' : null,
                  ),
                  const SizedBox(height: 20),
                  // Description input
                  TextFormField(
                    initialValue: createScreenState.description,
                    onChanged: createScreenState.setDescription,
                    decoration: _buildInputDecoration(isDarkMode, 'Enter Description'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter a description'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  // Image URL input
                  TextFormField(
                    initialValue: createScreenState.imageUrl,
                    onChanged: createScreenState.setImageUrl,
                    decoration: _buildInputDecoration(isDarkMode, 'Enter Image URL'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter an image URL' : null,
                  ),
                  const SizedBox(height: 20),
                  // Icon picker
                  DropdownButtonFormField<IconData>(
                    value: createScreenState.selectedIcon,
                    onChanged: (IconData? newIcon) {
                      if (newIcon != null) {
                        createScreenState.setSelectedIcon(newIcon);
                      }
                    },
                    items: _buildIconDropdownItems(isDarkMode),
                    decoration: _buildInputDecoration(isDarkMode, 'Select an Icon'),
                    validator: (value) =>
                    value == null ? 'Please select an icon' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<RoadmapProvider>(context, listen: false).addRoadmap(
                          createScreenState.title,
                          createScreenState.description,
                          createScreenState.selectedIcon!,
                          createScreenState.imageUrl,
                        );
                        createScreenState.resetForm();
                        Navigator.pop(context); // Close the bottom sheet
                      }
                    },
                    style: _buildButtonStyle(),
                    child: const Text('Add Roadmap'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(bool isDarkMode, String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: isDarkMode
          ? AppColors.darkCard.withOpacity(0.85)
          : Colors.grey[200]!.withOpacity(0.85),
      hintText: hintText,
      hintStyle: isDarkMode
          ? AppTextStyles.searchHintDark
          : AppTextStyles.searchHintLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  List<DropdownMenuItem<IconData>> _buildIconDropdownItems(bool isDarkMode) {
    return [
      DropdownMenuItem(
        value: Icons.star,
        child: Row(
          children: [
            Icon(Icons.star, color: isDarkMode ? Colors.white : Colors.black),
            const SizedBox(width: 10),
            const Text('Star'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: Icons.check_circle,
        child: Row(
          children: [
            Icon(Icons.check_circle,
                color: isDarkMode ? Colors.white : Colors.black),
            const SizedBox(width: 10),
            const Text('Check Circle'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: Icons.thumb_up,
        child: Row(
          children: [
            Icon(Icons.thumb_up,
                color: isDarkMode ? Colors.white : Colors.black),
            const SizedBox(width: 10),
            const Text('Thumb Up'),
          ],
        ),
      ),
    ];
  }

  ButtonStyle _buildButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Colors.white, width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }
}