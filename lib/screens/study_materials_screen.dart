import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

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
                builder: (_) => PdfViewerPage(item: m),
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
  final String assetPath; // PDF asset path

  MaterialItem({
    required this.title,
    required this.subject,
    required this.type,
    required this.emoji,
    required this.assetPath,
  });
}

// ---- ALL SUBJECTS: FULL / SHORT / CHEAT ----
// (ഇമോജി എല്ലാം പഴയതേ, assetPath മാത്രം ചേർത്തു)

final List<MaterialItem> _allMaterials = [
  // Building Materials
  MaterialItem(
    title: 'Building Materials – Full Notes',
    subject: 'Building Materials',
    type: 'full',
    emoji: '📚',
    assetPath: 'assets/pdfs/building_materials_full.pdf',
  ),
  MaterialItem(
    title: 'Building Materials – Short Notes',
    subject: 'Building Materials',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/building_materials_short.pdf',
  ),
  MaterialItem(
    title: 'Building Materials – Cheat Sheet',
    subject: 'Building Materials',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/building_materials_cheat.pdf',
  ),

  // Building Construction
  MaterialItem(
    title: 'Building Construction – Full Notes',
    subject: 'Building Construction',
    type: 'full',
    emoji: '🏗️',
    assetPath: 'assets/pdfs/building_construction_full.pdf',
  ),
  MaterialItem(
    title: 'Building Construction – Short Notes',
    subject: 'Building Construction',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/building_construction_short.pdf',
  ),
  MaterialItem(
    title: 'Building Construction – Cheat Sheet',
    subject: 'Building Construction',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/building_construction_cheat.pdf',
  ),

  // Engineering Drawing
  MaterialItem(
    title: 'Engineering Drawing – Full Notes',
    subject: 'Engineering Drawing',
    type: 'full',
    emoji: '📐',
    assetPath: 'assets/pdfs/engineering_drawing_full.pdf',
  ),
  MaterialItem(
    title: 'Engineering Drawing – Short Notes',
    subject: 'Engineering Drawing',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/engineering_drawing_short.pdf',
  ),
  MaterialItem(
    title: 'Engineering Drawing – Cheat Sheet',
    subject: 'Engineering Drawing',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/engineering_drawing_cheat.pdf',
  ),

  // AutoCAD
  MaterialItem(
    title: 'AutoCAD – Full Notes',
    subject: 'AutoCAD',
    type: 'full',
    emoji: '💻',
    assetPath: 'assets/pdfs/autocad_full.pdf',
  ),
  MaterialItem(
    title: 'AutoCAD – Short Notes',
    subject: 'AutoCAD',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/autocad_short.pdf',
  ),
  MaterialItem(
    title: 'AutoCAD – Cheat Sheet',
    subject: 'AutoCAD',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/autocad_cheat.pdf',
  ),

  // Irrigation Engineering
  MaterialItem(
    title: 'Irrigation Engineering – Full Notes',
    subject: 'Irrigation Engineering',
    type: 'full',
    emoji: '💧',
    assetPath: 'assets/pdfs/irrigation_full.pdf',
  ),
  MaterialItem(
    title: 'Irrigation Engineering – Short Notes',
    subject: 'Irrigation Engineering',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/irrigation_short.pdf',
  ),
  MaterialItem(
    title: 'Irrigation Engineering – Cheat Sheet',
    subject: 'Irrigation Engineering',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/irrigation_cheat.pdf',
  ),

  // Concrete Technology & RCC
  MaterialItem(
    title: 'Concrete Technology & RCC – Full Notes',
    subject: 'Concrete Technology & RCC',
    type: 'full',
    emoji: '🧱',
    assetPath: 'assets/pdfs/concrete_rcc_full.pdf',
  ),
  MaterialItem(
    title: 'Concrete Technology & RCC – Short Notes',
    subject: 'Concrete Technology & RCC',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/concrete_rcc_short.pdf',
  ),
  MaterialItem(
    title: 'Concrete Technology & RCC – Cheat Sheet',
    subject: 'Concrete Technology & RCC',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/concrete_rcc_cheat.pdf',
  ),

  // Steel Design
  MaterialItem(
    title: 'Steel Design – Full Notes',
    subject: 'Steel Design',
    type: 'full',
    emoji: '🔩',
    assetPath: 'assets/pdfs/steel_design_full.pdf',
  ),
  MaterialItem(
    title: 'Steel Design – Short Notes',
    subject: 'Steel Design',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/steel_design_short.pdf',
  ),
  MaterialItem(
    title: 'Steel Design – Cheat Sheet',
    subject: 'Steel Design',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/steel_design_cheat.pdf',
  ),

  // Environmental Engineering
  MaterialItem(
    title: 'Environmental Engineering – Full Notes',
    subject: 'Environmental Engineering',
    type: 'full',
    emoji: '🌱',
    assetPath: 'assets/pdfs/environmental_full.pdf',
  ),
  MaterialItem(
    title: 'Environmental Engineering – Short Notes',
    subject: 'Environmental Engineering',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/environmental_short.pdf',
  ),
  MaterialItem(
    title: 'Environmental Engineering – Cheat Sheet',
    subject: 'Environmental Engineering',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/environmental_cheat.pdf',
  ),

  // Hydrology
  MaterialItem(
    title: 'Hydrology – Full Notes',
    subject: 'Hydrology',
    type: 'full',
    emoji: '💦',
    assetPath: 'assets/pdfs/hydrology_full.pdf',
  ),
  MaterialItem(
    title: 'Hydrology – Short Notes',
    subject: 'Hydrology',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/hydrology_short.pdf',
  ),
  MaterialItem(
    title: 'Hydrology – Cheat Sheet',
    subject: 'Hydrology',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/hydrology_cheat.pdf',
  ),

  // Estimation, Valuation & Costing
  MaterialItem(
    title: 'Estimation, Valuation & Costing – Full Notes',
    subject: 'Estimation, Valuation & Costing',
    type: 'full',
    emoji: '🧮',
    assetPath: 'assets/pdfs/estimation_full.pdf',
  ),
  MaterialItem(
    title: 'Estimation, Valuation & Costing – Short Notes',
    subject: 'Estimation, Valuation & Costing',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/estimation_short.pdf',
  ),
  MaterialItem(
    title: 'Estimation, Valuation & Costing – Cheat Sheet',
    subject: 'Estimation, Valuation & Costing',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/estimation_cheat.pdf',
  ),

  // Strength of Materials
  MaterialItem(
    title: 'Strength of Materials – Full Notes',
    subject: 'Strength of Materials',
    type: 'full',
    emoji: '🪨',
    assetPath: 'assets/pdfs/som_full.pdf',
  ),
  MaterialItem(
    title: 'Strength of Materials – Short Notes',
    subject: 'Strength of Materials',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/som_short.pdf',
  ),
  MaterialItem(
    title: 'Strength of Materials – Cheat Sheet',
    subject: 'Strength of Materials',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/som_cheat.pdf',
  ),

  // Highway Engineering
  MaterialItem(
    title: 'Highway Engineering – Full Notes',
    subject: 'Highway Engineering',
    type: 'full',
    emoji: '🛣️',
    assetPath: 'assets/pdfs/highway_full.pdf',
  ),
  MaterialItem(
    title: 'Highway Engineering – Short Notes',
    subject: 'Highway Engineering',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/highway_short.pdf',
  ),
  MaterialItem(
    title: 'Highway Engineering – Cheat Sheet',
    subject: 'Highway Engineering',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/highway_cheat.pdf',
  ),

  // Bridge Engineering
  MaterialItem(
    title: 'Bridge Engineering – Full Notes',
    subject: 'Bridge Engineering',
    type: 'full',
    emoji: '🌉',
    assetPath: 'assets/pdfs/bridge_full.pdf',
  ),
  MaterialItem(
    title: 'Bridge Engineering – Short Notes',
    subject: 'Bridge Engineering',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/bridge_short.pdf',
  ),
  MaterialItem(
    title: 'Bridge Engineering – Cheat Sheet',
    subject: 'Bridge Engineering',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/bridge_cheat.pdf',
  ),

  // Railway Engineering
  MaterialItem(
    title: 'Railway Engineering – Full Notes',
    subject: 'Railway Engineering',
    type: 'full',
    emoji: '🚆',
    assetPath: 'assets/pdfs/railway_full.pdf',
  ),
  MaterialItem(
    title: 'Railway Engineering – Short Notes',
    subject: 'Railway Engineering',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/railway_short.pdf',
  ),
  MaterialItem(
    title: 'Railway Engineering – Cheat Sheet',
    subject: 'Railway Engineering',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/railway_cheat.pdf',
  ),

  // Dock, Harbour & Tunnel
  MaterialItem(
    title: 'Dock, Harbour & Tunnel – Full Notes',
    subject: 'Dock, Harbour & Tunnel Engineering',
    type: 'full',
    emoji: '⚓',
    assetPath: 'assets/pdfs/dock_full.pdf',
  ),
  MaterialItem(
    title: 'Dock, Harbour & Tunnel – Short Notes',
    subject: 'Dock, Harbour & Tunnel Engineering',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/dock_short.pdf',
  ),
  MaterialItem(
    title: 'Dock, Harbour & Tunnel – Cheat Sheet',
    subject: 'Dock, Harbour & Tunnel Engineering',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/dock_cheat.pdf',
  ),

  // Airport Engineering
  MaterialItem(
    title: 'Airport Engineering – Full Notes',
    subject: 'Airport Engineering',
    type: 'full',
    emoji: '✈️',
    assetPath: 'assets/pdfs/airport_full.pdf',
  ),
  MaterialItem(
    title: 'Airport Engineering – Short Notes',
    subject: 'Airport Engineering',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/airport_short.pdf',
  ),
  MaterialItem(
    title: 'Airport Engineering – Cheat Sheet',
    subject: 'Airport Engineering',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/airport_cheat.pdf',
  ),

  // Surveying & Levelling
  MaterialItem(
    title: 'Surveying & Levelling – Full Notes',
    subject: 'Surveying & Levelling',
    type: 'full',
    emoji: '🗺️',
    assetPath: 'assets/pdfs/surveying_full.pdf',
  ),
  MaterialItem(
    title: 'Surveying & Levelling – Short Notes',
    subject: 'Surveying & Levelling',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/surveying_short.pdf',
  ),
  MaterialItem(
    title: 'Surveying & Levelling – Cheat Sheet',
    subject: 'Surveying & Levelling',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/surveying_cheat.pdf',
  ),

  // Advanced Surveying
  MaterialItem(
    title: 'Advanced Surveying – Full Notes',
    subject: 'Advanced Surveying',
    type: 'full',
    emoji: '🧭',
    assetPath: 'assets/pdfs/advanced_surveying_full.pdf',
  ),
  MaterialItem(
    title: 'Advanced Surveying – Short Notes',
    subject: 'Advanced Surveying',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/advanced_surveying_short.pdf',
  ),
  MaterialItem(
    title: 'Advanced Surveying – Cheat Sheet',
    subject: 'Advanced Surveying',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/advanced_surveying_cheat.pdf',
  ),

  // Engineering Mechanics
  MaterialItem(
    title: 'Engineering Mechanics – Full Notes',
    subject: 'Engineering Mechanics',
    type: 'full',
    emoji: '⚙️',
    assetPath: 'assets/pdfs/engg_mechanics_full.pdf',
  ),
  MaterialItem(
    title: 'Engineering Mechanics – Short Notes',
    subject: 'Engineering Mechanics',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/engg_mechanics_short.pdf',
  ),
  MaterialItem(
    title: 'Engineering Mechanics – Cheat Sheet',
    subject: 'Engineering Mechanics',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/engg_mechanics_cheat.pdf',
  ),

  // Fluid Mechanics
  MaterialItem(
    title: 'Fluid Mechanics – Full Notes',
    subject: 'Fluid Mechanics',
    type: 'full',
    emoji: '🌊',
    assetPath: 'assets/pdfs/fluid_mechanics_full.pdf',
  ),
  MaterialItem(
    title: 'Fluid Mechanics – Short Notes',
    subject: 'Fluid Mechanics',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/fluid_mechanics_short.pdf',
  ),
  MaterialItem(
    title: 'Fluid Mechanics – Cheat Sheet',
    subject: 'Fluid Mechanics',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/fluid_mechanics_cheat.pdf',
  ),

  // Workshop Calculation
  MaterialItem(
    title: 'Workshop Calculation – Full Notes',
    subject: 'Workshop Calculation',
    type: 'full',
    emoji: '🛠️',
    assetPath: 'assets/pdfs/workshop_full.pdf',
  ),
  MaterialItem(
    title: 'Workshop Calculation – Short Notes',
    subject: 'Workshop Calculation',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/workshop_short.pdf',
  ),
  MaterialItem(
    title: 'Workshop Calculation – Cheat Sheet',
    subject: 'Workshop Calculation',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/workshop_cheat.pdf',
  ),

  // Mechanical Engineering
  MaterialItem(
    title: 'Mechanical Engineering – Full Notes',
    subject: 'Mechanical Engineering',
    type: 'full',
    emoji: '🔧',
    assetPath: 'assets/pdfs/mech_full.pdf',
  ),
  MaterialItem(
    title: 'Mechanical Engineering – Short Notes',
    subject: 'Mechanical Engineering',
    type: 'short',
    emoji: '⚡',
    assetPath: 'assets/pdfs/mech_short.pdf',
  ),
  MaterialItem(
    title: 'Mechanical Engineering – Cheat Sheet',
    subject: 'Mechanical Engineering',
    type: 'cheat',
    emoji: '🚀',
    assetPath: 'assets/pdfs/mech_cheat.pdf',
  ),
];

class PdfViewerPage extends StatefulWidget {
  final MaterialItem item;

  const PdfViewerPage({super.key, required this.item});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  PdfControllerPinch? _pdfController;
  String? _error;

  @override
  void initState() {
    super.initState();
    try {
      _pdfController = PdfControllerPinch(
        document: PdfDocument.openAsset(widget.item.assetPath),
      );
    } catch (e) {
      _error = 'Unable to open PDF. Please check if the file is added.';
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.title)),
      body: _error != null
          ? Center(child: Text(_error!))
          : _pdfController == null
          ? const Center(child: CircularProgressIndicator())
          : PdfViewPinch(controller: _pdfController!),
    );
  }
}
