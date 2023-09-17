import 'package:go_router/go_router.dart';
import 'package:muix_player/presentation/screen/all_songs/all_songs.dart';
import 'package:muix_player/presentation/screen/dashboard/dashboard_player.dart';

// GoRouter Configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: DashboardPlayer.name,
      builder: (context, state) => const DashboardPlayer(),
    ),
    GoRoute(
      path: '/all-songs',
      name: AllSongs.name,
      builder: (context, state) => const AllSongs(),
    ),
  ]
);