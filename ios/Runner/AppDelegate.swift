import FirebaseCore
import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        printEnvironmentVariables()

        FirebaseApp.configure()
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_MAPS_PLATFORM_API_KEY") as? String
        if let key = apiKey {
            GMSServices.provideAPIKey(key)
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func printEnvironmentVariables() {
        let environmentKeys = ["GOOGLE_MAPS_PLATFORM_API_KEY", "YOUTUBE_API_KEY"]

        print("🚀 Environment Variables from Info.plist:")
        for key in environmentKeys {
            if let value = Bundle.main.object(forInfoDictionaryKey: key) as? String {
                print("   \(key): \(value)")
            } else {
                print("   \(key): Not found")
            }
        }
    }
}
