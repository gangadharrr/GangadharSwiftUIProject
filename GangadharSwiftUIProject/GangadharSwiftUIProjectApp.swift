//
//  GangadharSwiftUIProjectApp.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/10/23.
//

import SwiftUI

@main
struct GangadharSwiftUIProjectApp: App {
    @Environment (\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            LaunchView()
            
        }.onChange(of: scenePhase){ phase in
            switch phase{
            case ScenePhase.active: break
            case ScenePhase.inactive: break
            case ScenePhase.background: break
            default:break
            }
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application:UIApplication, performFetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)->Void){
        
    }
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        
    }
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
