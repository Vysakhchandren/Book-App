import 'package:book_reader/db/database_helper.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.getFavoriteBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError){
            return Center(child: Text('Error : ${snapshot.error}'),);
          }
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorite books yet.'),);
          }

          List<Book> favoriteBooks = snapshot.data!;

          return ListView.builder(
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              Book book = favoriteBooks[index];

              return Card(
                child: ListTile(
                  title: Text(book.title),
                  leading: Image.network(
                    book.imageLinks['thumbnail'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.book),
                  ),
                  subtitle: Text(book.authors.join(', ')),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () async {
                      await DatabaseHelper.instance.toggleFavoriteStatus(
                        book.id,
                        book.isFavorite,
                      );
                      setState(() {}); // Rebuild screen to show updated list
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
