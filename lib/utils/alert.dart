import 'package:easyhealth/config/global_key.dart';
import 'package:flutter/material.dart';

class Alert {
  static ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>?
  showBanner(String message, BuildContext context) {
    return rootScaffoldMessengerKey.currentState?.showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.red.shade100,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  static ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>?
  successBanner(String message, BuildContext context) {
    return rootScaffoldMessengerKey.currentState?.showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.green.shade100,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
