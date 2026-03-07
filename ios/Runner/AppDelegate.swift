import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Get the Google Maps API key from the Info.plist
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_MAPS_PLATFORM_API_KEY") as? String {
            if !apiKey.isEmpty && apiKey != "$(GOOGLE_MAPS_PLATFORM_API_KEY)" {
                GMSServices.provideAPIKey(apiKey)
                print("✅ Successfully provided Google Maps API Key.")
            } else {
                print("⚠️ Warning: GOOGLE_MAPS_PLATFORM_API_KEY was found in Info.plist, but its value is either empty or the placeholder '$(GOOGLE_MAPS_PLATFORM_API_KEY)'. Check your Xcode build configuration and dart_defines.json.")
            }
        } else {
            print("🛑 Error: GOOGLE_MAPS_PLATFORM_API_KEY key not found in the app's Info.plist at all. Check that the key exists in ios/Runner/Info.plist.")
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
