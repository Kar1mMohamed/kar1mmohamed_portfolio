import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:kar1mmohamed_portfolio/screens/Home/home.dart';

class MainRouter {
  MainRouter._();

  // GoRouter configuration
  static final router = GoRouter(
    onException: (context, state, router) {
      log('Exception was thrown: ${state.error}');
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
