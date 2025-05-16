class ForceUpdateConfig {
  final String title;
  final String message;
  final String updateButtonText;
  final String? laterButtonText;
  final bool forcedUpdate;
  final Function()? onUpdatePressed;
  final Function()? onLaterPressed;

  const ForceUpdateConfig({
    this.title = 'Update Required',
    this.message =
        'A new version of the app is available. Please update to continue using the app.',
    this.updateButtonText = 'Update Now',
    this.laterButtonText,
    this.forcedUpdate = true,
    this.onUpdatePressed,
    this.onLaterPressed,
  });

  ForceUpdateConfig copyWith({
    String? title,
    String? message,
    String? updateButtonText,
    String? laterButtonText,
    bool? forcedUpdate,
    Function()? onUpdatePressed,
    Function()? onLaterPressed,
  }) {
    return ForceUpdateConfig(
      title: title ?? this.title,
      message: message ?? this.message,
      updateButtonText: updateButtonText ?? this.updateButtonText,
      laterButtonText: laterButtonText ?? this.laterButtonText,
      forcedUpdate: forcedUpdate ?? this.forcedUpdate,
      onUpdatePressed: onUpdatePressed ?? this.onUpdatePressed,
      onLaterPressed: onLaterPressed ?? this.onLaterPressed,
    );
  }
}
