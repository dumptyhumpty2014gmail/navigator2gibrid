import 'package:flutter/material.dart';
import 'package:navigator2gibrid/app_router/app_configuration.dart';
import 'package:navigator2gibrid/app_router/app_pages/books_list_page.dart';
import 'package:provider/provider.dart';

import '../../../app_router/app_pages/book_page.dart';
import '../../../app_router/app_router_delegate.dart';
import '../../../data/books_repository.dart';
import '../../../main_vm.dart';

class BooksListScreen extends StatefulWidget {
  const BooksListScreen({super.key});

  @override
  State<BooksListScreen> createState() => _BooksListScreenState();
}

class _BooksListScreenState extends State<BooksListScreen> {
  late final books = BooksRepository().getBooks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<MainVM>().changeLoginState(false);
            },
            child: Text('Logout'),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView(
              children: [
                ...books.map(
                  (book) => ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    onTap:
                        () => {
                          context.read<AppRouterDelegate>().setNewRoutePath(AppConfiguration(pages: [AppPageBookList(), AppPageBook(id: book.id)])),
                        },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
