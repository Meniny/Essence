//
//  Hardware.swift
//  Essence
//
//  Created by Meniny on 2017-08-23.
//
//

import Foundation
import UIKit
import AVFoundation
import CoreMotion
import CoreTelephony
import ExternalAccessory
import SystemConfiguration.CaptiveNetwork

public extension Essence {
    // MARK: Hardware
    
    /// Hardware information
    public struct Hardware {
        
        // MARK: Screen
        
        /// Screen information
        public struct Screen {
            
            /// The current brightness
            public static var brightness: Float {
                return Float(UIScreen.main.brightness)
            }
            
            /// Check if the screen is being mirrored
            public static var isScreenMirrored: Bool {
                if let _ = UIScreen.main.mirrored {
                    return true
                }
                
                return false
            }
            
            /// The bounding rectange of the physical screen measured in pixels
            public static var nativeBounds: CGRect {
                
                return UIScreen.main.nativeBounds
            }
            
            /// The scale of the physical screen
            public static var nativeScale: Float {
                
                return Float(UIScreen.main.nativeScale)
            }
            
            /// The bounds of the current main screen
            public static var bounds: CGRect {
                
                return UIScreen.main.bounds
            }
            
            /// The scale of the current main screen
            public static var scale: Float {
                
                return Float(UIScreen.main.scale)
            }
            
            /// The snapshot of the current view after all the updates are applied
            public static var snapshotOfCurrentView: UIView {
                
                return UIScreen.main.snapshotView(afterScreenUpdates: true)
            }
        }
        
        
        // MARK: Device
        
        /// Device information
        public struct Device {
            
            /// The current device as Device object (see [Device](https://github.com/andrealufino/Device) library)
            public static var currentIDevice: iDevice {
                return iDevice.current
            }
            
            public static var currentUIDevice: UIDevice {
                return UIDevice.current
            }
            
            /// The identifier for vendor of the device
            public static var identifierForVendor: String? {
                return UIDevice.current.identifierForVendor?.uuidString
            }
            
            /// The current device orientation as UIDeviceOrientation
            public static var orientation: UIDeviceOrientation {
                return UIDevice.current.orientation
            }
            
            /// The name of the system
            public static var systemName: String {
                return UIDevice().systemName
            }
            
            /// The version of the system
            public static var systemVersion: String {
                return UIDevice().systemVersion
            }
            
            public static var isSimulator: Bool {
                return iDevice.isSimulator
            }
            
            public static var isPad: Bool {
                return iDevice.isPad
            }
            
            public static var isPhone: Bool {
                return iDevice.isPhone
            }
            
        }
        
        // MARK: Processor
        
        /// Processors information
        public struct Processor {
            /// Number of processors
            public static var count: Int {
                return ProcessInfo.processInfo.processorCount
            }
            
            /// Number of active processors
            public static var activedCount: Int {
                return ProcessInfo.processInfo.activeProcessorCount
            }
            
            public static var environment: [String : String] {
                return ProcessInfo.processInfo.environment
            }
            
            public static var arguments: [String] {
                return ProcessInfo.processInfo.arguments
            }
            
            public static var hostName: String {
                return ProcessInfo.processInfo.hostName
            }
            
            public static var processName: String {
                return ProcessInfo.processInfo.processName
            }
            
            public static var processIdentifier: Int32 {
                return ProcessInfo.processInfo.processIdentifier
            }
            
            public static var globallyUniqueString: String {
                return ProcessInfo.processInfo.globallyUniqueString
            }
        }
        
        // MARK: Memory
        
        /// Memory information
        public struct Memory {
            /// Physical memory of the device in megabytes
            public static func physicalMemory(scale: ESBytesSize = .bytes) -> Float {
                let physicalMemory = ProcessInfo.processInfo.physicalMemory
                
                switch scale {
                case .bytes:
                    return Float(physicalMemory)
                case .kilobytes:
                    return Float(physicalMemory * 1024)
                case .megabytes:
                    return Float(physicalMemory * 1024 * 1024)
                case .gigabytes:
                    return Float(physicalMemory * 1024 * 1024 * 1024)
                }
            }
        }
        
        // MARK: System
        
        /// System infomation
        public struct System {
            
            /// The name of the system
            public static var name: String {
                return UIDevice().systemName
            }
            
            /// The version of the system
            public static var version: String {
                return UIDevice().systemVersion
            }
            
            /// The current boot time expressed in seconds
            public static var bootTime: TimeInterval {
                return ProcessInfo().systemUptime
            }
            
            /// Check if the low power mode is currently enabled (iOS 9 and above)
            @available(iOS 9.0,*)
            public static var isLowPowerModeEnabled: Bool {
                return ProcessInfo().isLowPowerModeEnabled
            }
        }
        
        
        // MARK: Accessory
        
        /// Accessory information
        public struct Accessory {
            
            /// The number of connected accessories
            public static var count: Int {
                return EAAccessoryManager.shared().connectedAccessories.count
            }
            
            /// The names of the attacched accessories. If no accessory is attached the array will be empty, but not nil
            public static var connectedAccessoriesNames: [String] {
                var theNames: [String] = []
                
                for accessory in EAAccessoryManager.shared().connectedAccessories {
                    
                    theNames.append(accessory.name)
                }
                
                return theNames
            }
            
            /// The accessories connected and available to use for the app as EAAccessory objects
            public static var connectedAccessories: [EAAccessory] {
                return EAAccessoryManager.shared().connectedAccessories
            }
            
            /// Check if headphones are plugged in
            public static var isHeadsetPluggedIn: Bool {
                // !!!: Thanks to Antonio E., this code is coming from this SO answer : http://stackoverflow.com/a/21382748/588967 . I've only translated it in Swift
                let route = AVAudioSession.sharedInstance().currentRoute
                
                for desc in route.outputs {
                    if desc.portType == AVAudioSessionPortHeadphones {
                        return true
                    }
                }
                return false
            }
        }
        
        
        // MARK: Sensors
        
        /// Get info about the sensors
        public struct Sensors {
            
            /// Check if the accelerometer is available
            public static var isAccelerometerAvailable: Bool {
                
                return CMMotionManager.init().isAccelerometerAvailable
            }
            
            /// Check if gyroscope is available
            public static var isGyroAvailable: Bool {
                
                return CMMotionManager.init().isGyroAvailable
            }
            
            /// Check if magnetometer is available
            public static var isMagnetometerAvailable: Bool {
                
                return CMMotionManager.init().isMagnetometerAvailable
            }
            
            /// Check if device motion is available
            public static var isDeviceMotionAvailable: Bool {
                
                return CMMotionManager.init().isDeviceMotionAvailable
            }
        }
        
        // MARK: Disk
        
        /// Disk information
        public struct Disk {
            
            // The credits for these functions are to Cuong Lam for this SO answer : http://stackoverflow.com/a/29417855/588967
            private static func MBFormatter(_ bytes: Int64) -> String {
                let formatter = ByteCountFormatter()
                formatter.allowedUnits = ByteCountFormatter.Units.useMB
                formatter.countStyle = ByteCountFormatter.CountStyle.decimal
                formatter.includesUnit = false
                return formatter.string(fromByteCount: bytes) as String
            }
            
            /// The total disk space in string format (megabytes)
            public static var totalSpace: String {
                return ByteCountFormatter.string(fromByteCount: totalSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
            }
            
            /// The free disk space in string format (megabytes)
            public static var freeSpace: String {
                return ByteCountFormatter.string(fromByteCount: freeSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
            }
            
            /// The used disk space in string format (megabytes)
            public static var usedSpace: String {
                return ByteCountFormatter.string(fromByteCount: freeSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
            }
            
            /// The total disk space in bytes. 0 if something went wrong
            public static var totalSpaceInBytes: Int64 {
                do {
                    let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                    let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value
                    return space!
                } catch {
                    return 0
                }
            }
            
            /// The free disk space in bytes. 0 if something went wrong
            public static var freeSpaceInBytes: Int64 {
                do {
                    let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                    let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
                    return freeSpace!
                } catch {
                    return 0
                }
            }
            
            /// The used disk space in bytes. 0 if something went wrong
            public static var usedSpaceInBytes: Int64 {
                let usedSpace = totalSpaceInBytes - freeSpaceInBytes
                return usedSpace
            }
            
            /// The free disk space in percentage
            public static var freeSpaceInPercentage: Float {
                
                let freeSpace = Float(freeSpaceInBytes)
                let totalSpace = Float(totalSpaceInBytes)
                
                return (freeSpace * 100) / totalSpace
            }
            
            /// The used disk space in percentage
            public static var usedSpaceInPercentage: Float {
                
                let usedSpace = Float(usedSpaceInBytes)
                let totalSpace = Float(totalSpaceInBytes)
                
                return (usedSpace * 100) / totalSpace
            }
        }
        
        
        // MARK: Battery
        
        /// Battery information
        public struct Battery {
            
            private static var device: UIDevice {
                get {
                    let dev = UIDevice.current
                    dev.isBatteryMonitoringEnabled = true
                    
                    return dev
                }
            }
            
            /// The current level of the battery
            public static var level: Float? {
                
                let batteryCharge = device.batteryLevel
                if batteryCharge > 0 {
                    return batteryCharge * 100
                } else {
                    return nil
                }
            }
            
            /// The current battery state of the device
            public static var state: ESBatteryState {
                
                switch device.batteryState {
                case .unknown:
                    return ESBatteryState.unknown
                case .unplugged:
                    return ESBatteryState.unplugged
                case .charging:
                    return ESBatteryState.charging
                case .full:
                    return ESBatteryState.full
                }
            }
        }
    }
}
