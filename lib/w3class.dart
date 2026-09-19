
class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false,
  });

  @override
  String toString() {
    return "'$title' by $author (\$${price.toStringAsFixed(2)})";
  }
}

class Library {
  final List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
  }

  List<Book> getAvailableBooks() {
    return _books.where((book) => !book.isBorrowed).toList();
  }

  double getTotalValue() {
    return _books.fold(0.0, (sum, book) => sum + book.price);
  }
}

void main() {
  final library = Library();

  // Add sample books
  library.addBook(Book(title: 'The Hobbit', author: 'J.R.R. Tolkien', price: 14.99));
  library.addBook(Book(title: '1984', author: 'George Orwell', price: 9.99, isBorrowed: true));
  library.addBook(Book(title: 'Clean Code', author: 'Robert C. Martin', price: 34.50));
  library.addBook(Book(title: 'Dune', author: 'Frank Herbert', price: 18.25, isBorrowed: true));

 
  print('--- Available Books ---');
  final availableBooks = library.getAvailableBooks();
  for (var book in availableBooks) {
    print(book);
  }

  print('\n--- Library Summary ---');
  print('Total Collection Value: \$${library.getTotalValue().toStringAsFixed(2)}');
}