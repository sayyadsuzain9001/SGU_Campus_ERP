import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../widgets/course_card.dart';
import '../shared/course_workspace.dart';
import '../../widgets/common.dart';

class StudentCoursesPage extends StatelessWidget {
  const StudentCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'My Courses',
      subtitle: 'Courses you are enrolled in this semester.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: MockData.i.courses.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: constraints.maxWidth > 800 ? 280 : 420,
              mainAxisExtent: 190,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final course = MockData.i.courses[index];
              return CourseCard(
                course: course,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseWorkspacePage(courseId: course.id),
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
