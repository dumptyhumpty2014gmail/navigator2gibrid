import 'package:flutter/material.dart';
import 'package:navigator2gibrid/app_router/app_configuration.dart';
import 'package:provider/provider.dart';

import '../../../app_router/app_pages/books_list_page.dart';
import '../../../app_router/app_router_delegate.dart';
import '../../../data/books_repository.dart';
import '../../../domain/book.dart';

class BookDetailsScreen extends StatefulWidget {
  final int? id;
  const BookDetailsScreen({super.key, this.id});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late final Book? book = BooksRepository().getBookById(widget.id ?? -1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text('Стрелка выше дефолтная и вообще-то не вписывается в декларативную концепцию'),
            ElevatedButton(
              onPressed: () {
                //TODO сделать через addPage
                context.read<AppRouterDelegate>().setNewRoutePath(AppConfiguration(pages: [AppPageBookList()]));
              },
              child: Text('Back декларативный'),
            ),
            if (book != null) ...[Text(book!.title), Text(book!.author)],
            if (book == null) ...[Text('Book not found')],
          ],
        ),
      ),
    );
  }
}
