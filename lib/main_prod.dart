import 'firebase_options_prod.dart';
import 'flavor_config.dart';
import 'main_common.dart';

void main() async {
  FlavorConfig(flavor: Flavor.prod, name: 'PROD');
  await mainCommon(DefaultFirebaseOptions.currentPlatform);
}
