import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pathly/providers/roadmap_provider.dart';
import 'package:pathly/models/roadmap_stage.dart';
import 'package:pathly/models/roadmap.dart';

class StagePage extends StatelessWidget {
  final String title;

  StagePage({required this.title});

  final TextEditingController _stageTitleController = TextEditingController();
  final TextEditingController _stageDescriptionController = TextEditingController();
  DateTime? _stageDueDate;
  final GlobalKey<FormState> _stageFormKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _stageDueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _stageDueDate = picked;
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(),
      prefixIcon: Icon(icon, color: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    final roadmapProvider = Provider.of<RoadmapProvider>(context);
    final roadmap = roadmapProvider.roadmaps.firstWhere(
          (r) => r.title == title,
      orElse: () => Roadmap(
        title: title,
        description: '',
        icon: Icons.map, // Provide a default icon
      ),
    );

    // Check if roadmap has a valid description
    if (roadmap.description.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Add Stages for $title'))
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Icon(Icons.error, size: 60, color: Colors.red),
      //         SizedBox(height: 20),
      //         Text(
      //           'No description provided for this roadmap.',
      //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //           textAlign: TextAlign.center,
      //         ),
      //         SizedBox(height: 10),
      //         Text(
      //           'Please add a description before adding stages.',
      //           style: TextStyle(fontSize: 16, color: Colors.grey),
      //           textAlign: TextAlign.center,
      //         ),
      //         SizedBox(height: 20),
      //         ElevatedButton(
      //           onPressed: () => Navigator.pop(context),
      //           child: Text('Go Back'),
      //         ),
      //       ],
      //     ),
      //   ),
       );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Add Stages for $title'))
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       Form(
      //         key: _stageFormKey,
      //         child: Column(
      //           children: [
      //             TextFormField(
      //               controller: _stageTitleController,
      //               decoration: _inputDecoration('Stage Title', Icons.title),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'Please enter a stage title';
      //                 }
      //                 return null;
      //               },
      //             ),
      //             SizedBox(height: 10),
      //             TextFormField(
      //               controller: _stageDescriptionController,
      //               decoration: _inputDecoration('Stage Description', Icons.description),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'Please enter a description';
      //                 }
      //                 return null;
      //               },
      //             ),
      //             SizedBox(height: 10),
      //             GestureDetector(
      //               onTap: () => _selectDate(context),
      //               child: AbsorbPointer(
      //                 child: TextFormField(
      //                   decoration: _inputDecoration(
      //                     'Stage Due Date',
      //                     Icons.calendar_today,
      //                   ).copyWith(
      //                     hintText: _stageDueDate == null
      //                         ? 'Select date'
      //                         : _stageDueDate!
      //                         .toLocal()
      //                         .toString()
      //                         .split(' ')[0],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: 20),
      //             ElevatedButton(
      //               onPressed: () {
      //                 if (_stageFormKey.currentState?.validate() ?? false) {
      //                   roadmapProvider.addStageToRoadmap(
      //                     title,
      //                     RoadmapStage(
      //                       title: _stageTitleController.text,
      //                       description: _stageDescriptionController.text,
      //                       dueDate: _stageDueDate,
      //                     ),
      //                   );
      //                   _stageTitleController.clear();
      //                   _stageDescriptionController.clear();
      //                   _stageDueDate = null;
      //                 }
      //               },
      //               child: Text('Add Stage'),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       Expanded(
      //         child: roadmap.stages.isEmpty
      //             ? Center(
      //           child: Text(
      //             'No stages added yet. Add your first stage!',
      //             style: TextStyle(fontSize: 16, color: Colors.grey),
      //           ),
      //         )
      //             : ListView.builder(
      //           itemCount: roadmap.stages.length,
      //           itemBuilder: (context, index) {
      //             final stage = roadmap.stages[index];
      //             return Card(
      //               elevation: 2,
      //               margin: EdgeInsets.symmetric(vertical: 8),
      //               child: ListTile(
      //                 title: Text(stage.title,
      //                     style: TextStyle(fontWeight: FontWeight.bold)),
      //                 subtitle: Text(
      //                   '${stage.description}\nDue: ${stage.dueDate?.toLocal().toString().split(' ')[0] ?? 'No Date'}',
      //                   style: TextStyle(color: Colors.grey[700]),
      //                 ),
      //                 isThreeLine: true,
      //                 trailing: IconButton(
      //                   icon: Icon(Icons.delete, color: Colors.red),
      //                   onPressed: () {
      //                     roadmapProvider.removeStageFromRoadmap(
      //                       title,
      //                       index,
      //                     );
      //                   },
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}