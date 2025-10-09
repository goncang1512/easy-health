import 'package:easyhealth/provider/docter_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/screens/booking_screen.dart';
import 'package:easyhealth/screens/chatlist_screen.dart';
import 'package:easyhealth/screens/dashboard_screen.dart';
import 'package:easyhealth/screens/home_screen.dart';
import 'package:easyhealth/screens/list_docter_screen.dart';
import 'package:easyhealth/screens/notif_screen.dart';
import 'package:easyhealth/screens/profile_screen.dart';
import 'package:easyhealth/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> buildBranches(String role) {
  return [
    // Home, Booking, Searching, dll (tetap)
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Home",
          path: "/home",
          builder: (context, state) {
            if (role == "Admin") {
              return DashboardScreen();
            } else {
              return HomeScreen();
            }
          },
        ),
      ],
    ),
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
              return BookingScreen();
            }
          },
        ),
      ],
    ),
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

              debugPrint("HASIL ====== $keyword");

              return SearchScreen(keyword: keyword);
            }
          },
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: "Notification",
          path: '/notification',
          builder: (c, s) {
            return const NotifScreen();
          },
        ),
      ],
    ),
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
