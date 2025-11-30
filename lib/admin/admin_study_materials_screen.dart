import 'package:flutter/material.dart';

class StudySubject {
  final String id;
  final String name;
  final String emoji;

  const StudySubject({
    required this.id,
    required this.name,
    required this.emoji,
  });
}

// Subjects for PDF (without Miscellaneous & Statement)
const List<StudySubject> kStudySubjects = [
  StudySubject(
    id: 'autocad_computer',
    name: 'AutoCAD and Computer',
    emoji: '💻',
  ),
  StudySubject(
    id: 'building_materials',
    name: 'Building Materials',
    emoji: '📚',
  ),
  StudySubject(
    id: 'building_construction',
    name: 'Building Construction',
    emoji: '🏗️',
  ),
  StudySubject(
    id: 'concrete_rcc',
    name: 'Concrete Technology & RCC',
    emoji: '🧱',
  ),
  StudySubject(
    id: 'surveying_levelling',
    name: 'Surveying and Levelling',
    emoji: '🗺️',
  ),
  StudySubject(
    id: 'engineering_drawing',
    name: 'Engineering Drawing',
    emoji: '📐',
  ),
  StudySubject(
    id: 'estimation_costing',
    name: 'Estimation and Costing',
    emoji: '🧮',
  ),
  StudySubject(
    id: 'building_bye_laws',
    name: 'Building Bye Laws',
    emoji: '🏛️',
  ),
  StudySubject(
    id: 'irrigation_hydrology',
    name: 'Irrigation and Hydrology',
    emoji: '💧',
  ),
  StudySubject(
    id: 'transportation_engineering',
    name: 'Transportation Engineering',
    emoji: '🛣️',
  ),
  StudySubject(
    id: 'environmental_engineering',
    name: 'Environmental Engineering',
    emoji: '🌱',
  ),
  StudySubject(
    id: 'applied_mechanics',
    name: 'Applied Mechanics',
    emoji: '⚙️',
  ),
  StudySubject(
    id: 'units_conversions',
    name: 'Units and Conversions',
    emoji: '📏',
  ),
  StudySubject(
    id: 'fluid_mechanics',
    name: 'Fluid Mechanics',
    emoji: '🌊',
  ),
  StudySubject(
    id: 'strength_of_material',
    name: 'Strength of Material',
    emoji: '🪨',
  ),
  StudySubject(
    id: 'structural_analysis',
    name: 'Structural Analysis',
    emoji: '🏗️',
  ),
  StudySubject(
    id: 'steel_structure',
    name: 'Design of Steel Structure',
    emoji: '🔩',
  ),
  StudySubject(
    id: 'geotechnical_engineering',
    name: 'Geotechnical Engineering',
    emoji: '⛰️',
  ),
  StudySubject(
    id: 'construction_management',
    name: 'Construction Management',
    emoji: '📋',
  ),
  StudySubject(
    id: 'architectural_engineering',
    name: 'Architectural Engineering',
    emoji: '🏛️',
  ),
  StudySubject(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Total subjects: ${kStudySubjects.length}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: kStudySubjects.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final subject = kStudySubjects[index];

                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    radius: 24,
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
                    'Tap to add PDF (coming soon)',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Add PDF for ${subject.name} (feature coming soon)',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
