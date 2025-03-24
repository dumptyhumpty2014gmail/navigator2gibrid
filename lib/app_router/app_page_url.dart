enum AppPageUrl {
  startSlash(''),
  login('login'),
  base('base'),
  booksList('books'),
  book('book'),
  authorsList('authors'),
  author('author');

  ///строка должна быть уникальная
  final String path;

  const AppPageUrl(this.path);
}
