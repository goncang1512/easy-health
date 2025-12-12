import 'package:easyhealth/provider/admin_provider.dart';
import 'package:easyhealth/provider/docter_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/screens/chatlist_screen.dart';
import 'package:easyhealth/screens/dashboard_screen.dart';
import 'package:easyhealth/screens/docter_dashboard.dart';
import 'package:easyhealth/screens/home_screen.dart';
import 'package:easyhealth/screens/list_booking_screen.dart'; // ← TAMBAH INI
import 'package:easyhealth/screens/list_docter_screen.dart';
import 'package:easyhealth/screens/notif_screen.dart';
import 'package:easyhealth/screens/profile_screen.dart';
import 'package:easyhealth/screens/search_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> buildBranches(String role) {
  return [
    // HOME
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Home",
          path: "/home",
          builder: (context, state) {
            if (role == "Admin") {
              final session = context.read<SessionManager>();
              return ChangeNotifierProvider(
                create: (_) => AdminProvider(session: session.session),
                child: DashboardScreen(),
              );
            } else if (role == "Docter") {
              return DocterDashboard();
            } else {
              return HomeScreen();
            }
          },
        ),
      ],
    ),

    // BOOKING
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Booking",
          path: '/booking',
          builder: (context, state) {
            if (role == "Admin") {
              final data = context.read<SessionManager>();
              return ChangeNotifierProvider(
                create: (_) => DocterProvider(session: data.session),
                child: ListDocterScreen(),
              );
            } else {
              /// PERUBAHAN ADA DI SINI ↓↓↓↓
              return ListBookingScreen();
            }
          },
        ),
      ],
    ),

    // SEARCH / MESSAGE
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: role == "Admin" ? "Pesan" : "Searching",
          path: role == "Admin" ? "/message" : '/search',
          builder: (context, state) {
            if (role == "Admin") {
              return ChatListScreen();
            } else {
              final keyword = state.uri.queryParameters['keyword'];
              return SearchScreen(keyword: keyword);
            }
          },
        ),
      ],
    ),

    // NOTIFICATION
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Notification",
          path: '/notification',
          builder: (context, state) => const NotifScreen(),
        ),
      ],
    ),

    // PROFILE
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Profile",
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ];
}
