/// AI Chatbot screen (UI)
library;
import 'package:flutter/material.dart';

class AiChatbotScreen extends StatefulWidget {
  const AiChatbotScreen({super.key});
  @override State<AiChatbotScreen> createState() => _AiChatbotScreenState();
}
class _AiChatbotScreenState extends State<AiChatbotScreen> {
  final _controller = TextEditingController();
  final List<_BotMsg> _msgs = [_BotMsg('Hello! I\'m your E-Campus AI assistant. I can help you with:\n\n📚 Academic queries\n📅 Timetable info\n📊 Attendance status\n💰 Fee details\n\nHow can I help?', false)];

  @override void dispose() { _controller.dispose(); super.dispose(); }

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text.trim();
    setState(() { _msgs.add(_BotMsg(text, true)); _controller.clear(); });
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      String reply;
      final lower = text.toLowerCase();
      if (lower.contains('attendance')) {
        reply = 'Your overall attendance is 81%. Data Structures: 85%, OS: 72%, DBMS: 90%. Keep it above 75%! 📊';
      } else if (lower.contains('timetable') || lower.contains('class')) {
        reply = 'Your classes today depend on the day. Check the Timetable section for detailed schedule! 📅';
      } else if (lower.contains('fee') || lower.contains('payment')) {
        reply = 'You have ₹25,650 in pending fees. Go to Fees section to view details and pay online. 💳';
      } else if (lower.contains('result') || lower.contains('marks')) {
        reply = 'Your Semester 5 internal results are out! Overall: 76.0%. Check Results section for details. 📊';
      } else if (lower.contains('assignment')) {
        reply = 'You have 2 active assignments. BST Implementation (due in 5 days) and Process Scheduling (due in 10 days). 📝';
      } else if (lower.contains('hi') || lower.contains('hello')) {
        reply = 'Hello! How can I help you today? 😊';
      } else {
        reply = 'I\'m still learning! This feature will be powered by AI soon. For now, try asking about attendance, timetable, fees, results, or assignments. 🤖';
      }
      setState(() { _msgs.add(_BotMsg(reply, false)); });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFFA855F7)]), borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20)), const SizedBox(width: 10),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('AI Assistant', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), Text('Always online', style: TextStyle(fontSize: 11, color: Colors.green))])])),
      body: Column(children: [
        Expanded(child: ListView.builder(padding: const EdgeInsets.all(16), itemCount: _msgs.length,
          itemBuilder: (context, index) {
            final m = _msgs[index];
            return Align(alignment: m.isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                decoration: BoxDecoration(
                  color: m.isUser ? const Color(0xFF6C63FF) : (isDark ? const Color(0xFF2A2A3E) : Colors.grey.shade100),
                  borderRadius: BorderRadius.only(topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(m.isUser ? 16 : 4), bottomRight: Radius.circular(m.isUser ? 4 : 16))),
                child: Text(m.text, style: TextStyle(color: m.isUser ? Colors.white : null, fontSize: 14, height: 1.4))));
          })),
        // Suggestions
        SizedBox(height: 40, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16),
          children: ['My attendance?', 'Fee status', 'Today\'s classes', 'Exam results'].map((s) => Padding(padding: const EdgeInsets.only(right: 8),
            child: ActionChip(label: Text(s, style: const TextStyle(fontSize: 12)), onPressed: () { _controller.text = s; _send(); }))).toList())),
        const SizedBox(height: 8),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Theme.of(context).cardTheme.color),
          child: SafeArea(child: Row(children: [
            Expanded(child: TextField(controller: _controller, decoration: InputDecoration(hintText: 'Ask me anything...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), filled: true, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)), onSubmitted: (_) => _send())),
            const SizedBox(width: 8),
            FloatingActionButton.small(onPressed: _send, backgroundColor: const Color(0xFF6C63FF), child: const Icon(Icons.send_rounded, color: Colors.white)),
          ]))),
      ]),
    );
  }
}
class _BotMsg { final String text; final bool isUser; _BotMsg(this.text, this.isUser); }
