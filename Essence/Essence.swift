//
//  Essence.swift
//  Essence
//
//  Created by Andrea Mario Lufino on 20/10/16.
//
//

import Foundation
import UIKit
import AVFoundation
import CoreMotion
import CoreTelephony
import ExternalAccessory
import SystemConfiguration.CaptiveNetwork

// MARK: Essence

public class Essence {
    public static let author = "Elias Abel"
}

public extension Essence {
    public subscript (key: String) -> Any? {
        return Essence.Software.InfoPlist.value(for: key)
    }
}

// MARK: Types

/// The size scale to decide how you want to obtain size information
///
/// - bytes:     In bytes
/// - kilobytes: In kilobytes
/// - megabytes: In megabytes
/// - gigabytes: In gigabytes
public enum ESBytesSize {
    case bytes
    case kilobytes
    case megabytes
    case gigabytes
    
    public var key: String {
        switch self {
        case .bytes:
            return "bytes"
        case .kilobytes:
            return "kilobytes"
        case .megabytes:
            return "megabytes"
        case .gigabytes:
            return "gigabytes"
        }
    }
    
    public init?(key: String) {
        switch key {
        case "bytes":
            self = .bytes
            break
        case "kilobytes":
            self = .kilobytes
            break
        case "megabytes":
            self = .megabytes
            break
        case "gigabytes":
            self = .gigabytes
            break
        default:
            return nil
        }
    }
}

/// The battery state
///
/// - unknown:   State unknown
/// - unplugged: Battery is not plugged in
/// - charging:  Battery is charging
/// - full:      Battery is full charged
public enum ESBatteryState: Int {
    case unknown
    case unplugged
    case charging
    case full
    
    public var key: String? {
        switch self {
        case .unknown:
            return "unknown"
        case .unplugged:
            return "unplugged"
        case .charging:
            return "charging"
        case .full:
            return "full"
        }
    }
    
    public init(key: String) {
        switch key {
        case "unplugged":
            self = .unplugged
            break
        case "charging":
            self = .charging
            break
        case "full":
            self = .full
            break
        default:
            self = .unknown
            break
        }
    }
}

public extension Essence {
    
    /// The current brightness
    public static var brightness: Float {
        return ESScreen.brightness
    }
    
    /// Check if the screen is being mirrored
    public static var isScreenMirrored: Bool {
        return ESScreen.isScreenMirrored
    }
    
    /// The bounding rectange of the physical screen measured in pixels
    public static var nativeScreenBounds: CGRect {
        return ESScreen.nativeBounds
    }
    
    /// The scale of the physical screen
    public static var nativeScreenScale: Float {
        return ESScreen.nativeScale
    }
    
    /// The bounds of the current main screen
    public static var screenBounds: CGRect {
        return ESScreen.bounds
    }
    
    /// The scale of the current main screen
    public static var screenScale: Float {
        return ESScreen.scale
    }
    
    /// The snapshot of the current view after all the updates are applied
    public static var snapshotView: UIView {
        return UIScreen.main.snapshotView(afterScreenUpdates: true)
    }
    
    /// The current device as Device object (see [Device](https://github.com/andrealufino/Device) library)
    public static var idevice: iDevice {
        return ESDevice.currentIDevice
    }
    
    public static var uidevice: UIDevice {
        return ESDevice.currentUIDevice
    }
    
    /// The identifier for vendor of the device
    public static var identifierForVendor: String? {
        return ESDevice.identifierForVendor
    }
    
    /// The current device orientation as UIDeviceOrientation
    public static var orientation: UIDeviceOrientation {
        return ESDevice.orientation
    }
    
    /// The name of the system
    public static var systemName: String {
        return ESSystem.name
    }
    
    /// The version of the system
    public static var systemVersion: String {
        return ESSystem.version
    }
    
    /// Number of processors
    public static var processorCount: Int {
        return ESProcessor.count
    }
    
    /// Number of active processors
    public static var activeProcessorCount: Int {
        return ESProcessor.activedCount
    }
    
    public static var processEnvironment: [String : String] {
        return ESProcessor.environment
    }
    
    public static var processArguments: [String] {
        return ESProcessor.arguments
    }
    
    public static var processHostName: String {
        return ESProcessor.hostName
    }
    
    public static var processName: String {
        return ESProcessor.processName
    }
    
    public static var processIdentifier: Int32 {
        return ESProcessor.processIdentifier
    }
    
    public static var globallyProcessUniqueString: String {
        return ESProcessor.globallyUniqueString
    }
    
    /// Physical memory of the device in megabytes
    public static func physicalMemory(scale: ESBytesSize = .bytes) -> Float {
        return ESMemory.physicalMemory(scale: scale)
    }
    
    /// The current boot time expressed in seconds
    public static var bootTime: TimeInterval {
        return ESSystem.bootTime
    }
    
    /// Check if the low power mode is currently enabled (iOS 9 and above)
    @available(iOS 9.0,*)
    public static var isLowPowerModeEnabled: Bool {
        return ESSystem.isLowPowerModeEnabled
    }
    
    /// The number of connected accessories
    public static var accessoryCount: Int {
        return ESAccessory.count
    }
    
    /// The names of the attacched accessories. If no accessory is attached the array will be empty, but not nil
    public static var connectedAccessoriesNames: [String] {
        return ESAccessory.connectedAccessoriesNames
    }
    
    /// The accessories connected and available to use for the app as EAAccessory objects
    public static var connectedAccessories: [EAAccessory] {
        return ESAccessory.connectedAccessories
    }
    
    /// Check if headphones are plugged in
    public static var isHeadsetPluggedIn: Bool {
        return ESAccessory.isHeadsetPluggedIn
    }
    
    /// Check if the accelerometer is available
    public static var isAccelerometerAvailable: Bool {
        return ESSensors.isAccelerometerAvailable
    }
    
    /// Check if gyroscope is available
    public static var isGyroAvailable: Bool {
        return ESSensors.isGyroAvailable
    }
    
    /// Check if magnetometer is available
    public static var isMagnetometerAvailable: Bool {
        return ESSensors.isMagnetometerAvailable
    }
    
    /// Check if device motion is available
    public static var isDeviceMotionAvailable: Bool {
        return ESSensors.isDeviceMotionAvailable
    }
    
    /// The total disk space in string format (megabytes)
    public static var diskSpace: String {
        return ESDisk.totalSpace
    }
    
    /// The free disk space in string format (megabytes)
    public static var diskSpaceLeft: String {
        return ESDisk.freeSpace
    }
    
    /// The used disk space in string format (megabytes)
    public static var diskSpaceUsed: String {
        return ESDisk.usedSpace
    }
    
    /// The total disk space in bytes. 0 if something went wrong
    public static var diskSpaceInBytes: Int64 {
        return ESDisk.totalSpaceInBytes
    }
    
    /// The free disk space in bytes. 0 if something went wrong
    public static var diskSpaceLeftInBytes: Int64 {
        return ESDisk.freeSpaceInBytes
    }
    
    /// The used disk space in bytes. 0 if something went wrong
    public static var diskSpaceUsedInBytes: Int64 {
        return ESDisk.usedSpaceInBytes
    }
    
    /// The free disk space in percentage
    public static var diskSpaceLeftInPercentage: Float {
        return ESDisk.freeSpaceInPercentage
    }
    
    /// The used disk space in percentage
    public static var diskSpaceUsedInPercentage: Float {
        return ESDisk.usedSpaceInPercentage
    }
    
    /// The current level of the battery
    public static var batteryLevel: Float? {
        return ESBattery.level
    }
    
    /// The current battery state of the device
    public static var batteryState: ESBatteryState {
        return ESBattery.state
    }
}

public extension Essence {

    // MARK: Pasteboard
    /// The current content of the clipboard (only string)
    public static var clipboardString: String? {
        return UIPasteboard.general.string
    }
    
    // MARK: InfoPlist
    public static var infoPlist: [String: Any]? {
        return Bundle.main.infoDictionary
    }
    
    /// The current app version
    public static var appShotVersion: String {
        return ESInfoPlist.version
    }
    
    /// The build number
    public static var appBuildVersion: String {
        return ESInfoPlist.build
    }
    
    /// The complete app version with build number
    /// format: (i.e. : "2.1.3 (343)")
    public static var appVersion: String {
        return ESInfoPlist.completeAppVersion
    }
    
    /// Get the value from Info.plist
    ///
    /// - Parameter key: key string
    /// - Returns: value for the key
    public static func plistValue(for key: String) -> Any? {
        return ESInfoPlist.value(for: key)
    }
    
    /// Get string value from Info.plist
    ///
    /// - Parameter key: key string
    /// - Returns: value for the key
    public static func plistString(for key: String) -> String? {
        return ESInfoPlist.string(for: key)
    }
    
    /// Get bool value from Info.plist
    ///
    /// - Parameter key: key string
    /// - Returns: value for the key
    public static func plistBool(for key: String) -> Bool {
        return ESInfoPlist.bool(for: key)
    }
    
    /// Get integer value from Info.plist
    ///
    /// - Parameter key: key string
    /// - Returns: value for the key
    public static func plistInteger(for key: String) -> Int? {
        return ESInfoPlist.integer(for: key)
    }
    
    /// Get float value from Info.plist
    ///
    /// - Parameter key: key string
    /// - Returns: value for the key
    public static func plistFloat(for key: String) -> Float? {
        return ESInfoPlist.float(for: key)
    }
    
    /// Get double value from Info.plist
    ///
    /// - Parameter key: key string
    /// - Returns: value for the key
    public static func plistDouble(for key: String) -> Double? {
        return ESInfoPlist.double(for: key)
    }
    
    // MARK: Network
    
    /// Check if the device is connected to the WiFi network
    public static var isConnectedViaWiFi: Bool {
        return ESNetwork.isConnectedViaWiFi
    }
    
    /// Check if the device is connected to the cellular network
    public static var isConnectedViaCellular: Bool {
        return ESNetwork.isConnectedViaCellular
    }
    
    public static var isInternetAvailable: Bool {
        return ESNetwork.isInternetAvailable
    }
    
    /// Get the network SSID (doesn't work in the Simulator). Empty string if not available
    public static var currentSSID: String {
        return ESNetwork.SSID
    }
    
    // MARK: Locale
    
    /// The current language of the system
    public static var currentLanguage: String {
        return ESLocale.currentLanguage
    }
    
    /// The current Time Zone as TimeZone object
    public static var currentTimeZone: TimeZone {
        return ESLocale.currentTimeZone
    }
    
    /// The current Time Zone identifier
    public static var currentTimeZoneName: String {
        return ESLocale.currentTimeZoneName
    }
    
    /// The current country
    public static var currentCountry: String {
        return ESLocale.currentCountry
    }
    
    /// The current currency
    public static var currentCurrency: String? {
        return ESLocale.currentCurrency
    }
    
    /// The current currency symbol
    public static var currentCurrencySymbol: String? {
        return ESLocale.currentCurrencySymbol
    }
    
    /// Check if the system is using the metric system
    public static var usesMetricSystem: Bool {
        return ESLocale.usesMetricSystem
    }
    
    /// The decimal separator
    public static var decimalSeparator: String? {
        return ESLocale.decimalSeparator
    }
    
    // MARK: Carrier
    /// The name of the carrier or nil if not available
    public static var carrierName: String? {
        return ESCarrier.name
    }
    
    /// The carrier ISO code or nil if not available
    public static var carrierISOCountryCode: String? {
        return ESCarrier.ISOCountryCode
    }
    
    /// The carrier mobile country code or nil if not available
    public static var mobileCountryCode: String? {
        return ESCarrier.mobileCountryCode
    }
    
    /// The carrier network country code or nil if not available
    public static var mobileNetworkCode: String? {
        return ESCarrier.mobileNetworkCode
    }
    
    /// Check if the carrier allows VOIP
    public static var allowsVOIP: Bool? {
        return ESCarrier.allowsVOIP
    }
}

