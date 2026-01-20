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
        FirebaseApp.configure()
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_MAPS_PLATFORM_API_KEY") as? String
        if let key = apiKey {
            GMSServices.provideAPIKey(key)
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
