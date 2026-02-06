enum Flavor { dev, prod }

class FlavorConfig {
  factory FlavorConfig({required Flavor flavor, required String name}) {
    _instance ??= FlavorConfig._internal(flavor, name);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name);

  final Flavor flavor;
  final String name;

  static FlavorConfig? _instance;

  static FlavorConfig get instance => _instance!;

  static bool isDev() => _instance!.flavor == Flavor.dev;
  static bool isProd() => _instance!.flavor == Flavor.prod;
}
