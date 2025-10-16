import 'package:book_reader/db/database_helper.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: FutureBuilder(
        future: DatabaseHelper.instance.readAllBooks(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Book book = snapshot.data![index];
              return ListTile(title: Text(book.title),);
        })
            : const Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
