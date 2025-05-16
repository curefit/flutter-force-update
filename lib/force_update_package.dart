library force_update_package;

export 'src/models/force_update_config.dart';
export 'src/services/force_update_service.dart';
export 'src/widgets/force_update_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'src/models/force_update_config.dart';
import 'src/services/force_update_service.dart';
import 'src/widgets/force_update_bottom_sheet.dart';

class ForceUpdate {
  static Future<void> checkForUpdate({
    required BuildContext context,
    ForceUpdateConfig? config,
    ForceUpdateService? updateService,
  }) async {
    final service = updateService ?? ForceUpdateService();
    await service.setDefaultConfigValues();

    final needsUpdate = await service.needsUpdate();
    if (needsUpdate && context.mounted) {
      final updateConfig = config ?? const ForceUpdateConfig();

      await showModalBottomSheet(
        context: context,
        isDismissible: !updateConfig.forcedUpdate,
        enableDrag: !updateConfig.forcedUpdate,
        builder: (context) => ForceUpdateBottomSheet(config: updateConfig),
      );
    }
  }
}
