/// Library screen - issued books, fines, available books
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final books = DemoDataService.libraryBooks;
    final issued = books.where((b) => b.issuedTo == 'demo_student_1').toList();
    final available = books.where((b) => b.availableCopies > 0).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('Library'), bottom: const TabBar(tabs: [Tab(text: 'My Books'), Tab(text: 'Catalogue')])),
        body: TabBarView(children: [
          // My Books
          issued.isEmpty
              ? const Center(child: Text('No books issued'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16), itemCount: issued.length,
                  itemBuilder: (context, index) {
                    final book = issued[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Container(width: 48, height: 60, decoration: BoxDecoration(color: const Color(0xFF6C63FF).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.menu_book_rounded, color: Color(0xFF6C63FF))),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(book.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                            Text(book.author, style: Theme.of(context).textTheme.bodySmall),
                          ])),
                        ]),
                        const SizedBox(height: 12),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Issue: ${Helpers.formatDateShort(book.issueDate!)}', style: Theme.of(context).textTheme.bodySmall),
                          Text('Return: ${Helpers.formatDateShort(book.returnDate!)}', style: TextStyle(fontSize: 12, color: book.isOverdue ? Colors.red : null, fontWeight: book.isOverdue ? FontWeight.bold : null)),
                        ]),
                        if (book.fineAmount != null && book.fineAmount! > 0) ...[
                          const SizedBox(height: 8),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                            child: Text('Fine: ₹${book.fineAmount!.toStringAsFixed(0)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12))),
                        ],
                      ])),
                    );
                  }),
          // Catalogue
          ListView.builder(
            padding: const EdgeInsets.all(16), itemCount: available.length,
            itemBuilder: (context, index) {
              final book = available[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFFA855F7).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.book_rounded, color: Color(0xFFA855F7))),
                  title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('${book.author} • ${book.availableCopies} available'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
