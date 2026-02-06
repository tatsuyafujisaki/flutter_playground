import 'firebase_options_prod.dart';
import 'flavor_config.dart';
import 'main_common.dart';

void main() async {
  FlavorConfig(flavor: Flavor.prod);
  await mainCommon(DefaultFirebaseOptions.currentPlatform);
}
