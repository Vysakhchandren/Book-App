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
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if(book.imageLinks.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(18.0),
              child: Image.network(
                book.imageLinks["thumbnail"] ?? '',
                fit: BoxFit.cover,
              ),
              ),
              Column(
                children: [
                  Text(
                    book.title,
                    style: theme.headlineSmall,
                  ),
                  Text(book.authors.join(', '),
                  style: theme.labelLarge,),
                  Text('Publised: ${book.publishedDate}',
                  style: theme.bodySmall,),
                  Text('Page count: ${book.pageCount}',
                  style: theme.bodySmall,),
                  Text('Language :${book.language}',
                  style: theme.bodySmall,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
