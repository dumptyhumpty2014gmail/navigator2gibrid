import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';

import 'app_router/app_router_delegate.dart';
import 'data/local_repository.dart';
import 'main_vm.dart';

void main() {
  ///чтобы в адрес не добавлялся символ #
  usePathUrlStrategy();
  runApp(const BooksApp());
}

class BooksApp extends StatefulWidget {
  const BooksApp({super.key});

  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  final LocalRepository localRepository = LocalRepository();
  late final MainVM vm = MainVM(localRepository: localRepository);
  late final AppRouterDelegate _routerDelegate = AppRouterDelegate(vm: vm);
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
        value: _routerDelegate,
        child: MaterialApp.router(
          title: 'Books App',
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
          backButtonDispatcher: AppBackBtnDispatcher(_routerDelegate),
          //routeInformationProvider: _routerInformationProvider,
        ),
      ),
    );
  }
}
