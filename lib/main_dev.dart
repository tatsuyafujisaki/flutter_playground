import 'firebase_options_dev.dart';
import 'flavor_config.dart';
import 'main_common.dart';

void main() async {
  FlavorConfig(flavor: Flavor.dev, name: 'DEV');
  await mainCommon(DefaultFirebaseOptions.currentPlatform);
}
