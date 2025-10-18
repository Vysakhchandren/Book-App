import 'package:book_reader/db/database_helper.dart';
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
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (book.imageLinks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.network(
                    book.imageLinks["thumbnail"] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              Column(
                children: [
                  Text(book.title, style: theme.headlineSmall),
                  Text(book.authors.join(', '), style: theme.labelLarge),
                  Text(
                    'Published: ${book.publishedDate}',
                    style: theme.bodySmall,
                  ),
                  Text('Page count: ${book.pageCount}', style: theme.bodySmall),
                  Text('Language :${book.language}', style: theme.bodySmall),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          //save a book to database
                          try {
                            print(book.authors);
                           int savedInt = await DatabaseHelper.instance.insert(book);
                           SnackBar snackBar = SnackBar(
                              content: Text("Book saved successfully $savedInt"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } catch (e) {
                            print("Error --->$e");
                          }
                        },
                        child: Text('Save'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                        },
                        icon: Icon(Icons.favorite),
                        label: Text('Favorite'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Description', style: theme.titleMedium),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withValues(
                        blue: .4,
                        green: .7,
                        alpha: .3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Text(
                      book.description,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
