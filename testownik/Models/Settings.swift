//
//  Settings.swift
//  testownik
//
//  Created by Slawek Kurczewski on 15/09/2021.
//  Copyright © 2021 Slawomir Kurczewski. All rights reserved.
//

import Foundation


class Settings {
    enum SettingBundleEnum: String {
        case version_key        = "version_key"
        case speaking_key       = "speaking_key"
        case listening_key      = "listening_key"
        case dark_thema_key     = "dark_thema_key"
        case code_page_key      = "code_page_key"
        case language_key       = "language_key"
        case repeating_key      = "repeating_key"
        case delete_tests_key   = "delete_tests_key"
    
        case BuildVersionKey    = "build_preference"
        case AppVersionKey      = "version_preference"
        case BundleShortVersion = "CFBundleShortVersionString"
        case BundleVersion      = "CFBundleVersion"
    }
    enum LanguageEnum : String {
        case automatic = "automatic"
        case english   = "english"
        case german    = "german"
        case french    = "french"
        case spanish   = "spanish"
        case polish    = "polish"
    }
    enum CodePageEnum: String {
        case utf8    = "utf8"
        case iso9    = "iso9"
        case win1250 = "win1250"
    }
    enum RepeatingEnum: String {
        case repeating_a = "repeating_a"
        case repeating_b = "repeating_b"
        case repeating_c = "repeating_c"
        case repeating_d = "repeating_d"
        case repeating_e = "repeating_e"
        case repeating_f = "repeating_f"
    }
//    class func checkAndExecuteSettings() {
//        if UserDefaults.standard.bool(forKey: SettingBundleEnum.dark_thema_key.rawValue) {
//            UserDefaults.standard.set(false, forKey: SettingBundleEnum.dark_thema_key.rawValue)
//            let appDomain: String? = Bundle.main.bundleIdentifier
//            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
//        }
//    }
    class func setVersionAndBuildNumber() {
        let version = Bundle.main.object(forInfoDictionaryKey:  SettingBundleEnum.BundleShortVersion.rawValue)  //CFBundleShortVersionString
        UserDefaults.standard.set(version, forKey:  SettingBundleEnum.AppVersionKey.rawValue)
        let build = Bundle.main.object(forInfoDictionaryKey: SettingBundleEnum.BundleVersion.rawValue)
        UserDefaults.standard.set("\(version ?? 1) build \(build ?? 1)", forKey: SettingBundleEnum.version_key.rawValue )
    }
//--------
    class func getValue(boolForKey key: SettingBundleEnum) -> Bool {
        let val = UserDefaults.standard.bool(forKey: key.rawValue)
        print("Val \(key.rawValue):\(val)")
        return val
    }
     class func getValue(stringForKey key: SettingBundleEnum) -> String {
        var ret = ""
        if let val = UserDefaults.standard.object(forKey: key.rawValue) {
            print("STRIN:   \(val)")
            ret = "\(val)"
        }
        return ret
    }
    class func setValue(forKey key: SettingBundleEnum, newBoolValue value: Bool)  {
        UserDefaults.standard.set(value , forKey: key.rawValue)
    }
//    class func setValueBool(forKey key: SettingBundleEnum, newValue value: Bool)  {
//        UserDefaults.standard.set(value , forKey: key.rawValue)
//    }
    class func setValue(forKey key: SettingBundleEnum, newStringValue value: String) {
        UserDefaults.standard.set(value , forKey: key.rawValue)
    }
    class func setValue(forKey key: SettingBundleEnum, newIntValue value: Int) {
        UserDefaults.standard.set(value , forKey: key.rawValue)
    }
    class func reversBoolValue(forKey key: SettingBundleEnum) {
        let tmp = getValue(boolForKey: key)
        setValue(forKey: key, newBoolValue: !tmp)
    }

//    class func SetValue<T>(forKey key: SettingBundleEnum, newValue value: T) {
//        UserDefaults.standard.set(value , forKey: key.rawValue)
//    }
//---------------
    func registerSettingBundle() {
        let appDefaults = [String : AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    @objc func defaultsChanged() {
        if UserDefaults.standard.bool(forKey: "red_theme_key") {
           // self.view.backgroundColor = .red
            print("RedThemeKey")
        }
        else {
        //    self.view.backgroundColor = .white
            print("whiteThemaKey")
        }
    }
}
