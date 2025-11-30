import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// MAIN ADMIN HOME MENU
/// From here you can:
/// 1) Manage Study Material PDFs
/// 2) Add PYQ Questions
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Admin Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Manage Study PDFs
            _AdminMenuCard(
              icon: Icons.picture_as_pdf,
              title: 'Manage Study Material PDFs',
              subtitle: 'Add Full / Short / Quick notes via URL',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AdminStudyMaterialScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // Add PYQ Questions
            _AdminMenuCard(
              icon: Icons.list_alt,
              title: 'Add PYQ Questions',
              subtitle: 'Add questions with options & subject',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AdminAddQuestionScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminMenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AdminMenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: scheme.primary.withOpacity(0.1),
              child: Icon(icon, color: scheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// STUDY MATERIAL PDF ADMIN
///////////////////////////////////////////////////////////////////////////////

/// Subject -> Emoji mapping for Study Materials
const Map<String, String> kStudySubjectEmojis = {
  'Building Materials': '📚',
  'Building Construction': '🏗️',
  'Engineering Drawing': '📐',
  'AutoCAD': '💻',
  'Irrigation Engineering': '💧',
  'Concrete Technology & RCC': '🧱',
  'Steel Design': '🔩',
  'Environmental Engineering': '🌱',
  'Hydrology': '💦',
  'Estimation, Valuation & Costing': '🧮',
  'Strength of Materials': '🪨',
  'Highway Engineering': '🛣️',
  'Bridge Engineering': '🌉',
  'Railway Engineering': '🚆',
  'Dock, Harbour & Tunnel Engineering': '⚓',
  'Airport Engineering': '✈️',
  'Surveying & Levelling': '🗺️',
  'Advanced Surveying': '🧭',
  'Engineering Mechanics': '⚙️',
  'Fluid Mechanics': '🌊',
  'Workshop Calculation': '🛠️',
  'Mechanical Engineering': '🔧',
};

const List<String> kStudyNoteTypes = [
  'Full Notes',
  'Short Notes',
  'Quick Revision',
];

/// This screen lets you add/update Study Materials PDFs.
/// Writes to Firestore collection: "study_materials"
class AdminStudyMaterialScreen extends StatefulWidget {
  const AdminStudyMaterialScreen({super.key});

  @override
  State<AdminStudyMaterialScreen> createState() =>
      _AdminStudyMaterialScreenState();
}

class _AdminStudyMaterialScreenState extends State<AdminStudyMaterialScreen> {
  String _selectedSubject = kStudySubjectEmojis.keys.first;
  String _selectedNoteType = kStudyNoteTypes.first;
  final TextEditingController _pdfUrlController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _pdfUrlController.dispose();
    super.dispose();
  }

  String _noteTypeKey(String label) {
    switch (label) {
      case 'Full Notes':
        return 'full';
      case 'Short Notes':
        return 'short';
      case 'Quick Revision':
        return 'cheat';
      default:
        return 'full';
    }
  }

  String _buildTitle() {
    return '$_selectedSubject – $_selectedNoteType';
  }

  String _slugify(String input) {
    final lower = input.toLowerCase();
    final cleaned = lower.replaceAll(RegExp(r'[^a-z0-9]+'), '_');
    return cleaned.replaceAll(RegExp(r'_+'), '_').trim();
  }

  Future<void> _saveStudyMaterial() async {
    final pdfUrl = _pdfUrlController.text.trim();
    if (pdfUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please paste the PDF URL')),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      final subject = _selectedSubject;
      final emoji = kStudySubjectEmojis[subject] ?? '📚';
      final typeKey = _noteTypeKey(_selectedNoteType);
      final title = _buildTitle();

      final subjectKey = _slugify(subject);
      final docId = '${subjectKey}_$typeKey';

      final docRef =
      FirebaseFirestore.instance.collection('study_materials').doc(docId);

      await docRef.set(
        {
          'title': title,
          'subject': subject,
          'type': typeKey, // full | short | cheat
          'emoji': emoji,
          'pdfUrl': pdfUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved: $title'),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      debugPrint('Error saving study material: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save study material')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Admin – Study Materials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add / Update Study PDF',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Subject + Note type
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSubject,
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                    items: kStudySubjectEmojis.entries
                        .map(
                          (e) => DropdownMenuItem<String>(
                        value: e.key,
                        child: Row(
                          children: [
                            Text(e.value),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                e.key,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() => _selectedSubject = v);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedNoteType,
                    decoration: const InputDecoration(
                      labelText: 'Note type',
                      border: OutlineInputBorder(),
                    ),
                    items: kStudyNoteTypes
                        .map(
                          (t) => DropdownMenuItem<String>(
                        value: t,
                        child: Text(t),
                      ),
                    )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() => _selectedNoteType = v);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Title preview
            const Text(
              'Title (auto-generated)',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFF5F5F5),
              ),
              child: Text(
                _buildTitle(),
                style:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 12),

            // PDF URL field
            TextField(
              controller: _pdfUrlController,
              decoration: const InputDecoration(
                labelText: 'PDF URL (from Firebase Storage)',
                hintText: 'https://firebasestorage.googleapis.com/...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: _saving ? null : _saveStudyMaterial,
                icon: _saving
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Icon(Icons.save),
                label: Text(
                  _saving ? 'Saving...' : 'Save Study Material',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// PYQ QUESTION ADMIN (same idea as before)
///////////////////////////////////////////////////////////////////////////////

/// Subject list for PYQ questions (as discussed earlier).
const List<String> kQuestionSubjects = [
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

/// Simple screen for adding one PYQ question at a time.
/// Writes to Firestore collection: "pyq_questions"
class AdminAddQuestionScreen extends StatefulWidget {
  const AdminAddQuestionScreen({super.key});

  @override
  State<AdminAddQuestionScreen> createState() => _AdminAddQuestionScreenState();
}

class _AdminAddQuestionScreenState extends State<AdminAddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();

  final _examNameController = TextEditingController();
  final _examCodeController = TextEditingController();
  final _questionNumberController = TextEditingController(text: '1');
  final _questionTextController = TextEditingController();
  final _optionAController = TextEditingController();
  final _optionBController = TextEditingController();
  final _optionCController = TextEditingController();
  final _optionDController = TextEditingController();

  String _selectedCorrectOption = 'A';
  String _selectedSubject = kQuestionSubjects.first;

  bool _isSaving = false;

  @override
  void dispose() {
    _examNameController.dispose();
    _examCodeController.dispose();
    _questionNumberController.dispose();
    _questionTextController.dispose();
    _optionAController.dispose();
    _optionBController.dispose();
    _optionCController.dispose();
    _optionDController.dispose();
    super.dispose();
  }

  Future<void> _saveQuestion() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final examName = _examNameController.text.trim();
      final examCode = _examCodeController.text.trim();
      final questionNumber =
          int.tryParse(_questionNumberController.text.trim()) ?? 0;

      await FirebaseFirestore.instance.collection('pyq_questions').add({
        'examName': examName,
        'examCode': examCode,
        'questionNumber': questionNumber,
        'questionText': _questionTextController.text.trim(),
        'optionA': _optionAController.text.trim(),
        'optionB': _optionBController.text.trim(),
        'optionC': _optionCController.text.trim(),
        'optionD': _optionDController.text.trim(),
        'correctOption': _selectedCorrectOption,
        'subject': _selectedSubject,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Question saved ✅')),
      );

      setState(() {
        _questionNumberController.text = (questionNumber + 1).toString();
        _questionTextController.clear();
        _optionAController.clear();
        _optionBController.clear();
        _optionCController.clear();
        _optionDController.clear();
        _selectedCorrectOption = 'A';
        // Subject is kept same for fast entry
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save question: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Admin – Add PYQ Question'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exam info
                TextFormField(
                  controller: _examNameController,
                  decoration: const InputDecoration(
                    labelText: 'Name of the post / exam',
                    hintText: 'Draftsman Gr III – PWD / Irrigation',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _examCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Question paper code',
                    hintText: '60/2019',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Question number + Subject
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _questionNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Question number',
                          hintText: '1',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
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
                        items: kQuestionSubjects
                            .map(
                              (s) => DropdownMenuItem<String>(
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
                            setState(() {
                              _selectedSubject = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Question text
                TextFormField(
                  controller: _questionTextController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Question',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Options
                _buildOptionField('Option A', _optionAController),
                const SizedBox(height: 8),
                _buildOptionField('Option B', _optionBController),
                const SizedBox(height: 8),
                _buildOptionField('Option C', _optionCController),
                const SizedBox(height: 8),
                _buildOptionField('Option D', _optionDController),
                const SizedBox(height: 12),

                // Correct option
                DropdownButtonFormField<String>(
                  value: _selectedCorrectOption,
                  decoration: const InputDecoration(
                    labelText: 'Correct option',
                    border: OutlineInputBorder(),
                  ),
                  items: const ['A', 'B', 'C', 'D']
                      .map(
                        (o) => DropdownMenuItem(
                      value: o,
                      child: Text(o),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCorrectOption = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSaving ? null : _saveQuestion,
                    icon: _isSaving
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Icon(Icons.save),
                    label: Text(
                      _isSaving ? 'Saving...' : 'Save question',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
    );
  }
}
