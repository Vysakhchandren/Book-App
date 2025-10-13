import 'package:flutter/material.dart';

import '../models/book.dart';
import '../utils/book_details_arguments.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required List<Book> books,
  }) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: _books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .6,
        ),
        itemBuilder: (context, index) {
          Book book = _books[index];
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.shade300,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/details',
                    arguments: BookDetailsArguments(itemBook: book));
              },
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(fit: BoxFit.fill,
                        image: NetworkImage(
                          book.imageLinks["thumbnail"] ?? '',
                        ),
                      ),
                    ),
                    height: 200,
                    width: 150,
                    // child: Padding(
                    //   padding: const EdgeInsets.all(18.0),
                    //   child: Image.network(
                    //     book.imageLinks["thumbnail"] ?? '',
                    //   ),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      book.authors.join(', &'),
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Expanded(
      //   child: Container(
      //     width: double.infinity,
      //     child: ListView.builder(
      //         itemCount: _books.length,
      //         itemBuilder: (context, index){
      //           Book book = _books[index];
      //       return ListTile(
      //         title: Text(book.title),
      //         subtitle: Text(book.authors.join(', &')  ?? ''),
      //       );
      //     }),
      //   ),
      // )
    );
  }
}