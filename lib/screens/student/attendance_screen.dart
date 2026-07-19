/// Attendance screen with charts and subject-wise breakdown
library;

import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendance = DemoDataService.attendanceSummary['demo_student_1']!;
    final overall = DemoDataService.overallAttendance;

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Overall attendance card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 10,
                      percent: overall / 100,
                      center: Text(
                        '${overall.toStringAsFixed(0)}%',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      progressColor: Helpers.attendanceColor(overall),
                      backgroundColor: Helpers.attendanceColor(overall).withValues(alpha: 0.15),
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animationDuration: 1200,
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Overall Attendance', style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 8),
                          Text(
                            overall >= 75 ? 'Good standing ✅' : 'Below minimum ⚠️',
                            style: TextStyle(
                              color: Helpers.attendanceColor(overall),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Minimum required: 75%', style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Subject-wise attendance
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Subject-wise Attendance', style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(height: 12),

            ...attendance.entries.map((entry) {
              final percentage = entry.value;
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(entry.key,
                                style: const TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Helpers.attendanceColor(percentage).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${percentage.toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: Helpers.attendanceColor(percentage),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: percentage / 100,
                          minHeight: 8,
                          backgroundColor: Helpers.attendanceColor(percentage).withValues(alpha: 0.1),
                          valueColor: AlwaysStoppedAnimation(Helpers.attendanceColor(percentage)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
