import 'package:book_reader/models/book.dart';
import 'package:book_reader/network/network.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Network network = Network();
  List<Book> _books = [];

  Future<void> _searchBooks(String query) async {
    try {
      List<Book> books = await network.searchBooks(query);
      setState(() {
        _books = books;
      });
      // print("Books: ${books.toString()}");
    } catch (e) {
      print("Didn't get anything..");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search Books',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onSubmitted: (query) => _searchBooks(query),
              ),
            ),
            Expanded(
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
            ),
          ],
        ),
      ),
    );
  }
}
