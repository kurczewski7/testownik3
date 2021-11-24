//
//  AppDelegate.swift
//  Testownik
//
//  Created by Slawek Kurczewski on 14/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData
import CoreMedia

let speech = Speech()

//let coreData = CoreDataStack()
//let database = Database(context: coreData.persistentContainer.viewContext)

@UIApplicationMain
   class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("S T A R T\n")
        let ratings = Ratings()
       ratings.xxxxxx()
        let rr = ratings[2]
        rr?.correctionsToDo = 1963
        
        print("rr:\(rr)")
        ratings.printf()
        ratings[1] = rr
        ratings[2] = rr
        ratings.editRating(forIndex: 0) {
            $0.repetitionsToDo = 2021
            $0.lastAnswer = false
            $0.correctionsToDo = 1410
            return $0
        }
        ratings.editRating(forIndex: 3) { result in
            result.repetitionsToDo = 5555
            return result
        }

        ratings.editRating(forIndex: 11) { result in
            result.repetitionsToDo = 6666
            return result
        }
        
//        ratings.editRating(forIndex: 3) {
//            let nrFile = ratings
//        }
//        ratings.editRating(forIndex: 3) {
//            let tmp = self.
//            //tstResult.errorMultiple = 7
//            //return tstResult
//        }
      
        
        
        for i in 0..<Locale.preferredLanguages.count {
            print("System lang \(i):\(Locale.preferredLanguages[i])")
        }
        
        Locale.autoupdatingCurrent.languageCode
        print("App languae, Locale.autoupdatingCurrent.languageCode: \(Locale.autoupdatingCurrent.languageCode ?? "brak")")
        print("Settins dev, Locale.current:\(Locale.current.languageCode)")
        print("(Bundle.main.preferredLocalizations: \(Bundle.main.preferredLocalizations.first)")
        print("Locale.current.identifier: \(Locale.current.identifier)")
       
        
//        extension Locale {
//            static var preferredLanguageCode: String {
//                let defaultLanguage = "en"
//                let preferredLanguage = preferredLanguages.first ?? defaultLanguage
//                return Locale(identifier: preferredLanguage).languageCode ?? defaultLanguage
//            }
//
//            static var preferredLanguageCodes: [String] {
//                return Locale.preferredLanguages.compactMap({Locale(identifier: $0).languageCode})
//            }
//        }
        

        speech.setLanguae(selectedLanguage: 3)
        speech.startSpeak()
        
        let fullHomePath = NSHomeDirectory()
        print("fullHomePath = file:///\(fullHomePath)")
        //database.allTestsTable.loadData(fieldName: "user_name", fieldValue: "trzeci")
        database.allTestsTable.loadData()
        database.selectedTestTable.loadData()
        database.testDescriptionTable.loadData()
        database.ratingsTable.loadData()
        database.testListTable.loadData()
        
        print("allTestsTable.count:\(database.allTestsTable.count)\n")
        print("selectedTestTable.count:\(database.selectedTestTable.count)\n")
        print("testDescriptionTable.count:\(database.testDescriptionTable.count)\n")
        print("Test name:\(database.selectedTestTable[0]?.toAllRelationship?.user_name)")
        
        
        print("rr2:\(ratings[2]?.fileNumber),\(ratings[2]?.correctionsToDo)")
        ratings.printf()
        ratings.saveRatings()
        ratings.saveTestList()
        ratings.restoreRatings()
        ratings.restoreTestList()

  
        let newVal = Settings.CodePageEnum.iso9
        let listen = Settings.shared.getValue(boolForKey: .listening_key)
        let _ = Settings.shared.getValue(boolForKey: .dark_thema_key)
        let _ = Settings.shared.getValue(boolForKey:  .listening_key)
        let _ = Settings.shared.getValue(stringForKey: .language_key)
        
        Settings.shared.setValue(forKey: .listening_key, newBoolValue:  !listen)
        Settings.shared.setValue(forKey: .code_page_key, newStringValue: newVal.rawValue)
        Settings.shared.setValue(forKey: .dark_thema_key, newBoolValue: true)
        Settings.shared.setValue(forKey: .repeating_key, newStringValue: Settings.RepeatingEnum.repeating_c.rawValue)
        if database.selectedTestTable.count == 0 {
            let selTest = SelectedTestEntity(context: database.context)
            selTest.uuId = UUID()
            _ = database.selectedTestTable.add(value: selTest)
            database.save()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



}

