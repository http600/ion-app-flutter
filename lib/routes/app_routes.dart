part of 'app_pages.dart';

abstract class Routes {
  static const Home = 'meeting';
  static const NotFound = '/not-found';
}

extension RoutesExtension on String {
  String nameToRoute() => '/${toLowerCase()}';
}
