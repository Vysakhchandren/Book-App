import 'package:book_reader/db/database_helper.dart';
import 'package:book_reader/utils/book_details_arguments.dart';
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
      //appBar: AppBar(title: const Text('Saved')),
      body: FutureBuilder(
        future: DatabaseHelper.instance.readAllBooks(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Book book = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: BookDetailsArguments(
                          itemBook: book,
                          isFromSavedScreen: true,
                        ),
                      );
                    },

                    child: Card(
                      child: ListTile(
                        title: Text(book.title),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            print("Delete ${book.id}");
                            DatabaseHelper.instance.deleteBook(book.id);
                            setState(() {
                              // snapshot.data!.removeAt(index);
                            });
                          },
                        ),
                        leading: Image.network(
                          book.imageLinks['thumbnail'] ?? '',
                          fit: BoxFit.cover,
                        ),
                        subtitle: Column(
                          children: [
                            Text(book.authors.join(', ')),
                            ElevatedButton.icon(
                              onPressed: () async {
                                await DatabaseHelper.instance
                                    .toggleFavoriteStatus(
                                      book.id,
                                      book.isFavorite,
                                    )
                                    .then(
                                      (value) =>
                                          print("Item Favored!!! $value"),
                                    );
                                setState(() {});
                              },
                              icon: const Icon(Icons.favorite),
                              label: const Text('Add to Favorites'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
