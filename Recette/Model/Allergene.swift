//  Allergene.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//
import Foundation




enum Allergene : String , CaseIterable, Identifiable {

    
    case arachide = "Arachide"
    case celeri = "Celeri"
    case crustace = "Crustacés"
    case soja = "Soja"
   
    

    var id: String { self.rawValue }
    static let allValues : [Allergene] = [arachide,celeri,crustace,soja]  
}
