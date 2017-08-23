//
//  ViewController.swift
//  Sample
//
//  Created by Meniny on 2017-08-23.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
import Essence

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // MARK: Software - Network
        
        print("------------\nNetwork\n------------")
        print("isConnectedViaCellular: \(Essence.isConnectedViaCellular)")
        print("isConnectedViaWiFi: \(Essence.isConnectedViaWiFi)")
        print("SSID: \(Essence.currentSSID)")
        
        
        // MARK: Software - Locale
        
        print("------------\nLocale\n------------")
        print("currentCountry: \(Essence.currentCountry)")
        print("currentCurrency: \(Essence.currentCurrency ?? "-")")
        print("currentCurrencySymbol: \(Essence.currentCurrencySymbol ?? "-")")
        print("currentLanguage: \(Essence.currentLanguage)")
        print("currentTimeZone: \(Essence.currentTimeZone)")
        print("currentTimeZoneName: \(Essence.currentTimeZoneName)")
        print("decimalSeparator: \(Essence.decimalSeparator ?? "-")")
        print("usesMetricSystem: \(Essence.usesMetricSystem)")
        
        
        // MARK: Software - Carrier
        
        print("------------\nCarrier\n------------")
        print("allowsVOIP: \(Essence.allowsVOIP ?? false)")
        print("ISOCountryCode: \(Essence.carrierISOCountryCode ?? "-")")
        print("mobileCountryCode: \(Essence.mobileCountryCode ?? "-")")
        print("name: \(Essence.carrierName ?? "-")")
        print("networkCountryCode: \(Essence.mobileNetworkCode ?? "-")")
        
        
        // MARK: Hardware
        
        // MARK: Hardware - Screen
        
        print("------------\nScreen\n------------")
        print("brightness: \(Essence.brightness)")
        print("bounds: \(Essence.screenBounds)")
        print("bounds: \(Essence.screenScale)")
        print("isScreenMirrored: \(Essence.isScreenMirrored)")
        print("nativeBounds: \(Essence.nativeScreenBounds)")
        print("nativeScale: \(Essence.nativeScreenScale)")
        print("snapshotOfCurrentView: \(Essence.snapshotView)")
        
        
        // MARK: Hardware - Device
        
        print("------------\nDevice\n------------")
        print("current: \(Essence.idevice)")
        print("identifierForVendor: \(Essence.identifierForVendor ?? "-")")
        print("orientation: \(Essence.orientation)")
        print("bootTime: \(Essence.bootTime)")
        print("bootTime: \(Essence.physicalMemory(scale: .megabytes))")
        print("processorsNumber: \(Essence.processorCount)")
        print("systemName: \(Essence.systemName)")
        print("systemVersion: \(Essence.systemVersion)")
        print("processHostName: \(Essence.processHostName)")
        if #available(iOS 9.0, *) {
            print("isLowPowerModeEnabled: \(Essence.isLowPowerModeEnabled)")
        }
        
        
        // MARK: Hardware - Accessory
        
        print("------------\nAccessory\n------------")
        print("connectedAccessories: \(Essence.connectedAccessories)")
        print("connectedAccessoriesNames: \(Essence.connectedAccessoriesNames)")
        print("count: \(Essence.accessoryCount)")
        print("isHeadsetPluggedIn: \(Essence.isHeadsetPluggedIn)")
        
        
        // MARK: Hardware - Sensors
        
        print("------------\nSensors\n------------")
        print("isAccelerometerAvailable : \(Essence.isAccelerometerAvailable)")
        print("isGyroAvailable : \(Essence.isGyroAvailable)")
        print("isMagnetometerAvailable : \(Essence.isMagnetometerAvailable)")
        print("isDeviceMotionAvailable : \(Essence.isDeviceMotionAvailable)")
        
        
        // MARK: Hardware - Disk
        
        print("------------\nDisk\n------------")
        print("freeSpace: \(Essence.diskSpaceLeft)")
        print("freeSpaceInBytes: \(Essence.diskSpaceLeftInBytes)")
        print("totalSpace: \(Essence.diskSpace)")
        print("totalSpaceInBytes: \(Essence.diskSpaceInBytes)")
        print("usedSpace: \(Essence.diskSpaceUsed)")
        print("usedSpaceInBytes: \(Essence.diskSpaceUsedInBytes)")
        print("freeSpaceInPercentage: \(Essence.diskSpaceLeftInPercentage)%")
        print("usedSpaceInPercentage: \(Essence.diskSpaceUsedInPercentage)%")
        
        
        // MARK: Hardware - Battery
        
        print("------------\nBattery\n------------")
        print("level: \(Essence.batteryLevel ?? -1)")
        print("state: \(Essence.batteryState)")
        
        
        // MARK: Software - Application
        
        print("------------\nApplication\n------------")
        print("clipboardString: \(Essence.clipboardString ?? "-")")
        print("version: \(Essence.appVersion)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
