import 'package:flutter/material.dart';

/// Subject model
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

/// All subjects + emojis (Study Materials)
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
    id: 'autocad_computer',
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

/// MAIN SCREEN – CIVILPSC Study Materials
class StudyMaterialsHome extends StatelessWidget {
  const StudyMaterialsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Full / Short / Quick
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FF),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2469A7),
          title: Row(
            children: const [
              Icon(Icons.menu_book_outlined, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'CIVILPSC Study Materials',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFFE3F2FD),
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Full Notes'),
              Tab(text: 'Short Notes'),
              Tab(text: 'Quick Review'),
            ],
          ),
        ),
        body: Column(
          children: const [
            _TopBanner(),
            Expanded(
              child: TabBarView(
                children: [
                  _StudyMaterialsTab(notesTypeLabel: 'Full Notes'),
                  _StudyMaterialsTab(notesTypeLabel: 'Short Notes'),
                  _StudyMaterialsTab(notesTypeLabel: 'Quick Review'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// BLUE GRADIENT BANNER
class _TopBanner extends StatelessWidget {
  const _TopBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF4C8DFF), Color(0xFF6AC8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.menu_book_rounded, color: Colors.white, size: 30),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Organised notes for every subject',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
        ],
      ),
    );
  }
}

/// ONE TAB – shows the same subject list with different note-type label
class _StudyMaterialsTab extends StatelessWidget {
  final String notesTypeLabel; // Full Notes / Short Notes / Quick Review

  const _StudyMaterialsTab({required this.notesTypeLabel});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
            radius: 22,
            backgroundColor: const Color(0xFFE3F2FD),
            child: Text(
              subject.emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          title: Text(
            '${subject.name} – $notesTypeLabel',
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
          onTap: () {
            // ഇപ്പോൾ PDF connect ചെയ്തിട്ടില്ല.
            // പിന്നെ Firebase / asset link add ചെയ്യുമ്പോൾ
            // ഇവിടെ നിന്ന് PdfViewerScreen open ചെയാം.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Notes for ${subject.name} ($notesTypeLabel) coming soon',
                ),
              ),
            );
          },
        );
      },
    );
  }
}