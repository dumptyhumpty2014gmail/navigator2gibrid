import 'package:flutter/material.dart';

import 'app_page_url.dart';

abstract interface class IAppPageMixin {
  ///для вывода url
  AppPageUrl get pageUrl;

  ///получить parametrs
  Map<String, String> get queryParameters;
}

abstract class AppPage extends Page implements IAppPageMixin {}
///чтобы создать новую страницу необходимо
///1 Добавить соотвествующий элемент в enum AppPageUrl
///2 Создать класс, наследуюмый от AppPage и реализовать интерфейс IAppPageMixin
///3 Реализовать createRoute в новом классе
///4 При необходимости прописать статичные геттеры для параметров
///5 В AppRouteInformationParser прописать логику парсинга для новой страницы. Все возможные варианты