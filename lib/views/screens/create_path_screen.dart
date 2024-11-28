import 'package:flutter/material.dart';
import 'package:pathly/views/screens/stages_screen.dart';

class CreatePathScreen extends StatefulWidget {
  static final String id = '/create_path';

  @override
  _CreatePathScreenState createState() => _CreatePathScreenState();
}

class _CreatePathScreenState extends State<CreatePathScreen> {
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Roadmap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_title == null)
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Enter Roadmap Title',
                    labelStyle: TextStyle(color: Colors.black), // Fix label color
                    hintStyle: TextStyle(color: Colors.grey), // Fix hint text color
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title, color: Colors.blue),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 20),
              if (_title == null)
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        _title = _titleController.text;
                      });
                    }
                  },
                  child: Text('Add Title'),
                ),
              if (_title != null)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StagePage(title: _title!),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.blueAccent,
                    child: Text(
                      'Title: $_title',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

