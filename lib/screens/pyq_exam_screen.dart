import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PyqExamScreen extends StatelessWidget {
  const PyqExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PYQ Exam'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pyq_categories') // Firestore collection
            .orderBy('order', descending: false) // order field ഉണ്ടെങ്കിൽ
            .snapshots(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong 😕'),
            );
          }

          // No data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No PYQ categories added yet'),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final name = data['name'] as String? ?? 'Untitled';
              final examsCount = data['examsCount'] as int? ?? 0;

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  // ഇപ്പോൾ exam list Ready അല്ല,
                  // simple message മാത്രം കാണിക്കുന്നു
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$name exams coming soon'),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(0.04),
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Left icon
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E2FF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          size: 26,
                          color: Color(0xFF5B4BFF),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$examsCount Exams',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}