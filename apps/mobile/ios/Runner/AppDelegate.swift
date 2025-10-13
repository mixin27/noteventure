import Flutter
import UIKit
import workmanager_apple

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    WorkmanagerPlugin.registerBGProcessingTask(
        withIdentifier: "com.noteventure.sync"
    )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
