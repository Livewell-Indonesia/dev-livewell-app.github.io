abstract class ForceUpdateRepository {
  Future<ForceUpdateStatus> getForceUpdate();
}

enum ForceUpdateStatus {
  none,
  optional,
  required,
}

extension ForceUpdateStatusExtension on ForceUpdateStatus {
  String get value {
    switch (this) {
      case ForceUpdateStatus.none:
        return 'none';
      case ForceUpdateStatus.optional:
        return 'minor';
      case ForceUpdateStatus.required:
        return 'required';
    }
  }

  static ForceUpdateStatus fromString(String value) {
    switch (value) {
      case 'none':
        return ForceUpdateStatus.none;
      case 'minor':
        return ForceUpdateStatus.optional;
      case 'major':
        return ForceUpdateStatus.required;
      default:
        return ForceUpdateStatus.none;
    }
  }
}
