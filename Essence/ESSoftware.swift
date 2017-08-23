//
//  System.swift
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
    // MARK: System/Software
    
    /// All the information about the system
    public struct Software {
        
        // MARK: Pasteboard
        
        /// Pasteboard information
        public struct Pasteboard {
            /// The current content of the clipboard (only string)
            public static var clipboardString: String? {
                return UIPasteboard.general.string
            }
        }
        
        // MARK: InfoPlist
        
        /// InfoPlist information
        public struct InfoPlist {
            
            public subscript (key: String) -> Any? {
                return Essence.Software.InfoPlist.value(for: key)
            }
            
            public static var infoPlist: [String: Any]? {
                return Bundle.main.infoDictionary
            }
            
            /// The current app version
            public static var version: String {
                return string(for: "CFBundleShortVersionString") ?? ""
            }
            
            /// The build number
            public static var build: String {
                return string(for: "CFBundleVersion") ?? ""
            }
            
            /// The complete app version with build number
            /// format: (i.e. : "2.1.3 (343)")
            public static var completeAppVersion: String {
                return "\(Essence.Software.InfoPlist.version) (\(Essence.Software.InfoPlist.build))"
            }
            
            /// Get the value from Info.plist
            ///
            /// - Parameter key: key string
            /// - Returns: value for the key
            public static func value(for key: String) -> Any? {
                return infoPlist?[key]
            }
            
            /// Get string value from Info.plist
            ///
            /// - Parameter key: key string
            /// - Returns: value for the key
            public static func string(for key: String) -> String? {
                return value(for: key) as? String
            }
            
            /// Get bool value from Info.plist
            ///
            /// - Parameter key: key string
            /// - Returns: value for the key
            public static func bool(for key: String) -> Bool {
                return (value(for: key) as? Bool) ?? false
            }
            
            /// Get integer value from Info.plist
            ///
            /// - Parameter key: key string
            /// - Returns: value for the key
            public static func integer(for key: String) -> Int? {
                return value(for: key) as? Int
            }
            
            /// Get float value from Info.plist
            ///
            /// - Parameter key: key string
            /// - Returns: value for the key
            public static func float(for key: String) -> Float? {
                return value(for: key) as? Float
            }
            
            /// Get double value from Info.plist
            ///
            /// - Parameter key: key string
            /// - Returns: value for the key
            public static func double(for key: String) -> Double? {
                return value(for: key) as? Double
            }
        }
        
        
        // MARK: Network
        
        /// Network information
        public struct Network {
            
            /// Check if the device is connected to the WiFi network
            public static var isConnectedViaWiFi: Bool {
                let reachability = ESReachability()!
                
                if reachability.isReachableViaWiFi {
                    return true
                } else {
                    return false
                }
            }
            
            /// Check if the device is connected to the cellular network
            public static var isConnectedViaCellular: Bool {
                
                return !isConnectedViaWiFi
            }
            
            public static var isInternetAvailable: Bool {
                
                return ESReachability()!.isReachable
            }
            
            /// Get the network SSID (doesn't work in the Simulator). Empty string if not available
            public static var SSID: String {
                
                // Doesn't work in the Simulator
                var currentSSID = ""
                if let interfaces:CFArray = CNCopySupportedInterfaces() {
                    for i in 0..<CFArrayGetCount(interfaces){
                        let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
                        let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                        let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
                        if unsafeInterfaceData != nil {
                            let interfaceData = unsafeInterfaceData! as Dictionary!
                            for dictData in interfaceData! {
                                if dictData.key as! String == "SSID" {
                                    currentSSID = dictData.value as! String
                                }
                            }
                        }
                    }
                }
                
                return currentSSID
            }
        }
        
        // MARK: Locale
        
        /// Locale information
        public struct Locale {
            
            /// The current language of the system
            public static var currentLanguage: String {
                
                return NSLocale.preferredLanguages[0]
            }
            
            /// The current Time Zone as TimeZone object
            public static var currentTimeZone: TimeZone {
                
                return TimeZone.current
            }
            
            /// The current Time Zone identifier
            public static var currentTimeZoneName: String {
                
                return TimeZone.current.identifier
            }
            
            /// The current country
            public static var currentCountry: String {
                
                return NSLocale.current.identifier
            }
            
            /// The current currency
            public static var currentCurrency: String? {
                
                return NSLocale.current.currencyCode
            }
            
            /// The current currency symbol
            public static var currentCurrencySymbol: String? {
                
                return NSLocale.current.currencySymbol
            }
            
            /// Check if the system is using the metric system
            public static var usesMetricSystem: Bool {
                
                return NSLocale.current.usesMetricSystem
            }
            
            /// The decimal separator
            public static var decimalSeparator: String? {
                
                return NSLocale.current.decimalSeparator
            }
        }
        
        // MARK: Carrier
        
        /// The Carrier information
        public struct Carrier {
            
            /// The name of the carrier or nil if not available
            public static var name: String? {
                
                let netInfo = CTTelephonyNetworkInfo()
                if let carrier = netInfo.subscriberCellularProvider {
                    return carrier.carrierName
                }
                
                return nil
            }
            
            /// The carrier ISO code or nil if not available
            public static var ISOCountryCode: String? {
                
                let netInfo = CTTelephonyNetworkInfo()
                if let carrier = netInfo.subscriberCellularProvider {
                    return carrier.isoCountryCode
                }
                
                return nil
            }
            
            /// The carrier mobile country code or nil if not available
            public static var mobileCountryCode: String? {
                
                let netInfo = CTTelephonyNetworkInfo()
                if let carrier = netInfo.subscriberCellularProvider {
                    return carrier.mobileCountryCode
                }
                
                return nil
            }
            
            /// The carrier network country code or nil if not available
            public static var mobileNetworkCode: String? {
                
                let netInfo = CTTelephonyNetworkInfo()
                if let carrier = netInfo.subscriberCellularProvider {
                    return carrier.mobileNetworkCode
                }
                
                return nil
            }
            
            /// Check if the carrier allows VOIP
            public static var allowsVOIP: Bool? {
                
                let netInfo = CTTelephonyNetworkInfo()
                if let carrier = netInfo.subscriberCellularProvider {
                    return carrier.allowsVOIP
                }
                
                return nil
            }
        }
    }
}
