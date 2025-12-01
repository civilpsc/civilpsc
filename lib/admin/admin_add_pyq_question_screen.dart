import 'package:flutter/material.dart';

/// All available posts for PYQ questions (dropdown list)
const List<String> kPostNames = [
  'Draftsman / Overseer Gr III',
  'Draftsman / Overseer Gr II',
  'Draftsman / Overseer Gr I',
  'Work Superintendent',
  'Junior Instructor',
  'Tracer',
  'Surveyor',
  'Tradesman',
  'Project Engineer',
  'Town Planning',
  'Assistant Engineer',
  'Junior Technical Officer',
  'Assistant Professor & Lecturer',
  'Architectural Draftsman',
  'Vocational Instructor',
  'Model exam',
];

/// Simple placeholder screen for adding PYQ questions.
/// Later we can connect this to Firestore.
class AdminAddPyqQuestionScreen extends StatefulWidget {
  const AdminAddPyqQuestionScreen({super.key});

  @override
  State<AdminAddPyqQuestionScreen> createState() =>
      _AdminAddPyqQuestionScreenState();
}

class _AdminAddPyqQuestionScreenState extends State<AdminAddPyqQuestionScreen> {
  final _formKey = GlobalKey<FormState>();

  // Name of the post is now a dropdown, not a TextField
  String? _selectedPostName;

  final _paperCodeController = TextEditingController();
  final _questionNumberController = TextEditingController(text: '1');
  final _questionController = TextEditingController();
  final _optionAController = TextEditingController();
  final _optionBController = TextEditingController();
  final _optionCController = TextEditingController();
  final _optionDController = TextEditingController();

  String _selectedSubject = 'AutoCAD and Computer';
  String _correctOption = 'A';

  // Only for subject drop-down in this screen
  final List<String> _subjects = const [
    'AutoCAD and Computer',
    'Building Material',
    'Building Construction',
    'Concrete Technology & RCC',
    'Surveying and Levelling',
    'Engineering Drawing',
    'Estimation and Costing',
    'Building Bye Laws',
    'Irrigation and Hydrology',
    'Transportation Engineering',
    'Environmental Engineering',
    'Applied Mechanics',
    'Units and Conversions',
    'Fluid Mechanics',
    'Strength of Material',
    'Structural Analysis',
    'Design of Steel Structure',
    'Geotechnical Engineering',
    'Construction Management',
    'Architectural Engineering',
    'Mechanical engineering',
    'Miscellaneous Questions',
    'Statement level questions',
  ];

  @override
  void dispose() {
    _paperCodeController.dispose();
    _questionNumberController.dispose();
    _questionController.dispose();
    _optionAController.dispose();
    _optionBController.dispose();
    _optionCController.dispose();
    _optionDController.dispose();
    super.dispose();
  }

  void _saveQuestion() {
    if (!_formKey.currentState!.validate()) return;

    final postName = _selectedPostName;
    final paperCode = _paperCodeController.text.trim();
    final questionNumber = _questionNumberController.text.trim();
    final subject = _selectedSubject;
    final questionText = _questionController.text.trim();
    final optionA = _optionAController.text.trim();
    final optionB = _optionBController.text.trim();
    final optionC = _optionCController.text.trim();
    final optionD = _optionDController.text.trim();
    final correctOption = _correctOption;

    // TODO: connect this map to Firestore later
    final payload = {
      'postName': postName,
      'paperCode': paperCode,
      'questionNumber': questionNumber,
      'subject': subject,
      'question': questionText,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'correctOption': correctOption,
    };
    // ignore: avoid_print
    print(payload);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Question saved (dummy). Firestore hook coming later.'),
      ),
    );

    // Increase question number, clear only question + options
    final currentQ =
        int.tryParse(_questionNumberController.text.trim()) ?? 1;
    _questionNumberController.text = (currentQ + 1).toString();

    _questionController.clear();
    _optionAController.clear();
    _optionBController.clear();
    _optionCController.clear();
    _optionDController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin – Add PYQ Question'),
      ),
      backgroundColor: const Color(0xFFF5F6FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // -------- Name of the post (DROPDOWN) --------
              DropdownButtonFormField<String>(
                value: _selectedPostName,
                decoration: const InputDecoration(
                  labelText: 'Name of the post',
                  border: OutlineInputBorder(),
                ),
                items: kPostNames
                    .map(
                      (post) => DropdownMenuItem<String>(
                    value: post,
                    child: Text(
                      post,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedPostName = value);
                },
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              // -------- Paper code --------
              TextFormField(
                controller: _paperCodeController,
                decoration: const InputDecoration(
                  labelText: 'Question paper code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              // -------- Question number + Subject row --------
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _questionNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Question number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      (value == null || value.isEmpty) ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedSubject,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                      ),
                      items: _subjects
                          .map(
                            (s) => DropdownMenuItem(
                          value: s,
                          child: Text(
                            s,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedSubject = value);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // -------- Question text --------
              TextFormField(
                controller: _questionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              // -------- Options A–D --------
              TextFormField(
                controller: _optionAController,
                decoration: const InputDecoration(
                  labelText: 'Option A',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _optionBController,
                decoration: const InputDecoration(
                  labelText: 'Option B',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _optionCController,
                decoration: const InputDecoration(
                  labelText: 'Option C',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _optionDController,
                decoration: const InputDecoration(
                  labelText: 'Option D',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              // -------- Correct option dropdown --------
              DropdownButtonFormField<String>(
                value: _correctOption,
                decoration: const InputDecoration(
                  labelText: 'Correct option',
                  border: OutlineInputBorder(),
                ),
                items: const ['A', 'B', 'C', 'D']
                    .map(
                      (c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _correctOption = value);
                  }
                },
              ),
              const SizedBox(height: 18),

              // -------- Save button --------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save question'),
                  onPressed: _saveQuestion,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}