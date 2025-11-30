import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminStudySubject {
  final String id;
  final String name;
  final String emoji;

  const AdminStudySubject({
    required this.id,
    required this.name,
    required this.emoji,
  });
}

/// SAME subject list used in user Study Materials UI
const List<AdminStudySubject> kAdminStudySubjects = [
  AdminStudySubject(
    id: 'building_materials',
    name: 'Building Materials',
    emoji: '📚',
  ),
  AdminStudySubject(
    id: 'building_construction',
    name: 'Building Construction',
    emoji: '🏗️',
  ),
  AdminStudySubject(
    id: 'engineering_drawing',
    name: 'Engineering Drawing',
    emoji: '📐',
  ),
  AdminStudySubject(
    id: 'autocad',
    name: 'AutoCAD and Computer',
    emoji: '💻',
  ),
  AdminStudySubject(
    id: 'irrigation_engineering',
    name: 'Irrigation Engineering',
    emoji: '💧',
  ),
  AdminStudySubject(
    id: 'concrete_rcc',
    name: 'Concrete Technology & RCC',
    emoji: '🧱',
  ),
  AdminStudySubject(
    id: 'steel_design',
    name: 'Steel Design',
    emoji: '🔩',
  ),
  AdminStudySubject(
    id: 'environmental_engineering',
    name: 'Environmental Engineering',
    emoji: '🌱',
  ),
  AdminStudySubject(
    id: 'hydrology',
    name: 'Hydrology',
    emoji: '💦',
  ),
  AdminStudySubject(
    id: 'estimation_costing',
    name: 'Estimation, Valuation & Costing',
    emoji: '🧮',
  ),
  AdminStudySubject(
    id: 'strength_of_materials',
    name: 'Strength of Materials',
    emoji: '🪨',
  ),
  AdminStudySubject(
    id: 'highway_engineering',
    name: 'Highway Engineering',
    emoji: '🛣️',
  ),
  AdminStudySubject(
    id: 'bridge_engineering',
    name: 'Bridge Engineering',
    emoji: '🌉',
  ),
  AdminStudySubject(
    id: 'railway_engineering',
    name: 'Railway Engineering',
    emoji: '🚆',
  ),
  AdminStudySubject(
    id: 'dock_harbour_tunnel',
    name: 'Dock, Harbour & Tunnel Engineering',
    emoji: '⚓',
  ),
  AdminStudySubject(
    id: 'airport_engineering',
    name: 'Airport Engineering',
    emoji: '✈️',
  ),
  AdminStudySubject(
    id: 'surveying_levelling',
    name: 'Surveying & Levelling',
    emoji: '🗺️',
  ),
  AdminStudySubject(
    id: 'advanced_surveying',
    name: 'Advanced Surveying',
    emoji: '🧭',
  ),
  AdminStudySubject(
    id: 'engineering_mechanics',
    name: 'Engineering Mechanics',
    emoji: '⚙️',
  ),
  AdminStudySubject(
    id: 'fluid_mechanics',
    name: 'Fluid Mechanics',
    emoji: '🌊',
  ),
  AdminStudySubject(
    id: 'workshop_calculation',
    name: 'Workshop Calculation',
    emoji: '🛠️',
  ),
  AdminStudySubject(
    id: 'mechanical_engineering',
    name: 'Mechanical Engineering',
    emoji: '🔧',
  ),
];

class AdminStudyMaterialsScreen extends StatelessWidget {
  const AdminStudyMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin – Study Materials'),
      ),
      backgroundColor: const Color(0xFFF5F6FF),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: kAdminStudySubjects.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final subject = kAdminStudySubjects[index];

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
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            onTap: () => _openUploadSheet(context, subject),
          );
        },
      ),
    );
  }

  void _openUploadSheet(BuildContext context, AdminStudySubject subject) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        String noteType = 'full'; // full / short / quick
        final TextEditingController urlController = TextEditingController();
        bool saving = false;

        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> savePdf() async {
              final pdfUrl = urlController.text.trim();
              if (pdfUrl.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter PDF URL'),
                  ),
                );
                return;
              }

              try {
                setState(() {
                  saving = true;
                });

                final docId = '${subject.id}_$noteType';

                await FirebaseFirestore.instance
                    .collection('study_materials')
                    .doc(docId)
                    .set({
                  'subjectId': subject.id,
                  'subjectName': subject.name,
                  'noteType': noteType, // full / short / quick
                  'title': '${subject.name} – ${_labelFromNoteType(noteType)}',
                  'pdfUrl': pdfUrl,
                  'createdAt': FieldValue.serverTimestamp(),
                });

                if (context.mounted) {
                  Navigator.of(sheetContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Saved ${_labelFromNoteType(noteType)} for ${subject.name}',
                      ),
                    ),
                  );
                }
              } catch (e) {
                setState(() {
                  saving = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to save PDF'),
                  ),
                );
              }
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(4),
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
                    const SizedBox(height: 8),
                    const Text(
                      'Select note type and paste PDF URL.',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Note type',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      value: noteType,
                      items: const [
                        DropdownMenuItem(
                          value: 'full',
                          child: Text('Full Notes'),
                        ),
                        DropdownMenuItem(
                          value: 'short',
                          child: Text('Short Notes'),
                        ),
                        DropdownMenuItem(
                          value: 'quick',
                          child: Text('Quick Review'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          noteType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'PDF URL',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: urlController,
                      decoration: const InputDecoration(
                        hintText: 'Paste public PDF link here',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.url,
                      minLines: 1,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: saving ? null : savePdf,
                        icon: const Icon(Icons.save),
                        label: Text(saving ? 'Saving...' : 'Save PDF'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static String _labelFromNoteType(String noteType) {
    switch (noteType) {
      case 'short':
        return 'Short Notes';
      case 'quick':
        return 'Quick Review';
      case 'full':
      default:
        return 'Full Notes';
    }
  }
}