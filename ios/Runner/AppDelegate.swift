import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsApiKey") as? String

        if let key = apiKey, !key.isEmpty {
            GMSServices.provideAPIKey(key)
        } else {
            print("⚠️ Warning: Google Maps API Key not found in Info.plist")
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func parseDartDefines() -> [String: String] {
        guard let dartDefinesString = Bundle.main.infoDictionary?["DART_DEFINES"] as? String,
            let data = Data(base64Encoded: dartDefinesString),
            let decoded = String(data: data, encoding: .utf8)
        else {
            return [:]
        }

        var results = [String: String]()
        for part in decoded.components(separatedBy: ",") {
            let components = part.components(separatedBy: "=")
            if components.count >= 2 {
                let key = components[0]
                let value = components.dropFirst().joined(separator: "=")
                results[key] = value
            }
        }
        return results
    }
}
