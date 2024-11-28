import 'package:flutter/material.dart';

class StagePage extends StatefulWidget {
  final String title;

  StagePage({required this.title});

  @override
  _StagePageState createState() => _StagePageState();
}

class _StagePageState extends State<StagePage> {
  final TextEditingController _stageTitleController = TextEditingController();
  final TextEditingController _stageDescriptionController =
  TextEditingController();
  DateTime? _stageDueDate;
  final GlobalKey<FormState> _stageFormKey = GlobalKey<FormState>();

  List<RoadmapStage> _stages = [];

  void _addStage() {
    if (_stageFormKey.currentState?.validate() ?? false) {
      setState(() {
        _stages.add(RoadmapStage(
          title: _stageTitleController.text,
          description: _stageDescriptionController.text,
          dueDate: _stageDueDate,
        ));
        _stageTitleController.clear();
        _stageDescriptionController.clear();
        _stageDueDate = null;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _stageDueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _stageDueDate = picked;
      });
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
    return Scaffold(
      appBar: AppBar(title: Text('Add Stages for ${widget.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _stageFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _stageTitleController,
                    decoration: _inputDecoration('Stage Title', Icons.title),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a stage title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _stageDescriptionController,
                    decoration: _inputDecoration(
                        'Stage Description', Icons.description),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: _inputDecoration(
                          'Stage Due Date',
                          Icons.calendar_today,
                        ).copyWith(
                          hintText: _stageDueDate == null
                              ? 'Select date'
                              : _stageDueDate!
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addStage,
                    child: Text('Add Stage'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _stages.isEmpty
                  ? Center(
                child: Text(
                  'No stages added yet. Add your first stage!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: _stages.length,
                itemBuilder: (context, index) {
                  final stage = _stages[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(stage.title,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${stage.description}\nDue: ${stage.dueDate?.toLocal().toString().split(' ')[0] ?? 'No Date'}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _stages.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoadmapStage {
  final String title;
  final String description;
  final DateTime? dueDate;

  RoadmapStage({required this.title, required this.description, this.dueDate});
}