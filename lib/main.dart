import 'package:flutter/material.dart';
import 'package:navigator2gibrid/platfrom_helpers/i_platform_helpers.dart';
import 'package:provider/provider.dart';

import 'app_router/app_router_delegate.dart';
import 'data/local_repository.dart';
import 'main_vm.dart';

void main() {
  ///чтобы в адрес не добавлялся символ #
  IPlatformHelper().pathUrlStrategy();
  runApp(const BooksApp());
}

class BooksApp extends StatefulWidget {
  const BooksApp({super.key});

  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  final LocalRepository localRepository = LocalRepository();
  final AppRouterDelegate _router = AppRouterDelegate();
  late final MainVM vm = MainVM(localRepository: localRepository, router: _router);
  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();
  //final AppmRouteInformationProvider _routerInformationProvider = AppmRouteInformationProvider();
  @override
  void initState() {
    startInit();
    super.initState();
  }

  Future<void> startInit() async {
    await localRepository.init();
    vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: ChangeNotifierProvider<AppRouterDelegate>.value(
        value: _router,
        child: MaterialApp.router(
          title: 'Books App',
          routerDelegate: _router,
          routeInformationParser: _routeInformationParser,
          backButtonDispatcher: AppBackBtnDispatcher(_router),
          //routeInformationProvider: _routerInformationProvider,
        ),
      ),
    );
  }
}
