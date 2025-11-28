import 'package:flutter/material.dart';

class StudyMaterialsHome extends StatelessWidget {
  const StudyMaterialsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('📚 CIVILPSC Study Materials'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '📘 Full Notes'),
              Tab(text: '⚡ Short Notes'),
              Tab(text: '🚀 Quick Revision'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MaterialsList(type: 'full'),
            MaterialsList(type: 'short'),
            MaterialsList(type: 'cheat'),
          ],
        ),
      ),
    );
  }
}

class MaterialsList extends StatelessWidget {
  final String type;
  const MaterialsList({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final items = _allMaterials.where((m) => m.type == type).toList();

    if (items.isEmpty) {
      return const Center(child: Text('No materials added yet'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final m = items[index];
        return ListTile(
          leading: Text(m.emoji, style: const TextStyle(fontSize: 24)),
          title: Text(m.title),
          subtitle: Text(m.subject),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PdfPlaceholderPage(item: m),
              ),
            );
          },
        );
      },
    );
  }
}

class MaterialItem {
  final String title;
  final String subject;
  final String type; // full | short | cheat
  final String emoji;

  MaterialItem({
    required this.title,
    required this.subject,
    required this.type,
    required this.emoji,
  });
}

// ---- ALL SUBJECTS: FULL / SHORT / CHEAT ----

final List<MaterialItem> _allMaterials = [
  // Building Materials
  MaterialItem(
      title: 'Building Materials – Full Notes',
      subject: 'Building Materials',
      type: 'full',
      emoji: '📚'),
  MaterialItem(
      title: 'Building Materials – Short Notes',
      subject: 'Building Materials',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Building Materials – Cheat Sheet',
      subject: 'Building Materials',
      type: 'cheat',
      emoji: '🚀'),

  // Building Construction
  MaterialItem(
      title: 'Building Construction – Full Notes',
      subject: 'Building Construction',
      type: 'full',
      emoji: '🏗️'),
  MaterialItem(
      title: 'Building Construction – Short Notes',
      subject: 'Building Construction',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Building Construction – Cheat Sheet',
      subject: 'Building Construction',
      type: 'cheat',
      emoji: '🚀'),

  // Engineering Drawing
  MaterialItem(
      title: 'Engineering Drawing – Full Notes',
      subject: 'Engineering Drawing',
      type: 'full',
      emoji: '📐'),
  MaterialItem(
      title: 'Engineering Drawing – Short Notes',
      subject: 'Engineering Drawing',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Engineering Drawing – Cheat Sheet',
      subject: 'Engineering Drawing',
      type: 'cheat',
      emoji: '🚀'),

  // AutoCAD
  MaterialItem(
      title: 'AutoCAD – Full Notes',
      subject: 'AutoCAD',
      type: 'full',
      emoji: '💻'),
  MaterialItem(
      title: 'AutoCAD – Short Notes',
      subject: 'AutoCAD',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'AutoCAD – Cheat Sheet',
      subject: 'AutoCAD',
      type: 'cheat',
      emoji: '🚀'),

  // Irrigation Engineering
  MaterialItem(
      title: 'Irrigation Engineering – Full Notes',
      subject: 'Irrigation Engineering',
      type: 'full',
      emoji: '💧'),
  MaterialItem(
      title: 'Irrigation Engineering – Short Notes',
      subject: 'Irrigation Engineering',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Irrigation Engineering – Cheat Sheet',
      subject: 'Irrigation Engineering',
      type: 'cheat',
      emoji: '🚀'),

  // Concrete Technology & RCC
  MaterialItem(
      title: 'Concrete Technology & RCC – Full Notes',
      subject: 'Concrete Technology & RCC',
      type: 'full',
      emoji: '🧱'),
  MaterialItem(
      title: 'Concrete Technology & RCC – Short Notes',
      subject: 'Concrete Technology & RCC',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Concrete Technology & RCC – Cheat Sheet',
      subject: 'Concrete Technology & RCC',
      type: 'cheat',
      emoji: '🚀'),

  // Steel Design
  MaterialItem(
      title: 'Steel Design – Full Notes',
      subject: 'Steel Design',
      type: 'full',
      emoji: '🔩'),
  MaterialItem(
      title: 'Steel Design – Short Notes',
      subject: 'Steel Design',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Steel Design – Cheat Sheet',
      subject: 'Steel Design',
      type: 'cheat',
      emoji: '🚀'),

  // Environmental Engineering
  MaterialItem(
      title: 'Environmental Engineering – Full Notes',
      subject: 'Environmental Engineering',
      type: 'full',
      emoji: '🌱'),
  MaterialItem(
      title: 'Environmental Engineering – Short Notes',
      subject: 'Environmental Engineering',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Environmental Engineering – Cheat Sheet',
      subject: 'Environmental Engineering',
      type: 'cheat',
      emoji: '🚀'),

  // Hydrology
  MaterialItem(
      title: 'Hydrology – Full Notes',
      subject: 'Hydrology',
      type: 'full',
      emoji: '💦'),
  MaterialItem(
      title: 'Hydrology – Short Notes',
      subject: 'Hydrology',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Hydrology – Cheat Sheet',
      subject: 'Hydrology',
      type: 'cheat',
      emoji: '🚀'),

  // Estimation, Valuation & Costing
  MaterialItem(
      title: 'Estimation, Valuation & Costing – Full Notes',
      subject: 'Estimation, Valuation & Costing',
      type: 'full',
      emoji: '🧮'),
  MaterialItem(
      title: 'Estimation, Valuation & Costing – Short Notes',
      subject: 'Estimation, Valuation & Costing',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Estimation, Valuation & Costing – Cheat Sheet',
      subject: 'Estimation, Valuation & Costing',
      type: 'cheat',
      emoji: '🚀'),

  // Strength of Materials
  MaterialItem(
      title: 'Strength of Materials – Full Notes',
      subject: 'Strength of Materials',
      type: 'full',
      emoji: '🪨'),
  MaterialItem(
      title: 'Strength of Materials – Short Notes',
      subject: 'Strength of Materials',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Strength of Materials – Cheat Sheet',
      subject: 'Strength of Materials',
      type: 'cheat',
      emoji: '🚀'),

  // Highway Engineering
  MaterialItem(
      title: 'Highway Engineering – Full Notes',
      subject: 'Highway Engineering',
      type: 'full',
      emoji: '🛣️'),
  MaterialItem(
      title: 'Highway Engineering – Short Notes',
      subject: 'Highway Engineering',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Highway Engineering – Cheat Sheet',
      subject: 'Highway Engineering',
      type: 'cheat',
      emoji: '🚀'),

  // Bridge Engineering
  MaterialItem(
      title: 'Bridge Engineering – Full Notes',
      subject: 'Bridge Engineering',
      type: 'full',
      emoji: '🌉'),
  MaterialItem(
      title: 'Bridge Engineering – Short Notes',
      subject: 'Bridge Engineering',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Bridge Engineering – Cheat Sheet',
      subject: 'Bridge Engineering',
      type: 'cheat',
      emoji: '🚀'),

  // Railway Engineering
  MaterialItem(
      title: 'Railway Engineering – Full Notes',
      subject: 'Railway Engineering',
      type: 'full',
      emoji: '🚆'),
  MaterialItem(
      title: 'Railway Engineering – Short Notes',
      subject: 'Railway Engineering',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Railway Engineering – Cheat Sheet',
      subject: 'Railway Engineering',
      type: 'cheat',
      emoji: '🚀'),

  // Dock, Harbour & Tunnel
  MaterialItem(
      title: 'Dock, Harbour & Tunnel – Full Notes',
      subject: 'Dock, Harbour & Tunnel Engineering',
      type: 'full',
      emoji: '⚓'),
  MaterialItem(
      title: 'Dock, Harbour & Tunnel – Short Notes',
      subject: 'Dock, Harbour & Tunnel Engineering',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Dock, Harbour & Tunnel – Cheat Sheet',
      subject: 'Dock, Harbour & Tunnel Engineering',
      type: 'cheat',
      emoji: '🚀'),

  // Airport Engineering
  MaterialItem(
      title: 'Airport Engineering – Full Notes',
      subject: 'Airport Engineering',
      type: 'full',
      emoji: '✈️'),
  MaterialItem(
      title: 'Airport Engineering – Short Notes',
      subject: 'Airport Engineering',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Airport Engineering – Cheat Sheet',
      subject: 'Airport Engineering',
      type: 'cheat',
      emoji: '🚀'),

  // Surveying & Levelling
  MaterialItem(
      title: 'Surveying & Levelling – Full Notes',
      subject: 'Surveying & Levelling',
      type: 'full',
      emoji: '🗺️'),
  MaterialItem(
      title: 'Surveying & Levelling – Short Notes',
      subject: 'Surveying & Levelling',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Surveying & Levelling – Cheat Sheet',
      subject: 'Surveying & Levelling',
      type: 'cheat',
      emoji: '🚀'),

  // Advanced Surveying
  MaterialItem(
      title: 'Advanced Surveying – Full Notes',
      subject: 'Advanced Surveying',
      type: 'full',
      emoji: '🧭'),
  MaterialItem(
      title: 'Advanced Surveying – Short Notes',
      subject: 'Advanced Surveying',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Advanced Surveying – Cheat Sheet',
      subject: 'Advanced Surveying',
      type: 'cheat',
      emoji: '🚀'),

  // Engineering Mechanics
  MaterialItem(
      title: 'Engineering Mechanics – Full Notes',
      subject: 'Engineering Mechanics',
      type: 'full',
      emoji: '⚙️'),
  MaterialItem(
      title: 'Engineering Mechanics – Short Notes',
      subject: 'Engineering Mechanics',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Engineering Mechanics – Cheat Sheet',
      subject: 'Engineering Mechanics',
      type: 'cheat',
      emoji: '🚀'),

  // Fluid Mechanics
  MaterialItem(
      title: 'Fluid Mechanics – Full Notes',
      subject: 'Fluid Mechanics',
      type: 'full',
      emoji: '🌊'),
  MaterialItem(
      title: 'Fluid Mechanics – Short Notes',
      subject: 'Fluid Mechanics',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Fluid Mechanics – Cheat Sheet',
      subject: 'Fluid Mechanics',
      type: 'cheat',
      emoji: '🚀'),

  // Workshop Calculation
  MaterialItem(
      title: 'Workshop Calculation – Full Notes',
      subject: 'Workshop Calculation',
      type: 'full',
      emoji: '🛠️'),
  MaterialItem(
      title: 'Workshop Calculation – Short Notes',
      subject: 'Workshop Calculation',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Workshop Calculation – Cheat Sheet',
      subject: 'Workshop Calculation',
      type: 'cheat',
      emoji: '🚀'),

  // Mechanical Engineering
  MaterialItem(
      title: 'Mechanical Engineering – Full Notes',
      subject: 'Mechanical Engineering',
      type: 'full',
      emoji: '🔧'),
  MaterialItem(
      title: 'Mechanical Engineering – Short Notes',
      subject: 'Mechanical Engineering',
      type: 'short',
      emoji: '⚡'),
  MaterialItem(
      title: 'Mechanical Engineering – Cheat Sheet',
      subject: 'Mechanical Engineering',
      type: 'cheat',
      emoji: '🚀'),
];

class PdfPlaceholderPage extends StatelessWidget {
  final MaterialItem item;

  const PdfPlaceholderPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Here we will show PDF for:\n\n'
              '${item.title}\n\n'
              '(Later we will connect real PDF viewer & Firebase.)',
        ),
      ),
    );
  }
}
