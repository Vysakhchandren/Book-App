import 'package:book_reader/utils/book_details_arguments.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';

class BooksDetailsScreen extends StatefulWidget {
  const BooksDetailsScreen({super.key});

  @override
  State<BooksDetailsScreen> createState() => _BooksDetailsScreenState();
}

class _BooksDetailsScreenState extends State<BooksDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
    );
  }
}
