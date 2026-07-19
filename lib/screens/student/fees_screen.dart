/// Fees screen with payment status and payment UI
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fees = DemoDataService.fees;
    final totalDue = fees.fold<double>(0, (s, f) => s + f.pendingAmount);

    return Scaffold(
      appBar: AppBar(title: const Text('Fees')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Total due card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF4158D0)]),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: const Color(0xFF6C63FF).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6))],
              ),
              child: Column(
                children: [
                  const Text('Total Outstanding', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text('₹${totalDue.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF6C63FF)),
                    onPressed: () => Helpers.showSnackBar(context, 'Payment gateway integration needed'),
                    child: const Text('Pay Now'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Align(alignment: Alignment.centerLeft, child: Text('Fee Details', style: Theme.of(context).textTheme.headlineSmall)),
            const SizedBox(height: 12),

            ...fees.map((fee) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(fee.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Helpers.statusColor(fee.status).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(fee.status.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Helpers.statusColor(fee.status))),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Amount: ₹${fee.amount.toStringAsFixed(0)}', style: Theme.of(context).textTheme.bodyMedium),
                      if (fee.pendingAmount > 0) Text('Due: ₹${fee.pendingAmount.toStringAsFixed(0)}', style: TextStyle(color: Colors.red.shade400, fontWeight: FontWeight.w600)),
                    ]),
                    const SizedBox(height: 4),
                    Text('Due Date: ${Helpers.formatDate(fee.dueDate)}', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
