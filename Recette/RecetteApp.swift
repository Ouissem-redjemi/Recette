//
//  RecetteApp.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI
import Firebase

@main
struct RecetteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            let loginVM = LoginViewModel()
            ContentView()
                .environmentObject(loginVM)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     FirebaseApp.configure()
     return true
 }
}
