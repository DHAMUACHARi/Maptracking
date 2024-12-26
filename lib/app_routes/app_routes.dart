import 'package:go_router/go_router.dart';
import 'package:real_time_maps/ui/sign_in/sign_in_screen.dart';
import '../ui/dashboard/dashboard_screen.dart';
import '../ui/sign_out/sign_out_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) {
          final email = state.extra as String?;
          final password = state.extra as String?;
          return DashboardScreen(email: email ?? "No Email Provided");
        },
      ),
      GoRoute(
        path: '/sign_out',
        builder: (context, state) {
          final email = state.extra as String?;
          final password = state.extra as String?;
          return SignOutScreen(
            email: email ?? "No Email Provided",
          );
        },
      ),
    ],
  );
}
