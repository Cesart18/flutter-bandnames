

import 'package:band_names/pages/pages.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
    initialLocation: '/home',
  routes: [
    GoRoute(path: '/home',
    builder: (context, state) => const HomePage(),)
  ]);