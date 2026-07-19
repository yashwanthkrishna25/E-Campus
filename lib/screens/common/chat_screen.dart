/// Chat screen with message UI
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/utils/helpers.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override State<ChatScreen> createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  final _msgController = TextEditingController();
  final List<_ChatMsg> _messages = [
    _ChatMsg('Hello! I had a doubt regarding the DSA assignment.', true, DateTime.now().subtract(const Duration(minutes: 30))),
    _ChatMsg('Sure, what is your doubt?', false, DateTime.now().subtract(const Duration(minutes: 28))),
    _ChatMsg('Should we implement the BST using recursion or iteration?', true, DateTime.now().subtract(const Duration(minutes: 25))),
    _ChatMsg('You can use either approach. Both will be accepted. However, recursive is cleaner for tree operations.', false, DateTime.now().subtract(const Duration(minutes: 20))),
    _ChatMsg('Thank you, ma\'am! 🙏', true, DateTime.now().subtract(const Duration(minutes: 18))),
  ];

  @override void dispose() { _msgController.dispose(); super.dispose(); }

  void _send() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() { _messages.add(_ChatMsg(_msgController.text.trim(), true, DateTime.now())); _msgController.clear(); });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() { _messages.add(_ChatMsg('Thank you for your message. I will get back to you soon.', false, DateTime.now())); });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Row(children: [
        CircleAvatar(radius: 18, backgroundColor: const Color(0xFF6C63FF), child: const Text('PP', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
        const SizedBox(width: 10),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Dr. Priya Patel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text('Online', style: TextStyle(fontSize: 11, color: Colors.green)),
        ]),
      ])),
      body: Column(children: [
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.all(16), itemCount: _messages.length, reverse: false,
          itemBuilder: (context, index) {
            final msg = _messages[index];
            return Align(
              alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                decoration: BoxDecoration(
                  color: msg.isMe ? const Color(0xFF6C63FF) : (isDark ? const Color(0xFF2A2A3E) : Colors.grey.shade100),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(msg.isMe ? 16 : 4), bottomRight: Radius.circular(msg.isMe ? 4 : 16)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(msg.text, style: TextStyle(color: msg.isMe ? Colors.white : null, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(Helpers.formatTime(msg.time), style: TextStyle(fontSize: 10, color: msg.isMe ? Colors.white70 : Colors.grey)),
                ]),
              ),
            );
          },
        )),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Theme.of(context).cardTheme.color, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2))]),
          child: SafeArea(child: Row(children: [
            Expanded(child: TextField(controller: _msgController, decoration: InputDecoration(hintText: 'Type a message...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), filled: true, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)), onSubmitted: (_) => _send())),
            const SizedBox(width: 8),
            FloatingActionButton.small(onPressed: _send, child: const Icon(Icons.send_rounded)),
          ])),
        ),
      ]),
    );
  }
}

class _ChatMsg {
  final String text;
  final bool isMe;
  final DateTime time;
  _ChatMsg(this.text, this.isMe, this.time);
}
