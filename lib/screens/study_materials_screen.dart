import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pdf_viewer_screen.dart';

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
    final query = FirebaseFirestore.instance
        .collection('materials')
        .where('type', isEqualTo: type);

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No materials added yet'));
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final String title = data['title'] ?? 'No title';
            final String subject = data['subject'] ?? '';
            final String pdfUrl = data['pdfUrl'] ?? '';

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(title),
                subtitle: Text(subject),
                trailing: const Icon(Icons.picture_as_pdf),
                onTap: () {
                  if (pdfUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('PDF not available')),
                    );
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PdfViewerScreen(
                        title: title,
                        pdfUrl: pdfUrl,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}