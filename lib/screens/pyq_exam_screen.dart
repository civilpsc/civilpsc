import 'package:flutter/material.dart';

/// List of all posts/exams shown in PYQ Exam screen.
const List<String> kPostNames = [
  'Draftsman / Overseer Gr III',
  'Draftsman / Overseer Gr II',
  'Draftsman / Overseer Gr I',
  'Work Superintendent',
  'Junior Instructor',
  'Tracer',
  'Surveyor',
  'Tradesman',
  'Project Engineer',
  'Town Planning',
  'Assistant Engineer',
  'Junior Technical Officer',
  'Assistant Professor & Lecturer',
  'Architectural Draftsman',
  'Vocational Instructor',
  'Model exam',
];

class PyqExamScreen extends StatelessWidget {
  const PyqExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F6FF),
        foregroundColor: Colors.black87,
        title: const Text(
          'PYQ Exam',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        itemCount: kPostNames.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final postName = kPostNames[index];

          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              // Later: navigate to questions screen.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$postName – questions coming soon'),
                ),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    // OMR image (instead of clipboard)
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7E4FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(
                        'assets/images/omr.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Exam name only (like your screenshot)
                    Expanded(
                      child: Text(
                        postName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
            ),
          );
        },
      ),
    );
  }
}