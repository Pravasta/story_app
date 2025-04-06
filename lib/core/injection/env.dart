enum Environment { development, production, staging, testing }

extension EnvironmentExtension on Environment {
  String get baseURL {
    switch (this) {
      case Environment.development:
        return 'story-api.dicoding.dev';
      case Environment.production:
        return 'story-api.dicoding.dev';
      case Environment.staging:
        return 'https://staging.com';
      case Environment.testing:
        return 'https://testing.com';
      default:
        return 'http://localhost:3000';
    }
  }

  bool get isDevelopMode {
    switch (this) {
      case Environment.development:
        return true;
      case Environment.production:
        return false;
      case Environment.staging:
        return false;
      case Environment.testing:
        return true;
      default:
        return true;
    }
  }
}
