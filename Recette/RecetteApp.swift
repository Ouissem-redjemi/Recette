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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    init(){
        FirebaseApp.configure()
    }
}
