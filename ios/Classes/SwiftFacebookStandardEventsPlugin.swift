import Flutter
import UIKit
import FBSDKCoreKit

public class SwiftFacebookStandardEventsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.halloglobal.facebook_standard_events/facebook_standard_events", binaryMessenger: registrar.messenger())
    let instance = SwiftFacebookStandardEventsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "logEvent":
        handleLogEvent(call, result)
        break;
    case "logPurchaseEvent":
        handlePurchaseLogEvent(call, result)
        break;
    default:
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
    private func handleLogEvent(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any] ?? [String: Any]()
        let eventName = arguments["name"] as! String
        let parameters = arguments["parameters"] as? [String: Any] ?? [String: Any]()
        if arguments["_valueToSum"] != nil && !(arguments["_valueToSum"] is NSNull) {
            let valueToDouble = arguments["_valueToSum"] as! Double
            AppEvents.logEvent(AppEvents.Name(eventName), valueToSum: valueToDouble, parameters: parameters)
        } else {
            AppEvents.logEvent(AppEvents.Name(eventName), parameters: parameters)
        }
        
        result(nil)
    }
    private func handlePurchaseLogEvent(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any] ?? [String: Any]()
        let purchaseAmount = arguments["purchaseAmount"] as! Double
        let parameters = arguments["parameters"] as? [String: Any] ?? [String: Any]()
        let currency = arguments["currency"] as! String

        AppEvent.purchased(amount: amount, currency: currency, extraParameters: parameters)
        
        result(nil)
    }
}
