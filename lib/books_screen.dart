import 'package:flutter/material.dart';
import 'drawer.dart';
import 'add_book_screen.dart';
import 'edit_book_screen.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final List<Book> books = [
    Book('1984', 'George Orwell', 'assets/book1.jpg', 'A dystopian novel set in a totalitarian society under constant surveillance.'),
    Book('To Kill a Mockingbird', 'Harper Lee', 'assets/book2.jpg', 'A novel about the serious issues of rape and racial inequality.'),
  ];

  List<Book> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    filteredBooks = books;
  }

  void _addBook(String title, String author, String description, String imageUrl) {
    setState(() {
      books.add(Book(title, author, imageUrl, description));
      filteredBooks = books;
    });
  }

  void _editBook(int index, String title, String author, String description, String imageUrl) {
    setState(() {
      books[index] = Book(title, author, imageUrl, description);
      filteredBooks = books;
    });
  }

  void _deleteBook(int index) {
    setState(() {
      books.removeAt(index);
      filteredBooks = books;
    });
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Voulez-vous vraiment supprimer ce livre ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Supprimer', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _deleteBook(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _filterBooks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredBooks = books;
      } else {
        filteredBooks = books.where((book) {
          return book.title.toLowerCase().contains(query.toLowerCase()) ||
                 book.author.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livres'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher un livre',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterBooks,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(filteredBooks[index].image),
                    title: Text(filteredBooks[index].title),
                    subtitle: Text(filteredBooks[index].author),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: filteredBooks[index]),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookScreen(
                                  book: filteredBooks[index],
                                  index: index,
                                  editBook: _editBook,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteConfirmationDialog(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookScreen(addBook: _addBook),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String image;
  final String description;

  Book(this.title, this.author, this.image, this.description);
}

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(book.image),
            SizedBox(height: 8.0),
            Text(
              book.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              book.author,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16.0),
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
