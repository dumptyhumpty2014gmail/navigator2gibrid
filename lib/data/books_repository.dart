import '../domain/book.dart';

class BooksRepository {
  List<Book> getBooks() => [
    Book(0, 'Сказка о рыбаке и рыбке', 'Александр Пушкин'),
    Book(1, 'Война и мир', 'Лев Толстой'),
    Book(2, 'Преступление и наказание', 'Федор Достоевский'),
    Book(3, 'Мастер и Маргарита', 'Михаил Булгаков'),
  ];

  Book? getBookById(int id) {
    try {
      return getBooks().firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }
}
