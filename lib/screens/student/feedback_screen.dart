/// Feedback screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/utils/helpers.dart';
import 'package:e_campus/widgets/custom_text_field.dart';
import 'package:e_campus/widgets/gradient_button.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});
  @override State<FeedbackScreen> createState() => _FeedbackScreenState();
}
class _FeedbackScreenState extends State<FeedbackScreen> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  int _rating = 4;
  String _category = 'other';

  @override void dispose() { _subjectController.dispose(); _messageController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Rating
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
          Text('Rate your experience', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i) =>
            GestureDetector(onTap: () => setState(() => _rating = i + 1),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(i < _rating ? Icons.star_rounded : Icons.star_outline_rounded, size: 40,
                  color: i < _rating ? Colors.amber : Colors.grey.shade400))))),
        ]))),
        const SizedBox(height: 16),
        Text('Category', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 8),
        Wrap(spacing: 8, children: ['faculty', 'infrastructure', 'canteen', 'library', 'other'].map((c) =>
          ChoiceChip(label: Text(c.toUpperCase()), selected: _category == c, onSelected: (s) => setState(() => _category = c))).toList()),
        const SizedBox(height: 16),
        CustomTextField(controller: _subjectController, hintText: 'Subject', labelText: 'Subject', prefixIcon: Icons.subject),
        const SizedBox(height: 16),
        CustomTextField(controller: _messageController, hintText: 'Your feedback', labelText: 'Message', maxLines: 5, prefixIcon: Icons.message_rounded),
        const SizedBox(height: 24),
        GradientButton(text: 'Submit Feedback', icon: Icons.send_rounded, gradient: const LinearGradient(colors: [Color(0xFF14B8A6), Color(0xFF06B6D4)]),
          onPressed: () { if (_subjectController.text.isEmpty || _messageController.text.isEmpty) { Helpers.showSnackBar(context, 'Fill all fields', isError: true); return; }
            Helpers.showSnackBar(context, 'Feedback submitted! Thank you.'); _subjectController.clear(); _messageController.clear(); }),
      ])),
    );
  }
}
