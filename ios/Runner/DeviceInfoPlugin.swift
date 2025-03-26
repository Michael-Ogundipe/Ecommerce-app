import Flutter
import UIKit

public class DeviceInfoPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "device_info", binaryMessenger: registrar.messenger())
        let instance = DeviceInfoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getDeviceInfo":
            let deviceInfo = getDeviceInformation()
            result(deviceInfo)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func getDeviceInformation() -> [String: Any] {
        let device = UIDevice.current

        return [
            "model": device.model,
            "systemName": device.systemName,
            "systemVersion": device.systemVersion,
            "name": device.name,
            "localizedModel": device.localizedModel
        ]
    }
}