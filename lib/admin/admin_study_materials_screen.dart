import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Simple model for admin subject row + dropdown
class _AdminSubject {
  final String id;
  final String name;
  final String emoji;

  const _AdminSubject({
    required this.id,
    required this.name,
    required this.emoji,
  });
}

/// --- SUBJECT LIST (Study Materials) ---
/// Firestore-ിൽ subjectId ആയി ഇവ ഉപയോഗിക്കും.
const List<_AdminSubject> _subjects = [
  _AdminSubject(
    id: 'autocad_computer',
    name: 'AutoCAD and Computer',
    emoji: '💻',
  ),
  _AdminSubject(
    id: 'building_materials',
    name: 'Building Materials',
    emoji: '📚',
  ),
  _AdminSubject(
    id: 'building_construction',
    name: 'Building Construction',
    emoji: '🏗️',
  ),
  _AdminSubject(
    id: 'engineering_drawing',
    name: 'Engineering Drawing',
    emoji: '📐',
  ),
  _AdminSubject(
    id: 'concrete_rcc',
    name: 'Concrete Technology & RCC',
    emoji: '🧱',
  ),
  _AdminSubject(
    id: 'surveying_levelling',
    name: 'Surveying and Levelling',
    emoji: '🗺️',
  ),
  _AdminSubject(
    id: 'estimation_costing',
    name: 'Estimation and Costing',
    emoji: '🧮',
  ),
  _AdminSubject(
    id: 'building_bye_laws',
    name: 'Building Bye Laws',
    emoji: '🏛️',
  ),
  _AdminSubject(
    id: 'irrigation_hydrology',
    name: 'Irrigation and Hydrology',
    emoji: '💧',
  ),
  _AdminSubject(
    id: 'transportation_engineering',
    name: 'Transportation Engineering',
    emoji: '🛣️',
  ),
  _AdminSubject(
    id: 'environmental_engineering',
    name: 'Environmental Engineering',
    emoji: '🌱',
  ),
  _AdminSubject(
    id: 'applied_mechanics',
    name: 'Applied Mechanics',
    emoji: '⚙️',
  ),
  _AdminSubject(
    id: 'units_conversions',
    name: 'Units and Conversions',
    emoji: '📏',
  ),
  _AdminSubject(
    id: 'fluid_mechanics',
    name: 'Fluid Mechanics',
    emoji: '🌊',
  ),
  _AdminSubject(
    id: 'strength_of_material',
    name: 'Strength of Material',
    emoji: '🪨',
  ),
  _AdminSubject(
    id: 'structural_analysis',
    name: 'Structural Analysis',
    emoji: '🏗️',
  ),
  _AdminSubject(
    id: 'steel_structure',
    name: 'Design of Steel Structure',
    emoji: '🔩',
  ),
  _AdminSubject(
    id: 'geotechnical_engineering',
    name: 'Geotechnical Engineering',
    emoji: '⛰️',
  ),
  _AdminSubject(
    id: 'construction_management',
    name: 'Construction Management',
    emoji: '📋',
  ),
  _AdminSubject(
    id: 'architectural_engineering',
    name: 'Architectural Engineering',
    emoji: '🏛️',
  ),
  _AdminSubject(
    id: 'mechanical_engineering',
    name: 'Mechanical Engineering',
    emoji: '🔧',
  ),
];

/// --- NOTE TYPES (Full / Short / Quick) ---
const Map<String, String> _noteTypeLabels = {
  'full': 'Full Notes',
  'short': 'Short Notes',
  'quick': 'Quick Review',
};

class AdminStudyMaterialsScreen extends StatelessWidget {
  const AdminStudyMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin – Study Materials'),
      ),
      backgroundColor: const Color(0xFFF5F6FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Select subject and add / update PDF link.',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              itemCount: _subjects.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final subject = _subjects[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFFE3F2FD),
                    child: Text(
                      subject.emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  title: Text(
                    subject.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: const Text(
                    'Tap to add / update PDF',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  onTap: () => _openEditSheet(context, subject),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openEditSheet(BuildContext context, _AdminSubject subject) {
    String selectedType = 'full';
    final titleController = TextEditingController(
      text: '${subject.name} – ${_noteTypeLabels[selectedType]}',
    );
    final urlController = TextEditingController();
    bool saving = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final viewInsets = MediaQuery.of(ctx).viewInsets;
        return Padding(
          padding: EdgeInsets.only(
            bottom: viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              Future<void> save() async {
                if (urlController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PDF URL is required')),
                  );
                  return;
                }

                setModalState(() => saving = true);

                final typeLabel = _noteTypeLabels[selectedType]!;
                final fallbackTitle = '${subject.name} – $typeLabel';

                try {
                  await FirebaseFirestore.instance
                      .collection('study_materials')
                      .doc('${subject.id}_$selectedType')
                      .set({
                    'subjectId': subject.id,
                    'subjectName': subject.name,
                    'type': selectedType,
                    'title': (titleController.text.trim().isEmpty)
                        ? fallbackTitle
                        : titleController.text.trim(),
                    'pdfUrl': urlController.text.trim(),
                    'updatedAt': FieldValue.serverTimestamp(),
                  }, SetOptions(merge: true));

                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$typeLabel for ${subject.name} saved ✅',
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error saving: $e')),
                    );
                  }
                } finally {
                  setModalState(() => saving = false);
                }
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Text(
                      subject.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Select note type and paste PDF URL.',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Note type',
                        border: OutlineInputBorder(),
                      ),
                      items: _noteTypeLabels.entries
                          .map(
                            (e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setModalState(() {
                          selectedType = value;
                          final label = _noteTypeLabels[selectedType]!;
                          titleController.text = '${subject.name} – $label';
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title (shown to students)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: urlController,
                      decoration: const InputDecoration(
                        labelText: 'PDF URL (Firebase Storage link)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: saving
                            ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                            : const Icon(Icons.save),
                        label: Text(saving ? 'Saving...' : 'Save PDF'),
                        onPressed: saving ? null : save,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}