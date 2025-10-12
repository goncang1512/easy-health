import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/models/stats_model.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:flutter/widgets.dart';

class AdminProvider with ChangeNotifier {
  UserSession? session;

  AdminProvider({this.session});

  Future<StatsDashboardModel?> getStatsDashboard() async {
    try {
      final result = await HTTP.get(
        "/api/admin/stats-today/${session?.hospital?.id}",
      );

      StatsDashboardModel data = StatsDashboardModel.fromJson(
        result['result'] as Map<String, dynamic>,
      );

      return data;
    } catch (error) {
      return null;
    }
  }
}
