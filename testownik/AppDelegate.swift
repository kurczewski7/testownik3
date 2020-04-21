//
//  AppDelegate.swift
//  Testownik
//
//  Created by Slawek Kurczewski on 14/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData


//let coreData = CoreDataStack()
//let database = Database(context: coreData.persistentContainer.viewContext)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //database.allTestsTable.loadData(fieldName: "user_name", fieldValue: "trzeci")
        database.allTestsTable.loadData()
        database.selectedTestTable.loadData()
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

