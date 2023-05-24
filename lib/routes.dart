import 'package:get/get.dart';
import 'package:crud/home.dart';

appRoutes() => [
  GetPage(
    name: '/home',
    page: () => const Home(),
    ),
];

class Middleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}