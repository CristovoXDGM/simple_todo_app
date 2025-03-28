import 'package:go_router/go_router.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/pages/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
  ],
);
