enum Flavor { dev, prod }

class FlavorConfig {
  factory FlavorConfig({required Flavor flavor}) {
    _instance ??= FlavorConfig._internal(flavor);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor);

  final Flavor flavor;

  static FlavorConfig? _instance;

  static FlavorConfig get instance => _instance!;

  static bool isDev() => _instance!.flavor == Flavor.dev;
  static bool isProd() => _instance!.flavor == Flavor.prod;
}
