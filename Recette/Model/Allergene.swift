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
    case gluten = "Céréales contenant du Gluten "
    case fruit_a_coque = "Fruits à coque "
    case lait = "Lait"
    case lupin = "Lupin"
    case oeuf = "Oeuf"
    case poisson = "Poisson"
    case mollusques = "Mollusques"
    case moutarde = "Moutarde"
    case sesame = "Sésame"
    case soja = "Soja "
    case sulfites = "Sulfites"
    case aucun = "Aucun"
 
    
    
   
    

    var id: String { self.rawValue }
    static let allValues : [Allergene] = [arachide,celeri,crustace,gluten,fruit_a_coque,lait,lupin, oeuf,poisson,mollusques,moutarde,sesame,soja,sulfites,aucun]
}
