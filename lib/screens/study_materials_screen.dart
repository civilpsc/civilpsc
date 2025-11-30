import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../admin/admin_study_materials_screen.dart';
import 'pdf_viewer_screen.dart';

class StudyMaterialsHome extends StatelessWidget {
  const StudyMaterialsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Icon(Icons.menu_book_outlined),
              SizedBox(width: 8),
              Text('CIVILPSC Study Materials'),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Full Notes'),
              Tab(text: 'Short Notes'),
              Tab(text: 'Quick Review'),
            ],
          ),
        ),
        backgroundColor: const Color(0xFFF5F6FF),
        body: const TabBarView(
          children: [
            _StudyMaterialsTab(noteType: 'full'),
            _StudyMaterialsTab(noteType: 'short'),
            _StudyMaterialsTab(noteType: 'quick'),
          ],
        ),
      ),
    );
  }
}

/// same subjects as admin
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

const List<StudySubject> kStudySubjects = [
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
    id: 'engineering_drawing',
    name: 'Engineering Drawing',
    emoji: '📐',
  ),
  StudySubject(
    id: 'autocad',
    name: 'AutoCAD and Computer',
    emoji: '💻',
  ),
  StudySubject(
    id: 'irrigation_engineering',
    name: 'Irrigation Engineering',
    emoji: '💧',
  ),
  StudySubject(
    id: 'concrete_rcc',
    name: 'Concrete Technology & RCC',
    emoji: '🧱',
  ),
  StudySubject(
    id: 'steel_design',
    name: 'Steel Design',
    emoji: '🔩',
  ),
  StudySubject(
    id: 'environmental_engineering',
    name: 'Environmental Engineering',
    emoji: '🌱',
  ),
  StudySubject(
    id: 'hydrology',
    name: 'Hydrology',
    emoji: '💦',
  ),
  StudySubject(
    id: 'estimation_costing',
    name: 'Estimation, Valuation & Costing',
    emoji: '🧮',
  ),
  StudySubject(
    id: 'strength_of_materials',
    name: 'Strength of Materials',
    emoji: '🪨',
  ),
  StudySubject(
    id: 'highway_engineering',
    name: 'Highway Engineering',
    emoji: '🛣️',
  ),
  StudySubject(
    id: 'bridge_engineering',
    name: 'Bridge Engineering',
    emoji: '🌉',
  ),
  StudySubject(
    id: 'railway_engineering',
    name: 'Railway Engineering',
    emoji: '🚆',
  ),
  StudySubject(
    id: 'dock_harbour_tunnel',
    name: 'Dock, Harbour & Tunnel Engineering',
    emoji: '⚓',
  ),
  StudySubject(
    id: 'airport_engineering',
    name: 'Airport Engineering',
    emoji: '✈️',
  ),
  StudySubject(
    id: 'surveying_levelling',
    name: 'Surveying & Levelling',
    emoji: '🗺️',
  ),
  StudySubject(
    id: 'advanced_surveying',
    name: 'Advanced Surveying',
    emoji: '🧭',
  ),
  StudySubject(
    id: 'engineering_mechanics',
    name: 'Engineering Mechanics',
    emoji: '⚙️',
  ),
  StudySubject(
    id: 'fluid_mechanics',
    name: 'Fluid Mechanics',
    emoji: '🌊',
  ),
  StudySubject(
    id: 'workshop_calculation',
    name: 'Workshop Calculation',
    emoji: '🛠️',
  ),
  StudySubject(
    id: 'mechanical_engineering',
    name: 'Mechanical Engineering',
    emoji: '🔧',
  ),
];

class _StudyMaterialsTab extends StatelessWidget {
  final String noteType; // full / short / quick

  const _StudyMaterialsTab({
    required this.noteType,
  });

  String _tabLabel() {
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

  @override
  Widget build(BuildContext context) {
    final label = _tabLabel();

    return Column(
      children: [
        const SizedBox(height: 12),
        // Top info card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Color(0xFF4C8DFF), Color(0xFF6AC8FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Organised notes for every subject',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Switch tabs for Full notes, Short notes and Quick revision.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Subject list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  backgroundColor: const Color(0xFFE3F2FD),
                  child: Text(
                    subject.emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                title: Text(
                  '${subject.name} – $label',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  subject.name,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                onTap: () => _openPdfForSubject(context, subject),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _openPdfForSubject(
      BuildContext context, StudySubject subject) async {
    final docId = '${subject.id}_$noteType';

    try {
      final doc = await FirebaseFirestore.instance
          .collection('study_materials')
          .doc(docId)
          .get();

      if (!doc.exists || !(doc.data()?['pdfUrl'] is String)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Notes for ${subject.name} – ${_tabLabel()} not added yet',
            ),
          ),
        );
        return;
      }

      final data = doc.data()!;
      final pdfUrl = data['pdfUrl'] as String;
      final title = data['title'] as String? ??
          '${subject.name} – ${_tabLabel()}';

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PdfViewerScreen(
            title: title,
            pdfUrl: pdfUrl,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load note. Please try again.'),
        ),
      );
    }
  }
}