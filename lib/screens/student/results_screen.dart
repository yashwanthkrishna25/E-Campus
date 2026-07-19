/// Results screen with semester-wise marks
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final results = DemoDataService.results;
    final totalObtained = results.fold<int>(0, (s, r) => s + r.marksObtained);
    final totalMax = results.fold<int>(0, (s, r) => s + r.totalMarks);
    final overallPct = (totalObtained / totalMax * 100);

    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Summary card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Semester 5 - Internal', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statColumn(context, '${overallPct.toStringAsFixed(1)}%', 'Percentage'),
                        _statColumn(context, '$totalObtained/$totalMax', 'Marks'),
                        _statColumn(context, 'A', 'Grade'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Subject-wise Results', style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(height: 12),

            ...results.map((r) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48, height: 48,
                      decoration: BoxDecoration(
                        color: Helpers.attendanceColor(r.percentage).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(r.grade ?? '-',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                            color: Helpers.attendanceColor(r.percentage))),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.subjectName, style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: r.percentage / 100,
                              minHeight: 6,
                              backgroundColor: Helpers.attendanceColor(r.percentage).withValues(alpha: 0.15),
                              valueColor: AlwaysStoppedAnimation(Helpers.attendanceColor(r.percentage)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('${r.marksObtained}/${r.totalMarks}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _statColumn(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
