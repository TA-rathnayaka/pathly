import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/roadmap_provider.dart';
import 'package:pathly/models/roadmap_stage.dart';
import 'package:pathly/models/roadmap.dart';
import 'package:pathly/config/app_theme.dart';
import 'package:pathly/views/components/stage_card.dart';
import 'package:pathly/views/components/stage_card_list.dart';

class StagePage extends StatelessWidget {
  final String roadmapId;

  StagePage({super.key, required this.roadmapId});

  final TextEditingController _stageTitleController = TextEditingController();
  final TextEditingController _stageDescriptionController = TextEditingController();
  int? _editingStageIndex;

  void _fillFormForEdit(RoadmapStage stage, int index) {
    _stageTitleController.text = stage.title;
    _stageDescriptionController.text = stage.description;
    _editingStageIndex = index;
  }

  void _showBottomSheet(BuildContext context, RoadmapProvider roadmapProvider) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TextFormField for entering the stage title
              TextFormField(
                controller: _stageTitleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode
                      ? AppColors.darkCard.withOpacity(0.85)
                      : Colors.grey[200]!.withOpacity(0.85),
                  hintText: 'Enter Stage Title',
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
                    return 'Please enter a stage title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // TextFormField for entering the stage description
              TextFormField(
                controller: _stageDescriptionController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode
                      ? AppColors.darkCard.withOpacity(0.85)
                      : Colors.grey[200]!.withOpacity(0.85),
                  hintText: 'Enter Stage Description',
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
                    return 'Please enter a stage description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Add or Update Stage Button
              ElevatedButton(
                onPressed: () {
                  if (_stageTitleController.text.isNotEmpty &&
                      _stageDescriptionController.text.isNotEmpty) {
                    if (_editingStageIndex != null) {
                      // Update stage
                      roadmapProvider.updateStageInRoadmap(
                        roadmapId,
                        _editingStageIndex!,
                        RoadmapStage(
                          title: _stageTitleController.text,
                          description: _stageDescriptionController.text,
                        ),
                      );
                    } else {
                      // Add new stage
                      roadmapProvider.addStageToRoadmap(
                        roadmapId,
                        RoadmapStage(
                          title: _stageTitleController.text,
                          description: _stageDescriptionController.text,
                        ),
                      );
                    }

                    _stageTitleController.clear();
                    _stageDescriptionController.clear();
                    _editingStageIndex = null;
                    Navigator.pop(context); // Close bottom sheet after saving
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Text(_editingStageIndex != null ? 'Update Stage' : 'Add Stage'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final roadmapProvider = Provider.of<RoadmapProvider>(context);
    final roadmap = roadmapProvider.roadmaps.firstWhere(
          (r) => r.id == roadmapId,
      orElse: () => Roadmap(
        id: '',
        uid: '',
        title: '',
        description: '',
        imageUrl: '',
        icon: Icons.map,
      ),
    );

    if (roadmap.description.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Add Stages')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 60, color: Colors.red),
              const SizedBox(height: 20),
              const Text(
                'No description provided for this roadmap.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Please add a description before adding stages.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Add Stages for ${roadmap.title}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display added stages
            roadmap.stages.isEmpty
                ? const Center(
              child: Text(
                'No stages added yet. Add your first stage!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : StageCardList(
              groupTitle: 'Stages',
              stageCards: roadmap.stages.map((stage) {
                return StageCard(
                  icon: Icons.check_circle,
                  title: stage.title,
                  description: stage.description,
                  onEdit: () {
                    // Fill the form with stage details for editing
                    _fillFormForEdit(stage, roadmap.stages.indexOf(stage));
                    _showBottomSheet(context, roadmapProvider); // Open the bottom sheet for editing
                  },
                  onDelete: () {
                    roadmapProvider.removeStageFromRoadmap(
                        roadmapId, roadmap.stages.indexOf(stage));
                  },
                  iconBackgroundColor: Colors.black54,
                  iconColor: Colors.white,
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context, roadmapProvider); // Show bottom sheet for adding/editing stage
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}